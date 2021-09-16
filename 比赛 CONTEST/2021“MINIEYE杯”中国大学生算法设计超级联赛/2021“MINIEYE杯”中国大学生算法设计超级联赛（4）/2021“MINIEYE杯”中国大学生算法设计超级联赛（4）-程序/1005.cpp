// sol_HeRaNO.cpp: Model solution for 'expect-range-query'
// Method: Monotonous Stack, Segment Tree, Offline algorithm
// Time Complexity: O((n + m) log n)
// Author: HeRaNO, idea from ZXyang
#include <bits/stdc++.h>
#define MAXN 200005
using namespace std;

const int M=1000000007;

inline int fadd(int x,int y){x+=y;if (x>=M) x-=M;return x;}
inline void fadd2(int &x,int y){x+=y;if (x>=M) x-=M;return ;}
inline int mul(int x,int y){return 1LL*x*y%M;}

inline int fpow(int a,int b)
{
	int r=1;
	for (;b;b>>=1,a=mul(a,a)) if (b&1) r=mul(r,a);
	return r;
}

struct IntervalAddQuerySegT
{
	int x[1<<19],lazy[1<<19];
	void add(int u,int l,int r,int v)
	{
		fadd2(x[u],mul(r-l,v));
		fadd2(lazy[u],v);
		return ;
	}
	void PushDown(int u,int l,int r,int m)
	{
		if (!lazy[u]) return ;
		add(u<<1,l,m,lazy[u]);add(u<<1|1,m,r,lazy[u]);
		lazy[u]=0;return ;
	}
	void modify(int u,int l,int r,int v,int pl,int pr)
	{
		if (l==pl&&r==pr) return add(u,l,r,v);
		int m=pl+pr>>1;PushDown(u,pl,pr,m);
		if (r<=m) modify(u<<1,l,r,v,pl,m);
		else if (m<=l) modify(u<<1|1,l,r,v,m,pr);
		else
		{
			modify(u<<1,l,m,v,pl,m);
			modify(u<<1|1,m,r,v,m,pr);
		}
		x[u]=fadd(x[u<<1],x[u<<1|1]);
		return ;
	}
	int query(int u,int l,int r,int pl,int pr)
	{
		if (l==pl&&r==pr) return x[u];
		int m=pl+pr>>1;PushDown(u,pl,pr,m);
		if (r<=m) return query(u<<1,l,r,pl,m);
		else if (m<=l) return query(u<<1|1,l,r,m,pr);
		else return fadd(query(u<<1,l,m,pl,m),query(u<<1|1,m,r,m,pr));
	}
	void clear(int u,int l,int r)
	{
		x[u]=lazy[u]=0;
		if (l+1==r) return ;
		int m=l+r>>1;clear(u<<1,l,m);clear(u<<1|1,m,r);
		return ;
	}
}T1;

struct SegT
{
	int x[1<<19],sa[1<<19],sb[1<<19];
	int lazya[1<<19],lazyb[1<<19];
	void color(int u,int l,int r,int v)
	{
		sa[u]=mul(r-l,v);
		x[u]=mul(sb[u],v);
		lazya[u]=v;return ;
	}
	void add(int u,int l,int r,int v)
	{
		fadd2(x[u],mul(v,sa[u]));
		fadd2(sb[u],mul(r-l,v));
		fadd2(lazyb[u],v);
		return ;
	}
	void PushDown(int u,int l,int r,int m)
	{
		if (lazya[u])
		{
			color(u<<1,l,m,lazya[u]);color(u<<1|1,m,r,lazya[u]);
			lazya[u]=0;
		}
		if (lazyb[u])
		{
			add(u<<1,l,m,lazyb[u]);add(u<<1|1,m,r,lazyb[u]);
			lazyb[u]=0;
		}
		return ;
	}
	void PushUp(int u)
	{
		x[u]=fadd(x[u<<1],x[u<<1|1]);
		sa[u]=fadd(sa[u<<1],sa[u<<1|1]);
		sb[u]=fadd(sb[u<<1],sb[u<<1|1]);
		return ;
	}
	void setA(int u,int l,int r,int v,int pl,int pr)
	{
		if (l==pl&&r==pr) return color(u,l,r,v);
		int m=pl+pr>>1;PushDown(u,pl,pr,m);
		if (r<=m) setA(u<<1,l,r,v,pl,m);
		else if (m<=l) setA(u<<1|1,l,r,v,m,pr);
		else
		{
			setA(u<<1,l,m,v,pl,m);
			setA(u<<1|1,m,r,v,m,pr);
		}
		PushUp(u);
		return ;
	}
	void addB(int u,int l,int r,int v,int pl,int pr)
	{
		if (l==pl&&r==pr) return add(u,l,r,v);
		int m=pl+pr>>1;PushDown(u,pl,pr,m);
		if (r<=m) addB(u<<1,l,r,v,pl,m);
		else if (m<=l) addB(u<<1|1,l,r,v,m,pr);
		else
		{
			addB(u<<1,l,m,v,pl,m);
			addB(u<<1|1,m,r,v,m,pr);
		}
		PushUp(u);
		return ;
	}
	int query(int u,int l,int r,int pl,int pr)
	{
		if (l==pl&&r==pr) return x[u];
		int m=pl+pr>>1;PushDown(u,pl,pr,m);
		if (r<=m) return query(u<<1,l,r,pl,m);
		else if (m<=l) return query(u<<1|1,l,r,m,pr);
		else return fadd(query(u<<1,l,m,pl,m),query(u<<1|1,m,r,m,pr));
	}
	void clear(int u,int l,int r)
	{
		x[u]=sa[u]=sb[u]=0;
		lazya[u]=lazyb[u]=0;
		if (l+1==r) return ;
		int m=l+r>>1;clear(u<<1,l,m);clear(u<<1|1,m,r);
		return ;
	}
}T2;

int n,m,a[MAXN],ans[MAXN],il[MAXN];
int sta[MAXN],top;
vector<pair<int,int> > v[MAXN];

inline void Solve(int op)
{
	top=0;
	T1.clear(1,1,n+1);T2.clear(1,1,n+1);
	for (int i=1;i<=n;i++)
	{
		int A=op<0?-a[i]:a[i];
		for (int B;top&&a[i]>=a[sta[top]];--top)
		{
			B=op<0?-a[sta[top]]:a[sta[top]];
			T1.modify(1,sta[top-1]+1,sta[top]+1,mul(B,i-sta[top]),1,n+1);
			T2.addB(1,sta[top-1]+1,sta[top]+1,M-i+sta[top],1,n+1);
		}
		T2.setA(1,sta[top]+1,i+1,A,1,n+1);
		T2.addB(1,1,i+1,1,1,n+1);
		sta[++top]=i;
		for (auto j:v[i])
		{
			fadd2(ans[j.second],T1.query(1,j.first,i+1,1,n+1));
			fadd2(ans[j.second],T2.query(1,j.first,i+1,1,n+1));
		}
	}
	return ;
}

inline void Solve()
{
	scanf("%d %d",&n,&m);
	for (int i=1;i<=n;i++) scanf("%d",&a[i]);
	for (int i=1,l,r;i<=m;i++)
	{
		scanf("%d %d",&l,&r);
		v[r].push_back({l,i});
		l=r-l+1;il[i]=fpow(mul(l,l+1),M-2);
	}
	Solve(1);
	for (int i=1;i<=n;i++) a[i]=-a[i];
	Solve(-1);
	for (int i=1;i<=m;i++) printf("%d\n",mul(ans[i],il[i]));
	for (int i=1;i<=n;i++) v[i].clear();
	for (int i=1;i<=m;i++) ans[i]=0;
	return ;
}

int main()
{
	int T;
	scanf("%d",&T);
	while (T--) Solve();
	return 0;
}