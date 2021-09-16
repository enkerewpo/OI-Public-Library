#include<bits/stdc++.h>
using namespace std;
const int md=998244353;
int n,k,T;
char s[1000010];
int fac[1000010],inv[1000010];
int p10[1000010];
int C(int x,int y)
{
    if(x<y || y<0)return 0;
    return 1LL*fac[x]*inv[x-y]%md*inv[y]%md;
}
int qpow(int x,int p)
{
    int res=1;
    for(;p;p>>=1,x=1LL*x*x%md)if(p&1)res=1LL*res*x%md;
    return res;
}
int ans;
int f[1000010],g[1000010];
int main()
{
    scanf("%d",&T);
    while(T--)
    {
        scanf("%d",&k);
        scanf("%s",s);
        n=strlen(s); 
        fac[0]=1;
        for(int i=1;i<=n;i++)fac[i]=1LL*fac[i-1]*i%md;
        p10[0]=1;
        for(int i=1;i<=n;i++)p10[i]=10LL*p10[i-1]%md;
        inv[n]=qpow(fac[n],md-2);
        for(int i=n-1;i>=0;i--)inv[i]=1LL*inv[i+1]*(i+1)%md;
        int sum=0;
        f[0]=(k>=2)?1:0;
        g[0]=1;
        ans=0;
        for(int i=1;i<=n;i++)f[i]=((f[i-1]+f[i-1])%md+md-C(i-1,k-2))%md,g[i]=((g[i-1]+g[i-1])%md+md-C(i-1,k-1))%md;
        for(int i=n-1;i>=0;i--)
        {
            if(i<n-1)sum=(sum+1LL*p10[n-2-i]*f[i]%md)%md;
            ans=(ans+1LL*(s[i]-'0')*(sum+1LL*p10[n-1-i]*g[i]%md)%md)%md;
        }
        printf("%d\n",ans);
    }
    return 0;
} 
