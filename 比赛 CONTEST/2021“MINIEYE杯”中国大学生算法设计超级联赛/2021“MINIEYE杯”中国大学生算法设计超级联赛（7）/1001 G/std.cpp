#include <stdio.h>
#include <string.h>
#include <algorithm>
#include <bitset>
#include <vector>
#define MN 100000

int n,k;
char s[MN+5];
std::vector<int> factors;

bool check(int pLen){
	//printf("check(%d)\n",pLen);
	static int cnt[26];
	static std::bitset<MN+5> bs[26];
	memset(cnt,0,sizeof(cnt));
	for(int i=1;i<=pLen;i++)
		cnt[s[i]]++;
	//process bs array
	for(int i=0;i<26;i++)
		bs[i].reset();
	for(int factor:factors){
		if(factor<cnt[0]) continue;
		if(factor-cnt[0]>n) break;
		bs[0][factor-cnt[0]] = 1;
	}
	for(int i=1;i<=25;i++){
		for(int factor:factors){
			if(factor<cnt[i]) continue;
			if(factor-cnt[i]>n) break;
			bs[i] |= bs[i-1]<<(factor-cnt[i]);
		}
	}
	//check answer
	for(int c=25;c>=0;c--){
		while(s[pLen+1]==c){
			++pLen;
			cnt[c]++;
		}
		if(s[pLen+1]>c) break;
		for(int factor:factors){
			if(factor<=cnt[c]) continue;
			int unknownLength = n-(pLen-cnt[c]+factor);
			if(unknownLength<0) break;
			if(c==0){
				//printf("checking pLen = %d\n",pLen);
				if(unknownLength==0) return true;
			}else{
				//printf("checking pLen = %d\n",pLen);
				if(bs[c-1][unknownLength]) return true;
			}
		}
		if(cnt[c]&&k%cnt[c]){
			//printf("failed | prefix has %d x %d, but %d is not a factor of k\n",cnt[c],c,cnt[c]);
			return false;
		}
	}
	//puts("failed");
	return false;
}

bool checkn(){
	static int cnt[26];
	memset(cnt,0,sizeof(cnt));
	for(int i=1;i<=n;i++)
		cnt[s[i]]++;
	for(int i=0;i<26;i++)
		if(cnt[i]&&k%cnt[i]) return false;
	return true;
}

int findMaxPrefixLength(){
	if(checkn()) return n;
	int l=0,r=n,mid;
	while(l<=r){
		mid = (l+r)>>1;
		if(check(mid))
			l = mid+1;
		else
			r = mid-1;
	}
	return r;
}

void generateMinString(int pLen){
	static int cnt[26];
	static std::bitset<MN+5> bs[26];
	memset(cnt,0,sizeof(cnt));
	for(int i=1;i<=pLen;i++)
		cnt[s[i]]++;
	++pLen;
	for(int c=s[pLen]+1;c<=25;c++){
		cnt[c]++;
		s[pLen] = c;
		for(int i=0;i<26;i++)
			bs[i].reset();
		for(int factor:factors){
			int toUse = factor-cnt[25];
			if(toUse<0) continue;
			if(toUse+pLen>n) break;
			bs[25][toUse] = 1;
		}
		for(int i=24;i>=0;i--){
			for(int factor:factors){
				int toUse = factor-cnt[i];
				if(toUse<0) continue;
				if(toUse+pLen>n) break;
				bs[i] |= bs[i+1]<<(toUse);
			}
		}
		if(bs[0][n-pLen]){
			//printf("successed when s[%d] = %d\n",pLen,s[pLen]);
			std::reverse(factors.begin(),factors.end());
			int cur = n-pLen;
			for(int i=0;i<=24;i++){
				for(int factor:factors){
					int toUse = factor-cnt[i];
					if(toUse>cur) continue;
					if(toUse<0) break;
					if(!bs[i+1][cur-toUse]) continue;
					cur -= toUse;
					while(toUse--) s[++pLen] = i;
					break;
				}
			}
			while(pLen<=n) s[++pLen] = 25;
			return;
		}
		cnt[c]--;
	}
	puts("Unable to generate the target string.(this message should not be printed)");
}

void solve(){
	scanf("%d%d%s",&n,&k,&s[1]);
	for(int i=1;i<=n;i++)
		s[i] -= 'a';
	s[n+1] = -1;
	factors.clear();
	for(int i=1;i*i<=k;i++){
		if(k%i==0){
			factors.push_back(i);
			if(i*i!=k) factors.push_back(k/i);
		}
	}
	factors.push_back(0);
	std::sort(factors.begin(),factors.end());
	int maxPrefixLength = findMaxPrefixLength();
	//fprintf(stderr,"maxPrefixLength is %d\n",maxPrefixLength);
	if(maxPrefixLength==-1){
		puts("-1");
	}else{
		if(maxPrefixLength!=n)
			generateMinString(maxPrefixLength);
		for(int i=1;i<=n;i++)
			s[i] += 'a';
		s[n+1] = '\0';
		puts(&s[1]);
	}
}

int main(){
	int T; scanf("%d",&T);
	while(T--) solve();
}

