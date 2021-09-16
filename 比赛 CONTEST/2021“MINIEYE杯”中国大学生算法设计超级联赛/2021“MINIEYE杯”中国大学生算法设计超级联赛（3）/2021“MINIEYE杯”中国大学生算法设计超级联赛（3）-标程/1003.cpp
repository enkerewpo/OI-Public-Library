#include<cstdio>
#include<cmath>
#include<algorithm>
using namespace std;
const int N=524305;
const double pi=acos(-1.0);
struct comp{
  double r,i;comp(double _r=0,double _i=0){r=_r,i=_i;}
  comp operator+(const comp&x)const{return comp(r+x.r,i+x.i);}
  comp operator-(const comp&x)const{return comp(r-x.r,i-x.i);}
  comp operator*(const comp&x)const{return comp(r*x.r-i*x.i,r*x.i+i*x.r);}
  comp conj(){return comp(r,-i);}
}w[N],ww[N],A[N],B[N];
int pos[N],Case,n,m,k,i,j,o,s[N],f[N],ans[N];char a[N],b[N];
inline void FFT(comp a[],int n,int o){
  for(int i=1;i<n;i++)if(i<pos[i])swap(a[i],a[pos[i]]);
  for(int d=0,k=__builtin_ctz(n);(1<<d)<n;d++){
    int m=1<<d,m2=m<<1;
    for(int i=0;i<n;i+=m2)for(int j=0;j<m;j++){
      comp&A=a[i+j+m],&B=a[i+j],t=(o==1?w[j<<(k-d)]:ww[j<<(k-d)])*A;
      A=B-t;B=B+t;
    }
  }
  if(o==-1)for(int i=0;i<n;i++)a[i].r/=n;
}
int main(){
  scanf("%d",&Case);
  while(Case--){
    scanf("%d%d%s%s",&n,&m,a,b);
    reverse(b,b+m);
    for(k=1;k<=n+m-2;k<<=1);
    j=__builtin_ctz(k)-1;
    for(i=0;i<k;i++)pos[i]=pos[i>>1]>>1|((i&1)<<j);
    for(i=0;i<k;i++)w[i]=comp(cos(pi*i/k),sin(pi*i/k));
    for(i=0;i<k;i++)ww[i]=w[i],ww[i].i*=-1;
    for(i=0;i<n;i++){
      s[i]=0;
      if(i)s[i]+=s[i-1];
      if(a[i]=='*')s[i]++;
    }
    int cnt=0;
    for(i=0;i<m;i++)if(b[i]=='*')cnt++;
    for(i=m-1;i<n;i++){
      f[i]=cnt+s[i];
      if(i>=m)f[i]-=s[i-m];
    }
    for(o=0;o<=10;o++){
      char target=o+'0';
      if(o==10)target='*';
      for(i=0;i<k;i++)A[i]=comp(0,0);
      for(i=0;i<n;i++)if(a[i]==target)A[i].r=1;
      for(i=0;i<m;i++)if(b[i]==target)A[i].i=1;
      FFT(A,k,1);
      for(i=0;i<k;i++){
        j=(k-i)&(k-1);
        B[i]=(A[i]*A[i]-(A[j]*A[j]).conj())*comp(0,-0.25);
      }
      FFT(B,k,-1);
      for(i=m-1;i<n;i++){
        int tmp=((int)(B[i].r+0.5));
        if(o<10)f[i]+=tmp;else f[i]-=tmp;
      }
    }
    for(i=0;i<=m;i++)ans[i]=0;
    for(i=m-1;i<n;i++)ans[m-f[i]]++;
    for(i=0;i<=m;i++){
      if(i)ans[i]+=ans[i-1];
      printf("%d\n",ans[i]);
    }
  }
}