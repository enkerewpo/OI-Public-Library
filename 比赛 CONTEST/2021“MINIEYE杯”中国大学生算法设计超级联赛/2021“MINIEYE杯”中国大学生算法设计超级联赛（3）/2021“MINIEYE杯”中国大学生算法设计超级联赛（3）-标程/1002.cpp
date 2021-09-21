#include<cstdio>
#include<algorithm>
using namespace std;
typedef long long ll;
const int N=200010,M=100010*3,VAL=1000000;
int Case,n,m,i,j,x,y,z,g[N],v[N<<1],nxt[N<<1],ed;
int f[N],d[N],size[N],son[N],top[N],st[N],en[N],dfn;
int G[N],X[M],Y[M],W[M],NXT[M],ED;
ll base,ans,bit[N];
inline void add(int x,int y){v[++ed]=y;nxt[ed]=g[x];g[x]=ed;}
inline void ADD(int o,int x,int y,int z){X[++ED]=x;Y[ED]=y;W[ED]=z;NXT[ED]=G[o];G[o]=ED;}
void dfs(int x,int y){
  f[x]=y;
  d[x]=d[y]+1;
  size[x]=1;
  for(int i=g[x];i;i=nxt[i])if(v[i]!=y){
    dfs(v[i],x);
    size[x]+=size[v[i]];
    if(size[v[i]]>size[son[x]])son[x]=v[i];
  }
}
void dfs2(int x,int y){
  top[x]=y;
  st[x]=++dfn;
  if(son[x])dfs2(son[x],y);
  for(int i=g[x];i;i=nxt[i])if(v[i]!=f[x]&&v[i]!=son[x])dfs2(v[i],v[i]);
  en[x]=dfn;
}
inline int lca(int x,int y){
  while(top[x]!=top[y]){
    if(d[top[x]]<d[top[y]])swap(x,y);
    x=f[top[x]];
  }
  return d[x]<d[y]?x:y;
}
inline ll ask(int x){
  ll ret=0;
  x=st[x];
  for(;x;x-=x&-x)ret+=bit[x];
  return ret;
}
inline void modify(int x,ll p){for(;x<=n;x+=x&-x)bit[x]+=p;}
void go(int x){
  for(int i=g[x];i;i=nxt[i])if(v[i]!=f[x])go(v[i]);
  ll now=0;
  for(int i=G[x];i;i=NXT[i]){
    ll C=base+VAL-W[i],tmp=ask(X[i])+ask(Y[i])+now;
    if(C>tmp)now+=C-tmp;
  }
  ans+=now;
  modify(st[x],now);
  modify(en[x]+1,-now);
}
int main(){
  scanf("%d",&Case);
  while(Case--){
    scanf("%d%d",&n,&m);
    for(ed=ED=dfn=ans=i=0;i<=n;i++)g[i]=f[i]=d[i]=size[i]=son[i]=top[i]=G[i]=bit[i]=0;
    for(i=1;i<n;i++)scanf("%d%d",&x,&y),add(x,y),add(y,x);
    dfs(1,0);
    dfs2(1,1);
    for(i=1;i<=m;i++){
      scanf("%d",&x);
      for(j=0;j<3;j++)scanf("%d%d",&y,&z),ADD(lca(x,y),x,y,z);
    }
    base=1LL*m*VAL;
    go(1);
    if(ans/base==m){
      ans%=base;
      ans=base-ans;
    }else ans=-1;
    printf("%lld\n",ans);
  }
}