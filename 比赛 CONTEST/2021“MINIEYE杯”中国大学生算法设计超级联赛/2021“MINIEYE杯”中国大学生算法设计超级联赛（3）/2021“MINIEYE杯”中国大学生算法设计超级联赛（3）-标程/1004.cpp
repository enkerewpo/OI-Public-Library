#include<cstdio>
#include<algorithm>
using namespace std;
typedef pair<int,int>P;
const int N=100005;
int Case,n,i,j,k,f[N];
P a[N];
inline int abs(int x){return x>0?x:-x;}
int gcd(int a,int b){return b?gcd(b,a%b):a;}
int main(){
  scanf("%d",&Case);
  while(Case--){
    scanf("%d",&n);
    for(i=1;i<=n;i++){
      int x1,y1,x2,y2;
      scanf("%d%d%d%d",&x1,&y1,&x2,&y2);
      int dx=x2-x1,dy=y2-y1;
      if(dx==0)dy=1;
      else if(dy==0)dx=1;
      else{
        if(dx<0)dx=-dx,dy=-dy;
        int d=gcd(abs(dx),abs(dy));
        dx/=d,dy/=d;
      }
      a[i]=P(dx,dy);
    }
    sort(a+1,a+n+1);
    for(i=1;i<=n;i++)f[i]=0;
    for(i=1;i<=n;i=j){
      for(j=i;j<=n&&a[i]==a[j];j++);
      for(k=1;k<=j-i;k++)f[k]++;
    }
    for(i=j=1;i<=n;i++){
      while(!f[j])j++;
      f[j]--;
      printf("%d\n",i-j);
    }
  }
}