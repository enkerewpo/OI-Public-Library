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
const int N=2e5;
vector<int> ve[N];
int dfn[N],sum[N],son[N],top[N],dep[N],fa[N],n,m;
struct sgt{
  ll c1[N],c2[N]; 
  inline void update(ll x,ll k)
  {
    ll i=x;
    while(x<=n)
    {
        c1[x]+=k;
        c2[x]+=i*k;
        x+=x&-x;
    }
    return;
  }
  inline ll sum(ll x)
  {
    ll ans=0;
    ll i=x;
    while(x>0)
    {
        ans+=c1[x]*(i+1);
        ans-=c2[x];
        x-=x&-x;
    }
    return ans;
  }
   inline void change(int x,int y,ll z)
   {
  //     cerr<<x<<" "<<y<<endl;
      update(x,z);
      update(y+1,-z);
   }
   ll query(int x)
   {
      return sum(x)-sum(x-1);
   }
}S1,S2,S3; 
int cnt;
void dfs(int x,int y)
{
    dfn[x]=++cnt; sum[x]=1; dep[x]=dep[y]+1; fa[x]=y;
    for (auto v:ve[x])
    if(v!=y)
    {
        dfs(v,x);
        sum[x]+=sum[v];
        if (sum[v]>sum[son[x]]) son[x]=v;
    }
}
void dfs2(int x,int y,int z)
{
    top[x]=z;
    if (son[x]) dfs2(son[x],x,z);
    for (auto v:ve[x])
    if (v!=y&&v!=son[x])
    {
        dfs2(v,x,v);
    }
}
int lca(int x,int y)
{
    while(top[x]!=top[y])
    {
        if(dep[top[x]]>dep[top[y]]) x=fa[top[x]];
        else y=fa[top[y]];
    }
    return dep[x]<dep[y]?x:y;
}
void change(int x,int y,int z)
{
    int f1=1,f2=z;
    while (top[x]!=top[y])
    {
      if (dep[top[x]]>dep[top[y]])
      {
           f1-=dep[top[x]]-dep[x];
           int g=dfn[top[x]];
           S1.change(g,dfn[x],1ll*(f1+g)*(f1+g));
           S2.change(g,dfn[x],f1+g);
           S3.change(g,dfn[x],1);
           x=fa[top[x]];
           f1++;
      } else
      {
           f2+=dep[top[y]]-dep[y];
           int g=dfn[top[y]];
           S1.change(g,dfn[y],1ll*(g-f2)*(g-f2));
           S2.change(g,dfn[y],g-f2);
           S3.change(g,dfn[y],1);
           y=fa[top[y]];
           f2--;
      }
    }
    if (dep[x]<=dep[y])
    {
        f2+=dep[x]-dep[y];
        int g=dfn[x];
        S1.change(g,dfn[y],1ll*(g-f2)*(g-f2));
          S2.change(g,dfn[y],g-f2);
          S3.change(g,dfn[y],1);
    } else
    {
        f1-=dep[y]-dep[x];
        int g=dfn[y];
          S1.change(g,dfn[x],1ll*(f1+g)*(f1+g));
          S2.change(g,dfn[x],f1+g);
          S3.change(g,dfn[x],1);
    }
}
int main()
{
   ios::sync_with_stdio(false);
   cin>>n;
   rep(i,1,n-1)
   {
        int x,y;
        cin>>x>>y;
        ve[x].push_back(y); ve[y].push_back(x);
   }
   dfs(1,0); dfs2(1,0,1);
   cin>>m;
   rep(i,1,m)
   {
        ll kk,x,y;
        cin>>kk;
       // cerr<<i<<endl;
        if (kk==1)
        {
            cin>>x>>y;
            int t=lca(x,y);
            change(x,y,dep[x]+dep[y]-2*dep[t]+1);
        } else
        {
            cin>>x;x=dfn[x]; 
        //    cerr<<x<<" "<<S1.query(x)<<" "<<S2.query(x)<<" "<<S3.query(x)<<endl;
            cout<<S1.query(x)-2*x*S2.query(x)+x*x*S3.query(x)<<endl;
        }
   }
   return 0;
}
