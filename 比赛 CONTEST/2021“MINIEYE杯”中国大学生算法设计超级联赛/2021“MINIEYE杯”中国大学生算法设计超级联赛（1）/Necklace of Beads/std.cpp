#include<bits/stdc++.h>
using namespace std;
#define N 1000001
#define LL long long
#define MOD 998244353
LL n,k,ans,fac[N],inv[N],invfac[N],f[N],p[N],vis[N],prime[N],cnt,phi[N];
void pretype()
{
	phi[1]=p[0]=fac[0]=invfac[0]=inv[1]=fac[1]=invfac[1]=1;
	p[1]=2;
	for(LL i=2;i<N;i++)
	  {
	  if(!vis[i])prime[++cnt]=i,phi[i]=i-1;
	  for(LL j=1;j<=cnt && i*prime[j]<N;j++)
	    {
		vis[i*prime[j]]=1;
		if(i%prime[j]==0)
		  {
		  phi[i*prime[j]]=phi[i]*prime[j];
		  break;
		  } 
		phi[i*prime[j]]=phi[i]*(prime[j]-1);
		}
	  p[i]=p[i-1]*2ll%MOD;
	  fac[i]=fac[i-1]*i%MOD;
	  inv[i]=(MOD-MOD/i)*inv[MOD%i]%MOD;
	  invfac[i]=invfac[i-1]*inv[i]%MOD;
	  }
}
LL C(LL n,LL m)
{
	if(n<0 || m<0 || m>n)return 0;
	return fac[n]*invfac[m]%MOD*invfac[n-m]%MOD;
}
LL get(LL n,LL k)
{
	f[0]=n&1?0:2;
	for(LL m=1;m<=n;m++)
	  f[m]=(p[m]*(C(n-m,m)+C(n-m-1,m-1))+f[m-1])%MOD;
	return f[min(n,k)];
}
int main()
{
	pretype();
	int T;
	scanf("%d",&T);
	while(T--)
	  {
	  ans=0;
	  scanf("%lld%lld",&n,&k);
	  for(LL d=n;d>=1;d--)
	    if(n%d==0)
		  ans=(ans+phi[n/d]*get(d,k*d/n))%MOD;
	  printf("%lld\n",ans*inv[n]%MOD);
	  }
	return 0;
}
