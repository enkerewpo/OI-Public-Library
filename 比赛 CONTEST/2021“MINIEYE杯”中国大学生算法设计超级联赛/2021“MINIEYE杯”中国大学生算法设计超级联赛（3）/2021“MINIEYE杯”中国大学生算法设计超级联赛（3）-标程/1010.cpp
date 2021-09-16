#include<cstdio>
#include<algorithm>
using namespace std;
typedef pair<int,int>P;
const int N=1005,M=200005,V=1000;
int Case,n,m,i,f[N];P fl[V*2+5];
struct E{int x,y,w;}a[M],b[M];
inline bool cmp(const E&a,const E&b){return a.w<b.w;}
int F(int x){return f[x]==x?x:f[x]=F(f[x]);}
inline bool merge(int x,int y){
  if(F(x)==F(y))return 0;
  f[f[x]]=f[y];
  return 1;
}
inline void reduce(E*e){
  sort(e+1,e+m+1,cmp);
  for(int i=1;i<=n;i++)f[i]=i;
  for(int i=1,cnt=0;i<=m;i++)if(merge(e[i].x,e[i].y))e[++cnt]=e[i];
}
inline P call(int k){
  for(int i=1;i<=n;i++)f[i]=i;
  int A=1,B=1,sum=0,cnt=0;
  while(A<n&&B<n){
    if(a[A].w<=b[B].w+k){
      if(merge(a[A].x,a[A].y))sum+=a[A].w;
      A++;
    }else{
      if(merge(b[B].x,b[B].y))sum+=b[B].w+k,cnt++;
      B++;
    }
  }
  while(A<n){
    if(merge(a[A].x,a[A].y))sum+=a[A].w;
    A++;
  }
  while(B<n){
    if(merge(b[B].x,b[B].y))sum+=b[B].w+k,cnt++;
    B++;
  }
  return P(sum,cnt);
}
inline int ask(int k){
  for(int i=-V;i<=V;i++)if(fl[i+V].second<=k)return fl[i+V].first-k*i;
  return -1;
}
int main(){
  scanf("%d",&Case);
  while(Case--){
    scanf("%d%d",&n,&m);
    for(i=1;i<=m;i++){
      scanf("%d%d%d%d",&a[i].x,&a[i].y,&a[i].w,&b[i].w);
      b[i].x=a[i].x,b[i].y=a[i].y;
    }
    reduce(a);
    reduce(b);
    for(i=-V;i<=V;i++)fl[i+V]=call(i);
    for(i=0;i<n;i++)printf("%d\n",ask(i));
  }
}