#include <bits/stdc++.h>
using namespace std;

int T;
char s[35][105];
int cnt[105];
int ansl[10],ansr[10];

int main()
{
    scanf("%d",&T);
    for (int tt=1;tt<=T;tt++)
    {
        memset(cnt,0,sizeof(cnt));
        for (int i=1;i<=30;i++)
        {
            scanf("%s",s[i]+1);
            for (int j=1;j<=100;j++)
            {
                if (s[i][j]=='#') cnt[j]++;
            }
        }
        int pos=100;
        for (int i=7;i>=2;i--)
        {
            while (pos>=1 && !cnt[pos]) pos--;
            ansr[i]=pos;
            while (pos>=1 && cnt[pos]) pos--;
            ansl[i]=pos+1;
        }
        while (pos>=1 && !cnt[pos]) pos--;
        ansr[1]=pos;
        pos=1;
        while (pos<=100 && !cnt[pos]) pos++;
        ansl[1]=pos;
        printf("Case #%d:\n",tt);
        for (int i=1;i<=7;i++)
        {
            printf("%d %d\n",ansl[i],ansr[i]);
        }
    }
    return 0;
}