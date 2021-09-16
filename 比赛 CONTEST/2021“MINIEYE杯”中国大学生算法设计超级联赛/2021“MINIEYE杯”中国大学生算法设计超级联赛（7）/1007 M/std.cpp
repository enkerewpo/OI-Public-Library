#include <stdio.h>
#include <queue>
#define MN 100000
typedef long long ll;

int n,a[MN+5],din[MN+5];

void solve(){
	scanf("%d",&n);
	for(int i=1;i<=n;i++){
		din[i] = 0;
	}
	for(int i=1;i<=n;i++){
		scanf("%d",&a[i]);
		din[a[i]]++;
	}
	std::queue<int> Q;
	for(int i=1;i<=n;i++){
		if(din[i]==0) Q.push(i);
	}
	while(!Q.empty()){
		int u = Q.front();
		Q.pop();
		din[a[u]]--;
		if(din[a[u]]==0){
			Q.push(a[u]);
		}
	}
	ll p=-1,q=-1;
	for(int i=1;i<=n;i++){
		if(din[i]==0) continue;
		ll tp=0,tq=0;
		for(;din[i];i=a[i]){
			tp += i;
			tq++;
			din[i] = 0;
		}
		if(p==-1){
			p = tp;
			q = tq;
		}else{
			if(p*tq!=q*tp){
				puts("NO");
				return;
			}
		}
	}
	puts("YES");
	return;
}

int main(){
	int T;
	scanf("%d",&T);
	while(T--) solve();
}

