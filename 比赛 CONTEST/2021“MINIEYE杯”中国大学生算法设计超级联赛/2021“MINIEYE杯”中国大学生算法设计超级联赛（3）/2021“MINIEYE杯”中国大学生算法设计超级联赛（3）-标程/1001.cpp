#include<cstdio>
const int N=100010,M=N*73,inf=~0U>>1;
int Case,n,m,i,j,x,y,w[N],g[N],v[N<<1],nxt[N<<1],ed;
int f[N],d[N],size[N],son[N],top[N],loc[N],q[N],dfn;
int e[N],ga[N],gd[N],rga[N],rgd[N],V[M],NXT[M],ED;
inline void add(int x,int y){v[++ed]=y;nxt[ed]=g[x];g[x]=ed;}
inline void ADD(int&x,int y){V[++ED]=y;NXT[ED]=x;x=ED;}
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
  q[++dfn]=x;
  loc[x]=dfn;
  if(son[x])dfs2(son[x],y);
  for(int i=g[x];i;i=nxt[i])if(v[i]!=son[x]&&v[i]!=f[x])dfs2(v[i],v[i]);
}
inline void put(int x,int y,int z){
  while(top[x]!=top[y]){
    if(d[top[x]]>d[top[y]]){
      ADD(ga[loc[x]],z);
      ADD(gd[loc[top[x]]],z);
      x=f[top[x]];
    }else{
      ADD(rga[loc[top[y]]],z);
      ADD(rgd[loc[y]],z);
      y=f[top[y]];
    }
  }
  if(d[x]>d[y]){
    ADD(ga[loc[x]],z);
    ADD(gd[loc[y]],z);
  }else{
    ADD(rga[loc[x]],z);
    ADD(rgd[loc[y]],z);
  }
}
namespace DS{
int a[N],val[N],tag[N],son[N][2],f[N],root;
inline void add1(int x,int p){
  if(!x)return;
  val[x]+=p;
  tag[x]+=p;
}
inline void pb(int x){
  if(tag[x]){
    add1(son[x][0],tag[x]);
    add1(son[x][1],tag[x]);
    tag[x]=0;
  }
}
inline void rotate(int x){
  int y=f[x],w=son[y][1]==x;
  son[y][w]=son[x][w^1];
  if(son[x][w^1])f[son[x][w^1]]=y;
  if(f[y]){
    int z=f[y];
    if(son[z][0]==y)son[z][0]=x;
    if(son[z][1]==y)son[z][1]=x;
  }
  f[x]=f[y];son[x][w^1]=y;f[y]=x;
}
inline void splay(int x,int w){
  int s=1,i=x,y;a[1]=x;
  while(f[i])a[++s]=i=f[i];
  while(s)pb(a[s--]);
  while(f[x]!=w){
    y=f[x];
    if(f[y]!=w){if((son[f[y]][0]==y)^(son[y][0]==x))rotate(x);else rotate(y);}
    rotate(x);
  }
  if(!w)root=x;
}
inline void ask(int k){//splay first >= k to root
  int x=root,t,y=0;
  while(x){
    pb(y=x);
    if(val[x]>=k)t=x,x=son[x][0];else x=son[x][1];
  }
  if(t!=y)splay(y,0);
  splay(t,0);
}
inline void ins(int x){
  son[x][0]=son[x][1]=f[x]=tag[x]=0;
  int y=root;
  while(1){
    pb(y);
    int w=val[x]>val[y];
    if(!son[y][w]){
      son[y][w]=x;
      f[x]=y;
      break;
    }
    y=son[y][w];
  }
  splay(x,0);
}
inline void change(int k){
  while(1){
    ask(k);
    int x=root;
    if(val[x]<k*2){
      int y=son[x][1];
      while(son[y][0])y=son[y][0];
      splay(y,x);
      son[y][0]=son[x][0];
      f[y]=0;
      f[son[x][0]]=y;
      root=y;
      val[x]-=k;
      ins(x);
    }else{
      val[x]-=k;
      add1(son[x][1],-k);
      while(son[x][1])x=son[x][1];
      splay(x,0);
      val[x]=inf;
      return;
    }
  }
}
inline void init(){
  for(int i=m+1;i<=m+2;i++)son[i][0]=son[i][1]=f[i]=tag[i]=0;
  val[m+1]=-1;
  val[m+2]=inf;
  root=m+1;
  son[m+1][1]=m+2;
  f[m+2]=m+1;
}
inline void Del(int x){
  splay(x,0);
  e[x]=val[x];
  int A=son[x][0],B=son[x][1];
  f[A]=f[B]=0;
  while(son[A][1])A=son[A][1];
  splay(A,0);
  son[A][1]=B;
  f[B]=A;
}
inline void Ins(int x){
  val[x]=e[x];
  ins(x);
}
}
int main(){
  scanf("%d",&Case);
  while(Case--){
    scanf("%d%d",&n,&m);
    for(i=1;i<=n;i++)scanf("%d",&w[i]);
    for(i=0;i<=n;i++)g[i]=f[i]=d[i]=size[i]=son[i]=top[i]=ga[i]=gd[i]=rga[i]=rgd[i]=0;
    ed=dfn=ED=0;
    for(i=1;i<n;i++)scanf("%d%d",&x,&y),add(x,y),add(y,x);
    dfs(1,0);
    dfs2(1,1);
    for(i=1;i<=m;i++)scanf("%d%d%d",&x,&y,&e[i]),put(x,y,i);
    DS::init();
    for(i=n;i;i--){
      for(j=ga[i];j;j=NXT[j])DS::Ins(V[j]);
      DS::change(w[q[i]]);
      for(j=gd[i];j;j=NXT[j])DS::Del(V[j]);
    }
    for(i=1;i<=n;i++){
      for(j=rga[i];j;j=NXT[j])DS::Ins(V[j]);
      DS::change(w[q[i]]);
      for(j=rgd[i];j;j=NXT[j])DS::Del(V[j]);
    }
    for(i=1;i<=m;i++)printf("%d\n",e[i]);
  }
}