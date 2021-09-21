#include<bits/stdc++.h>
#define fo(i, x, y) for(int i = x, _b = y; i <= _b; i ++)
#define ff(i, x, y) for(int i = x, _b = y; i <  _b; i ++)
#define fd(i, x, y) for(int i = x, _b = y; i >= _b; i --)
#define ll long long
#define pp printf
#define hh pp("\n")
using namespace std;

const int N = 1e5 + 5;

int n, a[N], x, y;
int fi[N], to[N * 2], nt[N * 2], tt;

void link(int x, int y) {
	nt[++ tt] = fi[x], to[tt] = y, fi[x] = tt;
}

int bz[N];

ll ans[N];

int siz[N], mx[N], G;

void fg(int x) {
	bz[x] = 1;
	siz[x] = 1; mx[x] = 0;
	for(int i = fi[x]; i; i = nt[i]) {
		int y = to[i]; if(bz[y]) continue;
		fg(y);
		siz[x] += siz[y];
		mx[x] = max(mx[x], siz[y]);
	}
	mx[x] = max(mx[x], siz[0] - siz[x]);
	if(mx[x] < mx[G]) G = x;
	bz[x] = 0;
}

int dis[N], d[N], d0;

void dfs(int x) {
	bz[x] = 1;
	d[++ d0] = x;
	for(int i = fi[x]; i; i = nt[i]) {
		int y = to[i]; if(bz[y]) continue;
		dis[y] = dis[x] + 1;
		dfs(y);
	}
	bz[x] = 0;
}

const int W = 17;

ll a2[W + 1];

const int M = N * (W + 1);

int son[M][2];
int s1[M];
ll s2[M];
int tot, rt;

void cl() {
	fo(i, 1, tot) son[i][0] = son[i][1] = s1[i] = s2[i] = 0;
	tot = rt = 1;
}

#define x0 son[x][0]
#define x1 son[x][1]

void add(int x) {
	static int t[W + 1];
	int p = rt;
	fo(i, 0, W) {
		s1[p] ++;
		s2[p] += x ^ (x & (a2[i] - 1));
		t[i] = p;
		int c = x >> i & 1;
		if(!son[p][c]) son[p][c] = ++ tot;
		p = son[p][c];
	}
	s1[p] ++;
}

void plu1() {
	static int t[W + 1];
	int p = rt;
	fo(i, 0, W) {
		t[i] = p;
		swap(son[p][0], son[p][1]);
		p = son[p][0];
		if(!p) {
			ll s = 0;
			fd(j, i, 0) {
				p = t[j];
				s += (s1[son[p][1]] - s1[son[p][0]]) << j;
				s2[p] += s;
			}
			break;
		}
	}
}

ll calc2(int x) {
	ll ans = 0;
	fo(i, 1, W) {
		int y = son[x][1];
		ans += (s2[y] >> i) + s1[y];
		x = son[x][0];
		if(!x) break;
	}
	return ans;
}

ll calc() {
	return calc2(son[rt][0]) + calc2(son[rt][1]);
}

ll cc[N];

ll f[N * 2];

void solve(int xs) {
	int m = 0;
	fo(i, 1, d0) m = max(m, dis[d[i]]);
	if(m <= 80) {
		fo(i, 0, m) {
			cc[i] = 0;
			fo(j, 1, d0) {
				cc[i] += f[a[d[j]] + dis[d[j]] + i];
			}
		}
	} else {
		cl();
		fo(i, 1, d0) add(a[d[i]] + dis[d[i]]);
		cc[0] = calc();
		fo(i, 1, m) plu1(), cc[i] = calc();
		fo(i, 1, d0) {
			int v = dis[d[i]] + a[d[i]];
			fo(w, 0, 1) {
				fo(j, 0, W - 1) {
					int v2 = a2[j] * 2 + w - v;
					if(v2 > m) break;
					if(v2 >= 0) cc[v2] --;
				}
			}
		}
	}
	fo(i, 1, d0) {
		ans[d[i]] += cc[dis[d[i]]] * xs;
	}
}

void dg(int x) {
	fg(x);
	
	d0 = 0;
	dis[x] = 0;
	dfs(x);
	solve(1);
	
	bz[x] = 1;
	for(int i = fi[x]; i; i = nt[i]) {
		int y = to[i]; if(bz[y]) continue;
		d0 = 0;
		dis[y] = 1;
		dfs(y);
		solve(-1);
	}
	
	for(int i = fi[x]; i; i = nt[i]) {
		int y = to[i]; if(bz[y]) continue;
		siz[0] = siz[y], G = 0, fg(y);
		dg(G);
	}
}

int T;

void cle() {
	tt = 0;
	fo(i, 1, n)	{
		bz[i] = 0;
		fi[i] = 0;
		ans[i] = 0;
	}
}

int main() {
//	freopen("a.in", "r", stdin);
//	freopen("a.out", "w", stdout);
	fo(i, 2, 2e5) {
		int x = i / 2;
		f[i] = x / (x & -x);
		if(x == (x & -x)) f[i] = 0;
	}
	a2[0] = 1; fo(i, 1, W) a2[i] = a2[i - 1] * 2;
	scanf("%d", &T);
	fo(ii, 1, T) {
		cle();
		scanf("%d", &n);
		fo(i, 1, n) {
			scanf("%d", &a[i]);
			a[i] --;
		}
		fo(i, 1, n - 1) {
			scanf("%d %d", &x, &y);
			link(x, y); link(y, x);
		}
		siz[0] = mx[0] = n, G = 0, fg(1);
		dg(G);
		fo(i, 1, n - 1) pp("%lld ", ans[i] * 2);
		pp("%lld\n", ans[n] * 2);
	}
		
}
