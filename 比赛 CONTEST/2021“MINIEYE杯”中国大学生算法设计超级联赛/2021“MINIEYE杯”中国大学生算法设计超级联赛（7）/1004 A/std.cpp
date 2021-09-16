#include <stdio.h>
#define MN 2000000
typedef long long ll;
const int mod = 1000000007;

int fac[MN+5],inv[MN+5];

ll qpow(ll bsc,ll y){
	ll ret = 1;
	while(y){
		if(y&1) ret = ret*bsc%mod;
		bsc = bsc*bsc%mod;
		y >>= 1; 
	}
	return ret;
}

void init(){
	fac[0] = 1;
	for(int i=1;i<=MN;i++)
		fac[i] = (ll)fac[i-1]*i%mod;
	inv[MN] = qpow(fac[MN],mod-2);
	for(int i=MN-1;i>=0;i--)
		inv[i] = (ll)inv[i+1]*(i+1)%mod;
}

int C(int n,int m){
	if(m>n) return 0;
	return (ll)fac[n]*inv[m]%mod*inv[n-m]%mod;
}

void solve(){
	int n,m;
	scanf("%d%d",&n,&m);
	int ans = C(m+n,n)-C(m-1,n);
	if(ans<0) ans += mod;
	printf("%d\n",ans);
}

int main(){
	init();
	int T;
	scanf("%d",&T);
	while(T--) solve();
}
