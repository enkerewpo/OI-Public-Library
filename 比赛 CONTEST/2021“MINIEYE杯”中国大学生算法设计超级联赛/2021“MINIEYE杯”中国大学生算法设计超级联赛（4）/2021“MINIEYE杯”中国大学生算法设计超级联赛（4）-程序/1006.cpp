#include <bits/stdc++.h>
#define N 1000001
using namespace std;

typedef long long ll;

const ll inf = 4e13;
struct edge { int u, v; ll w; } es[N];
int ls[N], rs[N], dis[N];
ll val[N], tag[N];

void update(int x, ll t) { val[x] += t;tag[x] += t; }
void push_down(int x) {
    if (ls[x]) update(ls[x], tag[x]);
    if (rs[x]) update(rs[x], tag[x]);
    tag[x] = 0;
}

int merge(int x, int y) {
    if (!x || !y) return x | y;
    if (val[x] > val[y]) swap(x, y);
    push_down(x);
    rs[x] = merge(rs[x], y);
    if (dis[ls[x]] < dis[rs[x]]) swap(ls[x], rs[x]);
    dis[x] = dis[rs[x]] + 1;
    return x;
}

int top[N], fa[N], ine[N];
int f[N]; int find(int x) { return f[x] ? f[x] = find(f[x]) : x; }
vector<int> ch[N];

ll ans[N];
void dfs(int u, ll s) {
    if (ch[u].empty())
        ans[u] = s >= inf ? -1 : s;
    else for (int v : ch[u])
        dfs(v, s - val[ine[v]]);
}

void solve(int n, int m) {
    for (int i = 1; i <= 2 * n; ++i) top[i] = fa[i] = ine[i] = f[i] = 0, ch[i].clear();
    for (int i = 1; i <= n; ++i) es[++m] = { i % n + 1, i, inf };
    for (int i = 1; i <= m; ++i) {
        ls[i] = rs[i] = tag[i] = dis[i] = 0;
        val[i] = es[i].w;
        top[es[i].v] = merge(top[es[i].v], i);
    }
    int x = 1;
    while (top[x]) {
        int i = top[x], y = find(es[i].u);
        top[x] = merge(ls[i], rs[i]);
        if (y == x) continue;
        ine[x] = i;
        if (!ine[es[i].u]) x = y;
        else for (int z = ++n; x != z; x = find(es[ine[x]].u)) {
            fa[x] = f[find(x)] = z;
            ch[z].push_back(x);
            if (top[x]) update(top[x], -val[ine[x]]);
            top[z] = merge(top[z], top[x]);
        }
    }
    
    ll sum = 0;
    for (int i = 1; i <= n; ++i)
        sum += val[ine[i]];
    dfs(n, sum);
}

int main(void) {
    int T; scanf("%d", &T);
    while (T--) {
        int n, m; scanf("%d %d", &n, &m);
        for (int i = 1; i <= m; ++i)
            scanf("%d %d %lld", &es[i].u, &es[i].v, &es[i].w);
        solve(n, m);
        for (int i = 1; i <= n; ++i)
            printf("%lld\n", ans[i]);
    }
    return 0;
}