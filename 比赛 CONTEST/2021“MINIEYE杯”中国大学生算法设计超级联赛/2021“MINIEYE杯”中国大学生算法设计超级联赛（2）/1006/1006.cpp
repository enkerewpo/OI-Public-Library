//#pragma GCC optimize("Ofast,no-stack-protector,unroll-loops,fast-math")
//#pragma GCC target("sse,sse2,sse3,ssse3,sse4.1,sse4.2,avx,avx2,popcnt,tune=native")
 
//#include <immintrin.h>
//#include <emmintrin.h>
#include <bits/stdc++.h>
using namespace std;
#define rep(i,h,t) for (int i=h;i<=t;i++)
#define dep(i,t,h) for (int i=t;i>=h;i--)
#define ll long long
#define me(x) memset(x,0,sizeof(x))
#define IL inline
#define rint register int
inline ll rd(){
    ll x=0;char c=getchar();bool f=0;
    while(!isdigit(c)){if(c=='-')f=1;c=getchar();}
    while(isdigit(c)){x=(x<<1)+(x<<3)+(c^48);c=getchar();}
    return f?-x:x;
}
struct re{
    int a,b,c;
};
int n,m;
const int N=610000;
const int mo=1e9+7;
ll a[N],b[N],a1[N],a2[N],c[N];
void g1(ll &xa,ll &xb,ll &xc)
{
//    cerr<<xa<<" "<<xb<<" "<<xc<<endl;
    ll a=xa,b=xb,c=xc;
    xa=a;
    xb=(a+b+c)%mo; 
    xc=(a+c)%mo;
}
void g2(ll &xa,ll &xb,ll &xc)
{
    ll a=xa,b=xb,c=xc; 
    xa=a;
    xb=(b-c)%mo;
    xc=(c-a)%mo;
}
void fwt(ll *a,int o)
{
    for (int i=1;i<m;i*=3)
      for (int j=0;j<m;j+=(i*3))
        for (int k=0;k<i;k++)
        {
            if (o==0) g1(a[j+k],a[j+k+i],a[j+k+2*i]);
            else g2(a[j+k],a[j+k+i],a[j+k+2*i]);
        }
}
int main()
{
   ios::sync_with_stdio(false);
   int n;
   n=rd();
   rep(i,1,n) a[i]=rd();
   rep(i,1,n) b[i]=rd();
   rep(i,1,n) c[i]=rd();
   ll ans=0,ans2=0;
   dep(j,n,1) 
   {
        int k=n/j;
       // cerr<<j<<" "<<k<<endl; 
        rep(i,1,k) a1[i]=a[i];
        rep(i,1,k) a2[i]=b[i];
     m=1;
     
//     cerr<<k<<" ";
     while (m<=k) m*=3;
     ans2+=m;
     fwt(a1,0); fwt(a2,0);
     rep(i,0,m-1) a1[i]=a1[i]*a2[i]%mo;
     fwt(a1,1);
// rep(i,0,m-1) cerr<<a1[i]<<" ";
//     cerr<<endl;
     ll p=1;
     rep(i,1,m)
     { 
       p=p*c[j]%mo;
       ans=(ans+a1[i]*p)%mo;
     }
     rep(i,1,m) a1[i]=a2[i]=0;
   }
   cout<<(ans+mo)%mo<<endl;
 //  cerr<<ans2<<endl; 
   return 0;
}
