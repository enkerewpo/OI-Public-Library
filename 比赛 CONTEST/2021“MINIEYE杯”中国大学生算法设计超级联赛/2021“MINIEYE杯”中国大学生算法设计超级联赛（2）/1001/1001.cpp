//#pragma GCC optimize("Ofast,no-stack-protector,unroll-loops,fast-math")
//#pragma GCC target("sse,sse2,sse3,ssse3,sse4.1,sse4.2,avx,avx2,popcnt,tune=native")

//#include <immintrin.h>
//#include <emmintrin.h>
#include <bits/stdc++.h>
#define N 1000009
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
char ss[1<<24],*A=ss,*B=ss;
IL char gc()
{
    return A==B&&(B=(A=ss)+fread(ss,1,1<<24,stdin),A==B)?EOF:*A++;
}
template<class T>void maxa(T &x,T y)
{
    if (y>x) x=y;
}
template<class T>void mina(T &x,T y)
{
    if (y<x) x=y;
}
template<class T>void read(T &x)
{
    int f=1,c; while (c=gc(),c<48||c>57) if (c=='-') f=-1; x=(c^48);
    while(c=gc(),c>47&&c<58) x=x*10+(c^48); x*=f;
}
const int mo=1e9+7;
struct cp {
    ll x,y;
    cp operator +(cp B)
    {
        return (cp){x+B.x,y+B.y};
    }
    cp operator -(cp B)
    {
        return (cp){x-B.x,y-B.y};
    }
    ll operator *(cp B)
    {
        return x*B.y-y*B.x;
    }
    int half() { return y < 0 || (y == 0 && x < 0); }
};
struct re{
    int a,b,c;
};
ll fsp(int x,int y)
{
    if (y==1) return x;
    ll k=fsp(x,y/2);
    k=k*k%mo;
    if (y%2==1) k=k*x%mo;
    return k;
}
int main()
{
   ios::sync_with_stdio(false);
   int T;
   cin>>T;
   while (T--)
   {
         ll n;
         cin>>n;
         n=n%mo;
         ll k=n*(n-1)%mo*fsp(2,mo-2)%mo;
         k=(k+mo)%mo;
         k=k*k%mo;
         k=8*k%mo;
         cout<<k<<endl;
   }
   return 0;
}
