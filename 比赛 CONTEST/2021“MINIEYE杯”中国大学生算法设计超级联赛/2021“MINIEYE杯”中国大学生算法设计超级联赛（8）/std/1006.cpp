#include<bits/stdc++.h>
using namespace std;
int num[10000010];
int prm[10000010],cnt;
bool f[10000010];
int t,n;
int main()
{
    for(int i=2;i<=10000000;i++)
    {
        if(!f[i])prm[++cnt]=i,num[i]=1;
        for(int j=1;j<=cnt && i*prm[j]<=10000000;j++)
        {
            f[i*prm[j]]=true;
            num[i*prm[j]]=num[i]+1;
            if(i%prm[j]==0)break;
        }
    }
    scanf("%d",&t);
    while(t--)
    {
        int ans=0;
        scanf("%d",&n);
        for(int i=1;i<=n;i++)
        {
            int x;
            scanf("%d",&x);
            ans^=num[x];
        }
        if(ans)puts("Alice");else puts("Bob");
    }
    return 0;
}
