#include <bits/stdc++.h>
using namespace std;

const int N = 100000 + 9;

template <int Nv, int Ne> struct Graph {  // "Ne * 2" if edges are undirected.
    int tot, hd[Nv], nxt[Ne], to[Ne], val[Ne];
    void init(int n) { tot = -1; memset(hd, -1, (n + 5) * sizeof(*hd)); }
    void addedge(int u, int v, int w)
        { nxt[++tot] = hd[u]; to[hd[u] = tot] = v; val[tot] = w; }
    void addedge2(int u, int v, int w) { addedge(u, v, w); addedge(v, u, w); }
};

Graph<N, N * 2> G;

template <int N, int logN> struct RMQ_LCA {  // "N * 2"
    int tot, first[N], E[N], dep[N], lca[N][logN], Log2[N];
    void dfs(int u, int p) {
        E[first[u] = ++tot] = u; dep[u] = dep[p] + 1;
        for (int e = G.hd[u]; ~e; e = G.nxt[e]) {
            int v = G.to[e]; if (v != p) { dfs(v, u); E[++tot] = u; }
        }
    }
    void init(int rt) {
        tot = 0; dfs(rt, 0); Log2[1] = 0;
        for (int i = 2; i <= tot; ++i) Log2[i] = Log2[i >> 1] + 1;
        for (int i = 1; i <= tot; ++i) lca[i][0] = E[i];
        for (int j = 1; j < logN; ++j)
            for (int i = 1; i + (1 << j) - 1 <= tot; ++i) {
                int u = lca[i][j - 1], v = lca[i + (1 << (j - 1))][j - 1];
                lca[i][j] = dep[u] < dep[v] ? u : v;
            }
    }
    int operator()(int u, int v) {
        int L = first[u], R = first[v]; if (L > R) swap(L, R);
        int d = Log2[R - L + 1]; u = lca[L][d]; v = lca[R - (1 << d) + 1][d];
        return dep[u] < dep[v] ? u : v;
    }
};

RMQ_LCA<N * 2, 18> rmq_lca;

template <int Nv, int Nq, int S> struct Mo_Algorithm {
    int tmp, top, tot, dep[Nv], pre[Nv], nxt[Nv], ans[Nq];
    struct Modify { int u, tot; } sk[Nv];
    struct Query {
        int l, r, id;
        bool operator<(const Query &b) const {
            return l / S == b.l / S ? r > b.r : l < b.l;
        }
    } Q[Nq];
    void dfs(int u, int p) {
        pre[u] = tmp; nxt[tmp] = u; tmp = u;
        for (int e = G.hd[u]; ~e; e = G.nxt[e]) {
            int v = G.to[e]; if (v == p) continue;
            dep[v] = dep[u] + G.val[e];
            tot += G.val[e]; dfs(v, u);
        }
    }
    void del(int u) {
        sk[++top] = {u, tot};
        int l = pre[u], r = nxt[u];
        if (l && r) {
            tot -= dep[u] - max(dep[rmq_lca(l, u)], dep[rmq_lca(u, r)]);
            nxt[l] = r; pre[r] = l;
        }
        else {
            int pre_lca = rmq_lca(nxt[0], pre[0]);
            nxt[l] = r; pre[r] = l;
            int cur_lca = rmq_lca(nxt[0], pre[0]);
            if (cur_lca == pre_lca) {
                if (l) tot -= dep[u] - dep[rmq_lca(l, u)];
                else tot -= dep[u] - dep[rmq_lca(u, r)];
            }
            else {
                tot -= dep[u] + dep[cur_lca] - 2 * dep[pre_lca];
            }
        }
    }
    void undo() {
        tot = sk[top].tot;
        int u = sk[top--].u;
        nxt[pre[u]] = u; pre[nxt[u]] = u;
    }
    void operator()(int n, int m) {
        sort(Q + 1, Q + m + 1);
        tmp = top = tot = dep[1] = 0;
        dfs(1, 0); nxt[pre[0] = tmp] = 0;
        for (int l = 1, r = n, i = 1; i <= m; ++i) {
            int L = Q[i].l, R = Q[i].r;
            int _L = max(1, L / S * S);
            if (l < _L) {
                for (; r < n; ++r) undo();
                while (l < _L) del(l++);
            }
            while (r > R) del(r--);
            while (l < L) del(l++);
            ans[Q[i].id] = tot * 2;
            for (; l > _L; --l) undo();
        }
    }
};

Mo_Algorithm<N, N, 256> mo;

void solve() {
    int n, m;
    scanf("%d %d", &n, &m);
    G.init(n);
    for (int i = 1; i < n; ++i) {
        int u, v, w;
        scanf("%d %d %d", &u, &v, &w);
        G.addedge2(u, v, w);
    }
    rmq_lca.init(1);
    for (int i = 1; i <= m; ++i) {
        scanf("%d %d", &mo.Q[i].l, &mo.Q[i].r);
        mo.Q[i].id = i;
    }
    mo(n, m);
    for (int i = 1; i <= m; ++i) {
        printf("%d\n", mo.ans[i]);
    }
}

int main() {
    int T; scanf("%d", &T);
    while (T--) solve();
    return 0;
}