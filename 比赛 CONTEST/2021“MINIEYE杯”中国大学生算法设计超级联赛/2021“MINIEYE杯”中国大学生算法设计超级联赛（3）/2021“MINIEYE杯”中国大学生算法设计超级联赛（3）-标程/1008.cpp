#include<cstdio>
#include<vector>
using namespace std;
typedef long long ll;
typedef pair<int,int>P;
typedef vector<P>V;
typedef pair<int,V>PI;
typedef vector<PI>VI;
const int N=100010,K=7,M=(N>>K)+5,MAXL=1005;
int Case,n,m,tot,i,j,x,y,st[M],en[M],Log[M];
struct E{int xl,xr,yl,yr;}e[N];
VI pre[N],suf[N],f[10][M];
//pool[i]:[pool[i-1].first,pool[i].first]
inline void addpoint(VI&pool,int x){
  int n=pool.size(),i;
  for(i=0;i<n;i++)if(pool[i].first==x)return;
  static PI now[MAXL];
  int m=0;
  for(i=0;i<n;i++)if(pool[i].first<x)now[m++]=pool[i];else break;
  now[m].first=x;
  now[m].second.clear();
  if(i<n)now[m].second=pool[i].second;
  for(m++;i<n;i++)now[m++]=pool[i];
  pool.resize(m);
  for(i=0;i<m;i++)pool[i]=now[i];
}
inline void addinterval(V&pool,int l,int r){
  static P now[MAXL];
  int n=pool.size(),i,m=0,L=0,R=-1;
  for(i=0;i<n;i++)if(pool[i].first<l){
    if(pool[i].first>R){
      if(L<R)now[m++]=P(L,R);
      L=pool[i].first;
    }
    if(R<pool[i].second)R=pool[i].second;
  }else break;
  if(l>R){
    if(L<R)now[m++]=P(L,R);
    L=l;
  }
  if(R<r)R=r;
  for(;i<n;i++){
    if(pool[i].first>R){
      if(L<R)now[m++]=P(L,R);
      L=pool[i].first;
    }
    if(R<pool[i].second)R=pool[i].second;
  }
  if(L<R)now[m++]=P(L,R);
  pool.resize(m);
  for(i=0;i<m;i++)pool[i]=now[i];
}
inline void ext(VI&pool,const E&p){
  addpoint(pool,p.xl);
  addpoint(pool,p.xr);
  int n=pool.size(),i,m=0;
  for(i=1;i<n;i++)if(pool[i-1].first>=p.xl&&pool[i].first<=p.xr)addinterval(pool[i].second,p.yl,p.yr);
  for(i=0;i<n;i++){
    while(m&&pool[m-1].second==pool[i].second)m--;
    pool[m++]=pool[i];
  }
  pool.resize(m);
}
inline void mergeinterval(const V&A,const V&B,V&C){
  int ca=A.size(),cb=B.size(),i=0,j=0,m=0,L=0,R=-1;P tmp;
  static P now[MAXL];
  while(i<ca||j<cb){
    if(i>=ca)tmp=B[j++];
    else if(j>=cb)tmp=A[i++];
    else tmp=A[i].first<B[j].first?A[i++]:B[j++];
    if(tmp.first>R){
      if(L<R)now[m++]=P(L,R);
      L=tmp.first;
    }
    if(R<tmp.second)R=tmp.second;
  }
  if(L<R)now[m++]=P(L,R);
  C.resize(m);
  for(i=0;i<m;i++)C[i]=now[i];
}
inline void mergepool(const VI&A,const VI&B,VI&C){
  int ca=A.size(),cb=B.size(),cc=0,i=0,j=0,m=0;
  static PI now[MAXL];
  while(i<ca&&j<cb){
    mergeinterval(A[i].second,B[j].second,now[cc].second);
    if(A[i].first<B[j].first)now[cc++].first=A[i++].first;
    else if(A[i].first>B[j].first)now[cc++].first=B[j++].first;
    else{
      now[cc++].first=A[i++].first;
      j++;
    }
  }
  while(i<ca)now[cc++]=A[i++];
  while(j<cb)now[cc++]=B[j++];
  for(i=0;i<cc;i++){
    while(m&&now[m-1].second==now[i].second)m--;
    now[m++]=now[i];
  }
  C.resize(m);
  for(i=0;i<m;i++)C[i]=now[i];
}
inline ll ask(const VI&pool){
  ll ans=0;
  for(int i=1;i<pool.size();i++){
    int tmp=0,n=pool[i].second.size();
    for(int j=0;j<n;j++)tmp+=pool[i].second[j].second-pool[i].second[j].first;
    ans+=1LL*tmp*(pool[i].first-pool[i-1].first);
  }
  return ans;
}
inline ll query(int l,int r){
  int L=l>>K,R=r>>K,i;
  VI pool;
  if(L==R)for(i=l;i<=r;i++)ext(pool,e[i]);
  else{
    mergepool(suf[l],pre[r],pool);
    L++,R--;
    if(L<=R){
      i=Log[R-L+1];
      mergepool(f[i][L],pool,pool);
      mergepool(f[i][R-(1<<i)+1],pool,pool);
    }
  }
  return ask(pool);
}
int main(){
  scanf("%d",&Case);
  for(i=2;i<M;i++)Log[i]=Log[i>>1]+1;
  while(Case--){
    scanf("%d%d",&n,&m);
    tot=n>>K;
    for(i=1;i<=n;i++)en[i>>K]=i;
    for(i=n;i;i--)st[i>>K]=i;
    for(i=1;i<=n;i++)scanf("%d%d%d%d",&e[i].xl,&e[i].yl,&e[i].xr,&e[i].yr);
    for(i=0;i<=tot;i++){
      x=st[i],y=en[i];
      VI pool;
      for(j=x;j<=y;j++){
        ext(pool,e[j]);
        pre[j]=pool;
      }
      pool.clear();
      for(j=y;j>=x;j--){
        ext(pool,e[j]);
        suf[j]=pool;
      }
      f[0][i]=pre[y];
    }
    for(i=1;(1<<i)<=tot+1;i++)for(j=0;j+(1<<i)-1<=tot;j++)mergepool(f[i-1][j],f[i-1][j+(1<<(i-1))],f[i][j]);
    while(m--){
      scanf("%d%d",&x,&y);
      printf("%lld\n",query(x,y));
    }
  }
}