#include<bits/stdc++.h>
#define MAXN 805
#define MAXM 250005
#define INF 1000000000
#define MOD 1000000007
#define F first
#define S second
using namespace std;
typedef long long ll;
typedef pair<int,int> P;
int T,n,d;
int a[MAXN][MAXN];
vector<P> edges[MAXM];
int deg[MAXN];
P to[MAXN][MAXN];
int c[MAXM];
vector<pair<P,int> > ans;
void recolor(int u,int c1,int c2)
{
    int v=to[u][c1].F;
    int id=to[u][c1].S;
    to[v][c1]=to[u][c1]=P(0,0);
    c[id]=c2;
    to[u][c2]=P(v,id);
    if(to[v][c2].F==0)
    {
        to[v][c2]=P(u,id);
        return;
    }
    recolor(v,c2,c1);
    to[v][c2]=P(u,id);
}
void color(int id,int u,int v)
{
    for(int i=1;i<=d;i++)
    {
        if(!to[u][i].F&&!to[v][i].F)
        {
            c[id]=i;
            to[u][i]=P(v,id);
            to[v][i]=P(u,id);
            return;
        }
    }
    int x=-1,y=-1;
    for(int i=1;i<=d;i++)
    {
        if(!to[u][i].F) x=i;
        if(!to[v][i].F) y=i;
    }
    assert(x!=-1&&y!=-1);
    c[id]=x;
    to[u][x]=P(v,id);
    recolor(v,x,y);
    to[v][x]=P(u,id);
}
int main()
{
    scanf("%d",&T);
    int T1=0,T2=0;
    while(T--)
    {
        scanf("%d",&n);
        for(int i=1;i<=n;i++)
            for(int j=1;j<=n;j++)
            {
                scanf("%d",&a[i][j]);
                edges[a[i][j]].push_back(P(i,j));
            }
        d=0;
        for(int i=1;i<=n*n;i++)
        {
            for(auto p:edges[i]) {deg[p.F]++; deg[n+p.S]++; d=max(d,deg[p.F]); d=max(d,deg[n+p.S]);}
            for(auto p:edges[i]) {deg[p.F]--; deg[n+p.S]--;}
        }
        ans.clear();
        for(int i=1;i<=n*n;i++)
        {
            int tot=0;
            for(int j=0;j<(int)edges[i].size();j++) color(j,edges[i][j].F,n+edges[i][j].S);
            for(int j=0;j<(int)edges[i].size();j++)
            {
                int u=edges[i][j].F,v=edges[i][j].S+n,col=c[j];
                if(col!=1) {ans.push_back(make_pair(P(u,v-n),col-1));}
                to[u][col]=to[v][col]=P(0,0);
            }
        }
        for(int i=1;i<=n*n;i++) edges[i].clear();
        printf("%d %d\n",d-1,(int)ans.size());
        for(auto p:ans) printf("%d %d %d\n",p.F.F,p.F.S,p.S);
    }
    return 0;
}
