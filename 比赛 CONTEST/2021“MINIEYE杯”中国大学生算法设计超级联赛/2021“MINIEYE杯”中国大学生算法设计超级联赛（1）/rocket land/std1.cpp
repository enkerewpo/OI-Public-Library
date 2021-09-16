#include <bits/stdc++.h>
using namespace std;
#define fr first
#define sc second
typedef long long ll;
const int K=2;
const int N=5e5+10;
const int mod=1e9+7;
const double alpha=0.75;
ll qpow(ll a,ll n){ll res=1;while(n){if(n&1)res=res*a%mod;a=a*a%mod;n>>=1;}return res;}
int now;
struct Point
{
	int num[K],val,id;
	Point(){};
	Point(int xx,int yy,int vall){
		num[0]=xx,num[1]=yy,val=vall;
	}
	friend bool operator <(Point a,Point b)
	{
		return a.num[now]<b.num[now];
	}
}p[N],p1[N];
struct tree
{
	int l,r,siz,minn[K],maxx[K],tf,fa;
	ll sum;
	int exist;
	Point p;
};
struct KDT
{
	tree t[N];
	int id[N];
	int tot,root;
	int cnt,rubbish[N];
	int cnt1;
	ll ans=0;
	priority_queue<ll,vector<ll>,greater<ll> >q;
	void init()
	{
		cnt=0,tot=0,cnt1=0,ans=0,root=0;
	}
	int newnode(){
		if(cnt)return rubbish[cnt--];
		return ++tot;
	}
	void up(int u)
	{
		for(int i=0;i<K;i++){
			t[u].minn[i]=t[u].maxx[i]=t[u].p.num[i];
			if(t[u].l){
				t[u].minn[i]=min(t[u].minn[i],t[t[u].l].minn[i]);
				t[u].maxx[i]=max(t[u].maxx[i],t[t[u].l].maxx[i]);
			}
			if(t[u].r){
				t[u].minn[i]=min(t[u].minn[i],t[t[u].r].minn[i]);
				t[u].maxx[i]=max(t[u].maxx[i],t[t[u].r].maxx[i]);
			}
		}
		if(t[u].l)t[t[u].l].fa=u;
		if(t[u].r)t[t[u].r].fa=u;
		t[u].sum=t[t[u].l].sum+t[t[u].r].sum+(t[u].exist?t[u].p.val:0);
		t[u].siz=t[t[u].l].siz+t[t[u].r].siz+t[u].exist;
	}
	void slap(int u)
	{
		if(!u)return;
		if(t[u].exist)p1[++cnt1]=t[u].p;
		rubbish[++cnt]=u;
		slap(t[u].l);
		slap(t[u].r);
	}
	int rebuild(int l,int r,int d)
	{
		now=d;
		if(l>r)return 0;
		int mid=(l+r)>>1,u=newnode();
		nth_element(p1+l,p1+mid,p1+r+1);
		t[u].p=p1[mid];
		t[u].exist=1;
		id[p1[mid].id]=u;
		t[u].l=rebuild(l,mid-1,(d+1)%K);
		t[u].r=rebuild(mid+1,r,(d+1)%K);
		up(u);
		return u;
	}
	void check(int &u,int d)
	{
		if(t[t[u].l].siz>alpha*t[u].siz||t[t[u].r].siz>alpha*t[u].siz){
			cnt1=0;
			slap(u);
			u=rebuild(1,t[u].siz,d);
		}
	}
	void insert(int &u,Point now,int d)
	{
		if(!u){
			u=newnode();
			t[u].exist=1;
			t[u].l=t[u].r=0,t[u].p=now;
			up(u);return;
		}
		if(now.num[d]<=t[u].p.num[d])insert(t[u].l,now,(d+1)%K);
		else insert(t[u].r,now,(d+1)%K);
		up(u);
		check(u,d);
	}
	int build(int l,int r,int d)
	{
		if(l>r)return 0;
		now=d;
		int mid=(l+r)>>1;
		int u=newnode();
		nth_element(p1+l,p1+mid,p1+r+1);
		t[u].exist=1;
		t[u].p=p1[mid];
		id[p1[mid].id]=u;
		t[u].l=build(l,mid-1,(d+1)%K);
		t[u].r=build(mid+1,r,(d+1)%K);
		up(u);
		return u;
	}
	bool inside(int x1,int y1,int r,int X1,int Y1,int X2,int Y2)
	{
        int cnt=0;
        if(1ll*(X1-x1)*(X1-x1)+1ll*(Y1-y1)*(Y1-y1)<=1ll*r*r)cnt++;
		if(1ll*(X2-x1)*(X2-x1)+1ll*(Y1-y1)*(Y1-y1)<=1ll*r*r)cnt++;
        if(1ll*(X1-x1)*(X1-x1)+1ll*(Y2-y1)*(Y2-y1)<=1ll*r*r)cnt++;
        if(1ll*(X2-x1)*(X2-x1)+1ll*(Y2-y1)*(Y2-y1)<=1ll*r*r)cnt++;
        if(cnt==4)return true;
        else return false;
	}
	bool outside(int x1,int y1,int r,int X1,int Y1,int X2,int Y2)
	{
        int x,y;
        if(x1<=X2&&x1>=X1)x=x1;
        else if(x1<X1)x=X1;
        else x=X2;
        if(y1<=Y2&&y1>=Y1)y=y1;
        else if(y1<Y1)y=Y1;
        else y=Y2;
        if(1ll*(x1-x)*(x1-x)+1ll*(y1-y)*(y1-y)<=1ll*r*r)return false;
        else return true;
	}
	ll query(int u,int x1,int y1,int r)
	{
		if(!u)return 0;
        if(t[u].siz==0)return 0;
		if(inside(x1,y1,r,t[u].minn[0],t[u].minn[1],t[u].maxx[0],t[u].maxx[1]))return t[u].sum;
		if(outside(x1,y1,r,t[u].minn[0],t[u].minn[1],t[u].maxx[0],t[u].maxx[1]))return 0;
		ll ans=0;
		if(t[u].exist&&inside(x1,y1,r,t[u].p.num[0],t[u].p.num[1],t[u].p.num[0],t[u].p.num[1]))ans+=t[u].p.val;
		ans+=query(t[u].l,x1,y1,r)+query(t[u].r,x1,y1,r);
		return ans;
	}
}T1;
int r[N];
void solve()
{
    int n;
    scanf("%d",&n);
    for(int i=1;i<=n;i++){
        scanf("%d%d%d%d",&p[i].num[0],&p[i].num[1],&p[i].val,&r[i]);
        p[i].id=i;
        p1[i]=p[i];
    }
    T1.init();
    for(int i=1;i<=n;i++){
        T1.insert(T1.root,p1[i],0);
        printf("%lld\n",T1.query(T1.root,p[i].num[0],p[i].num[1],r[i]));
    }
}
int main()
{
    int T;
    scanf("%d",&T);
    while(T--){
        solve();
    }
}