#include<bits/stdc++.h>
using namespace std;
int T;
long long l,r;
int x;
long long dp[30][1010][2][2];
int a[30];
int p10[30];
long long p9[30];
long long solve(long long n)
{ 
    for(int i=1;i<=19;i++)a[i]=n%10,n/=10;
    long long res=1;
    for(int i=19;i>=1;i--)
    {
        int cnt=0;
        for(int j=0;j<a[i];j++)cnt+=(j!=7);
        res+=p9[i-1]*cnt;
        if(a[i]==7)break;
    }
    for(int i=1;i<=19;i++)
    {
        if(a[i]==7)
        {
            res--;
            break;
        }
    }
    for(int t=1;t<x;t++)
    {
        for(int i=0;i<=19;i++)for(int j=0;j<x;j++)dp[i][j][0][0]=dp[i][j][0][1]=dp[i][j][1][0]=dp[i][j][1][1]=0;
        dp[19][0][1][1]=1;
        for(int i=19;i>=1;i--)
        {
            for(int j=0;j<x;j++)
            {
                for(int k=0;k<2;k++)
                {
                    for(int l=0;l<2;l++)
                    {
                        if(!dp[i][j][k][l])continue;
                        int mx=k?a[i]:9;
                        for(int d=0;d<=mx;d++)
                        {
                            if(d==7)continue;
                            int nj=(j*10+d)%x;
                            if(d || !l)if(!nj || (i>1 && nj*p10[i-1]%x==t))continue;
                            dp[i-1][nj][k&(d==mx)][l&(!d)]+=dp[i][j][k][l];
                        }
                    }
                }
            }
        }
        res-=dp[0][t][0][0]+dp[0][t][1][0];
    }
    return res;
}
int main()
{
    scanf("%d",&T);
    while(T--)
    {
        scanf("%lld%lld%d",&l,&r,&x);
        p10[0]=1%x;p9[0]=1;
        for(int i=1;i<=19;i++)p10[i]=p10[i-1]*10%x,p9[i]=9LL*p9[i-1];
        printf("%lld\n",solve(r)-solve(l-1));
    }
    return 0;
}
