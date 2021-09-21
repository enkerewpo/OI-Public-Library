#include<cstdio>
#include<map>
#include<algorithm>
using namespace std;
typedef long long ll;
const int N=305,P=1000000007;
int Case,n,m,i,w[N];
inline void up(int&a,int b){a=a+b<P?a+b:a+b-P;}
inline void upl(int&a,ll b){a=(a+b)%P;}
namespace SMALL{
const int MAXL=121505;
int cnt,q[MAXL],g[MAXL][2];
map<int,int>id;
int pre[MAXL],now[MAXL];
inline void clr(){for(int i=1;i<=cnt;i++)now[i]=0;}
inline void nxt(){for(int i=1;i<=cnt;i++)pre[i]=now[i];}
void dfs(int x,int S){
  if(x==m){
    id[S]=++cnt;
    q[cnt]=S;
    return;
  }
  dfs(x+1,S<<1);
  if(!(S&1))dfs(x+1,S<<1|1);
}
void solve(){
  //m<=24
  cnt=0;
  id.clear();
  dfs(0,0);
  int i,j,S,T,x;
  for(i=1;i<=cnt;i++){
    S=q[i],T=(S<<1)&((1<<m)-1);
    g[i][0]=id[T];
    g[i][1]=0;
    if(!(S>>(m-1)&1))g[i][1]=id[T|1];
  }
  clr();
  now[1]=1;
  nxt();
  for(i=0;i<n;i++){
    clr();
    x=w[i];
    for(j=1;j<=cnt;j++){
      up(now[g[j][0]],pre[j]);
      upl(now[g[j][1]],1LL*pre[j]*x);
    }
    nxt();
  }
  int ans=P-1;
  for(i=1;i<=cnt;i++)up(ans,pre[i]);
  printf("%d\n",ans);
}
}
namespace BIG{
const int K=15,MAXL=505;
int r,c,val[N][K],cnt[K],q[K][MAXL],g[K][MAXL][2];
map<int,int>id[K];
int pre[MAXL],now[MAXL];
inline void clr(int cnt){for(int i=1;i<=cnt;i++)now[i]=0;}
inline void nxt(int cnt){for(int i=1;i<=cnt;i++)pre[i]=now[i];}
inline bool check(int S,int l,int r){
  for(int i=l;i<r;i++)if((S>>i&1)&&(S>>(i+1)&1))return 0;
  return 1;
}
void solve(){
  //c=ceil(n/m)<=12,r>1
  r=c=0;
  int i,j,k,o,S,T,x,y;
  for(i=0;i<n;i++)r=max(r,i%m),c=max(c,i/m);
  r++,c++;
  for(i=0;i<r;i++)for(j=0;j<c;j++)val[i][j]=0;
  for(i=0;i<n;i++)val[i%m][i/m]=w[i];
  for(i=0;i<c;i++){
    //[0..i-1] [i..c-1]
    cnt[i]=0;
    id[i].clear();
    for(S=0;S<1<<c;S++){
      if(!check(S,0,i-1))continue;
      if(!check(S,i,c-1))continue;
      id[i][S]=++cnt[i];
      q[i][cnt[i]]=S;
    }
  }
  for(i=0;i<c;i++)for(j=1;j<=cnt[i];j++){
    S=q[i][j];
    x=S>>i&1;
    T=S^(x<<i);
    g[i][j][0]=id[(i+1)%c][T];
    g[i][j][1]=0;
    if(x)continue;
    g[i][j][1]=id[(i+1)%c][S|(1<<i)];
  }
  int ans=P-1;
  for(o=1;o<=cnt[0];o++){
    clr(cnt[0]);
    S=q[0][o];
    int tmp=1;
    for(i=0;i<c;i++)if(S>>i&1)tmp=1LL*tmp*val[0][i]%P;
    now[o]=tmp;
    nxt(cnt[0]);
    for(i=1;i<r;i++)for(j=0;j<c;j++){
      int A=cnt[j],B=cnt[(j+1)%c],C=val[i][j];
      clr(B);
      for(k=1;k<=A;k++){
        up(now[g[j][k][0]],pre[k]);
        upl(now[g[j][k][1]],1LL*pre[k]*C);
      }
      nxt(B);
    }
    for(i=1;i<=cnt[0];i++)if(!((S>>1)&q[0][i]))up(ans,pre[i]);
  }
  printf("%d\n",ans);
}
}
int main(){
  scanf("%d",&Case);
  while(Case--){
    scanf("%d%d",&n,&m);
    for(i=0;i<n;i++)scanf("%d",&w[i]);
    if(m*m<=n*2)SMALL::solve();else BIG::solve();
  }
}