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
ll fsp(int x,int y)
{
    if (y==1) return x;
    ll ans=fsp(x,y/2);
    ans=ans*ans%mo;
    if (y%2==1) ans=ans*x%mo;
    return ans;
}
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
vector<re> ve;
const int N=2005;
int dis[N],n,m,q;
int h[N][N][2];
int ans2=0;
vector<int> bb[N];
vector<int> v1[N];
int g(int x,int y,int z,int k)
{
    ans2++;
    if (k==0&&(x==z||y==z))
    {
        if (x==z&&y==z) return 2;
        if (x==z) return 1;
        return 3;
    }
    if (h[x][y][k]) return h[x][y][k];
    int tt;
    if (k==0)
    {
        tt=3;
        for (auto i:v1[x])
          if ((i!=y||i==z))
          {
              int kk=g(i,y,z,k^1);
              tt=min(tt,4-kk);
          }
        h[x][y][k]=tt;
    } else
    {
        tt=3;
        for (auto i:v1[y])
          if ((i!=x||i==z))
          {
              int kk=g(x,i,z,k^1);
              tt=min(tt,4-kk);
          }
        h[x][y][k]=tt;
    }
    ve.push_back((re){x,y,k});
    return h[x][y][k];
}
int main()
{
   ios::sync_with_stdio(false);
   int T;
   cin>>T;
   ll anst=0,ansa=0;
   while(T--)
   {
   rep(i,1,n) bb[i].clear();
   cin>>n>>m; anst+=m; ansa+=n;
   rep(i,1,n) dis[i]=1e9;
   
   int x,y,z;
   cin>>x>>y>>z;
   rep(i,1,m)
   {
        int x,y;
     cin>>x>>y;
     bb[x].push_back(y); bb[y].push_back(x);
   }
   dis[z]=0;
   queue<int> q;
   q.push(z);
   while (!q.empty())
   {
       int x=q.front(); q.pop();
       for (auto v:bb[x])
       {
           if (dis[v]==1e9) {dis[v]=dis[x]+1; q.push(v);}
       }
   }
   int ans=0;
    //    cerr<<x<<" "<<y<<" "<<z<<" "<<dis[x]<<" "<<dis[y]<<endl; 
        if (dis[x]>dis[y]) { cout<<3<<endl; continue;}
        if (dis[x]<dis[y]) { cout<<1<<endl; continue;}
        if (dis[x]==1e9)
        {
            cout<<2<<endl;
            continue; 
        }   
     if (dis[x]==dis[y])
     {
         
   rep(i,1,n)
     for (auto j:bb[i])
       if (dis[i]==dis[j]+1) v1[i].push_back(j);
        cout<<g(x,y,z,0)<<endl;
        for (auto v:ve)
        {
            h[v.a][v.b][v.c]=0;
        }
        ans+=ve.size();
      //  cerr<<ve.size()<<endl;
        ve.clear();
     }
     rep(i,1,n) v1[i].clear();
   } 
  // cerr<<ansa<<" "<<anst<<endl;
  // cerr<<ans2<<endl;
   //cerr<<ans<<endl;
   return 0;
}
