#include<cstdio>
const int N=100005;
int Case,n,m,i,x,y,t[N],r[N],g[N],b[N],f[N];
inline int ask(int*s,int l,int r){
  int x=f[r],ret;
  if(x<l)ret=s[r]-s[l-1];
  else ret=s[r]-s[x-1];
  return ret<255?ret:255;
}
int main(){
  scanf("%d",&Case);
  while(Case--){
    scanf("%d%d",&n,&m);
    for(i=1;i<=n;i++){
      scanf("%d%X",&t[i],&x);
      b[i]=x&255;
      x>>=8;
      g[i]=x&255;
      x>>=8;
      r[i]=x;
      r[i]+=r[i-1];
      g[i]+=g[i-1];
      b[i]+=b[i-1];
      if(t[i]==1)f[i]=i;else f[i]=f[i-1];
    }
    while(m--){
      scanf("%d%d",&x,&y);
      printf("%02X%02X%02X\n",ask(r,x,y),ask(g,x,y),ask(b,x,y));
    }
  }
}