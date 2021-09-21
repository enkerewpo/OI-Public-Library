#include<bits/stdc++.h>
using namespace std;

const int P = 998244353;
int n;
char ch[200005];

int solve(vector<int> vec){
	vec.push_back(n+1);
	int ans=0,per=0,dif=0;
	for (int i=1;i<vec.size();i++){
		ans=(1ll*ans+1ll*per*(vec[i]-vec[i-1]))%P;
		dif=(1ll*dif+2ll*vec[i-1]+vec[i]-vec[i-1])%P;
		per=(per+dif)%P;	
	}
	return ans;
}

void solve(){
	scanf("%s",ch+1);
	n=strlen(ch+1);
	ch[n+1]='\0';
	vector<int> a[28];
	for (int i=0;i<=25;i++) a[i].push_back(0);
	for (int i=1;i<=n;i++) {
		a[ch[i]-'a'].push_back(i);
	}
	int ans=0;
	for (int i=0;i<=25;i++) {
		ans=(ans+solve(a[i]))%P;
	}
	printf("%d\n",ans);
}
int main(){
	int t;
	scanf("%d",&t);
	while (t--) solve();
}

