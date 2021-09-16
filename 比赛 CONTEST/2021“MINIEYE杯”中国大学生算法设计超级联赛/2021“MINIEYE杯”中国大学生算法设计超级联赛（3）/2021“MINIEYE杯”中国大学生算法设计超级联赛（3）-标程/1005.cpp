#include<cstdio>
#include<algorithm>
#include<vector>
using namespace std;
typedef long long ll;
const int N=100005,M=N*21;
int Case,n,m,i,x,y,w[N],cnt,dfn1[N],dfn2[N],q[N],fin[N];bool vis[N];
vector<int>g[N];
struct P{
  int x,y;
  P(){}
  P(int _x,int _y){x=_x,y=_y;}
  P operator-(const P&b)const{return P(x-b.x,y-b.y);}
}a[N],pivot;
int tot,l[M],r[M];
struct E{
  ll sum;int root;
  E(){}
  E(ll _sum,int _root){sum=_sum,root=_root;}
}bit[N],tmp,ans;
inline ll cross(const P&a,const P&b){return 1LL*a.x*b.y-1LL*a.y*b.x;}
inline bool cmp(int x,int y){return cross(a[x]-pivot,a[y]-pivot)>0;}
int ins(int x,int a,int b,int c){
  int y=++tot;
  if(a==b)return y;
  int mid=(a+b)>>1;
  if(c<=mid)l[y]=ins(l[x],a,mid,c),r[y]=r[x];
  else l[y]=l[x],r[y]=ins(r[x],mid+1,b,c);
  return y;
}
inline bool smaller(int x,int y){
  if(x==y)return 0;
  int a=1,b=n,mid;
  while(a<b){
    mid=(a+b)>>1;
    if(l[x]==l[y]){
      a=mid+1;
      x=r[x];
      y=r[y];
    }else{
      b=mid;
      x=l[x];
      y=l[y];
    }
  }
  return x>y;
}
void go(int x,int a,int b){
  if(!x)return;
  if(a==b){
    fin[++cnt]=a;
    return;
  }
  int mid=(a+b)>>1;
  go(l[x],a,mid);
  go(r[x],mid+1,b);
}
inline void up(E&a,const E&b){
  if(a.sum>b.sum)return;
  if(a.sum<b.sum){a=b;return;}
  if(smaller(b.root,a.root))a.root=b.root;
}
void dfs1(int x){
  if(vis[x])return;
  vis[x]=1;
  for(int i=0;i<g[x].size();i++)dfs1(g[x][i]);
  dfn1[x]=++cnt;
}
void dfs2(int x){
  if(vis[x])return;
  vis[x]=1;
  for(int i=((int)g[x].size())-1;i>=0;i--)dfs2(g[x][i]);
  dfn2[x]=++cnt;
  q[cnt]=x;
}
inline void modify(int x,const E&p){for(;x<=n;x+=x&-x)up(bit[x],p);}
inline E ask(int x){E t(0,0);for(;x;x-=x&-x)up(t,bit[x]);return t;}
int main(){
  scanf("%d",&Case);
  while(Case--){
    scanf("%d%d",&n,&m);
    cnt=0;
    for(i=0;i<=n;i++){
      g[i].clear();
      vis[i]=0;
      bit[i]=E(0,0);
    }
    for(i=1;i<=n;i++)scanf("%d%d%d",&a[i].x,&a[i].y,&w[i]);
    while(m--)scanf("%d%d",&x,&y),g[x].push_back(y);
    for(i=1;i<=n;i++){
      pivot=a[i];
      sort(g[i].begin(),g[i].end(),cmp);
    }
    dfs1(1);
    for(cnt=0,i=1;i<=n;i++)vis[i]=0;
    dfs2(1);
    ans=E(0,0);
    for(i=n;i;i--){
      x=q[i];
      tmp=ask(dfn1[x]);
      tmp.sum+=w[x];
      tmp.root=ins(tmp.root,1,n,x);
      up(ans,tmp);
      modify(dfn1[x],tmp);
    }
    printf("%lld\n",ans.sum);
    cnt=0;
    go(ans.root,1,n);
    for(i=1;i<=cnt;i++)printf("%d%c",fin[i],i<cnt?' ':'\n');
    for(i=0;i<=tot;i++)l[i]=r[i]=0;
    tot=0;
  }
}