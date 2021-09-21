#include<cstdio>
#include<vector>
#include<algorithm>
using namespace std;
typedef long long ll;
const int N=4005;
int Case,n,m,i,j,x,y,a[N],b[N],p[N];ll ans,tmp;
vector<int>g[N];
int pool[N],cp,q[N],h,t,S,fl[N],fr[N],who[N],pre[N];bool vis[N],ban[N];
inline bool cmp(int x,int y){return a[x]>a[y];}
inline void ext(int x){
  if(vis[x])return;
  vis[x]=1;
  int i,m=0,y;
  for(i=0;i<g[x].size();i++)ban[g[x][i]]=1;
  for(i=1;i<=cp;i++){
    y=pool[i];
    if(who[y])continue;
    if(ban[y]){pool[++m]=y;continue;}
    who[y]=S;
    pre[y]=x;
    q[++t]=y;
  }
  cp=m;
  for(i=0;i<g[x].size();i++)ban[g[x][i]]=0;
}
inline void bfs(){
  h=1,t=0;
  ext(S);
  while(h<=t){
    int x=q[h++];
    if(fr[x])ext(fr[x]);
  }
}
inline int aug(){
  int i,x,y,best=-1,X,Y,now;
  for(i=1;i<=n;i++)vis[i]=who[i]=0;
  for(i=1;i<=n;i++)pool[i]=i;
  cp=n;
  for(i=1;i<=n;i++){
    S=p[i];
    if(!fl[S])bfs();
  }
  for(i=1;i<=n;i++)if(!fr[i]&&who[i]){
    now=b[i]+a[who[i]];
    if(now>best)best=now,X=i;
  }
  if(best<0)return -1;
  Y=who[X];
  while(pre[X]!=Y){
    y=pre[X];
    fr[X]=y;
    swap(X,fl[y]);
  }
  fl[Y]=X;
  fr[X]=Y;
  return best;
}
int main(){
  scanf("%d",&Case);
  while(Case--){
    scanf("%d%d",&n,&m);
    for(i=1;i<=n;i++)fl[i]=fr[i]=0,g[i].clear();
    for(i=1;i<=n;i++)scanf("%d",&a[i]);
    for(i=1;i<=n;i++)scanf("%d",&b[i]);
    while(m--)scanf("%d%d",&x,&y),g[x].push_back(y);
    for(i=1;i<=n;i++)p[i]=i;
    sort(p+1,p+n+1,cmp);
    ans=0;
    for(i=1;i<=n;i++){
      tmp=aug();
      if(tmp<0){
        for(j=i;j<=n;j++)puts("-1");
        break;
      }
      ans+=tmp;
      printf("%lld\n",ans);
    }
  }
}