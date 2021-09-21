#include<bits/stdc++.h>
using namespace std;
#define N 6000010
#define LL long long
#define MOD 1000000007
int T,n,a[110],f[N];
LL k,y[110],pre[110],suf[110],inv[110];
LL Lagrange(LL x)
{
    LL res=0;
    pre[0]=suf[n+1]=1;
    for(int i=1;i<=n;i++)
      pre[i]=1ll*pre[i-1]*((x-i)%MOD)%MOD;
    for(int i=n;i>=1;i--)
      suf[i]=1ll*suf[i+1]*((x-i)%MOD)%MOD;
    for(int i=1;i<=n;i++)
      {
      int l=1ll*pre[i-1]*suf[i+1]%MOD*inv[n-i]%MOD*inv[i-1]%MOD;
      l=1ll*l*y[i]%MOD;
      if((n^i)&1)l=MOD-l;
      res=(res+l)%MOD;
      }
    return res;
}
int main()
{
	inv[0]=inv[1]=f[0]=1;
	for(LL i=2;i<110;i++)inv[i]=1ll*(MOD-MOD/i)*inv[MOD%i]%MOD;
	for(LL i=2;i<110;i++)inv[i]=inv[i]*inv[i-1]%MOD;
	scanf("%d",&T);
	while(T--){
		scanf("%d%lld",&n,&k);
		for(int i=1;i<=n;i++)scanf("%d",&a[i]);
		int lcm=a[1];
		for(int i=2;i<=n;i++){
			int d=__gcd(lcm,a[i]);
			lcm=lcm*a[i]/d;
		}
		for(int i=1;i<=n*lcm;i++)f[i]=0;
		for(int j=1;j<=n;j++){
			for(int i=a[j];i<=n*lcm;i++){
				f[i]=(f[i]+f[i-a[j]])%MOD;
			}
		}
		if(k<=n*lcm){
			printf("%d\n",f[k]);
			continue;
		}
		for(int i=k%lcm;i<n*lcm;i+=lcm)y[i/lcm+1]=f[i];
		printf("%lld\n",Lagrange(k/lcm+1));
	}
}
