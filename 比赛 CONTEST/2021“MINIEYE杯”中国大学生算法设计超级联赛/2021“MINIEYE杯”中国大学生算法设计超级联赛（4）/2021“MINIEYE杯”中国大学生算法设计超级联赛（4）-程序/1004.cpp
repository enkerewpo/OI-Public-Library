#include <bits/stdc++.h>
using namespace std;

const int N = 100000 + 9;

char s[N];
int n, c[26];
long long k;

template <int N, int sigma> struct Suffix_Automaton {
    int tot, last, nxt[N * 2][sigma], len[N * 2], link[N * 2];
    int sum[N], pos[N * 2];
    vector<int> ch[N * 2];
    void init(int n) {
        tot = last = 0; link[0] = -1;
        memset(nxt, 0, (n * 2 + 5) * sigma * sizeof(int));
        memset(pos, 0, (n * 2 + 5) * sizeof(int));
        for (int i = 0; i < n * 2 + 5; ++i) ch[i].clear();
    }
    void add_char(int c) {
        int p = last, cur = last = ++tot; len[cur] = len[p] + 1;
        while (~p && !nxt[p][c]) { nxt[p][c] = cur; p = link[p]; }
        if (p == -1) { link[cur] = 0; return; }
        int q = nxt[p][c];
        if (len[q] == len[p] + 1) { link[cur] = q; return; }
        int _q = ++tot; len[_q] = len[p] + 1;
        memcpy(nxt[_q], nxt[q], sigma * sizeof(int));
        link[_q] = link[q]; link[q] = link[cur] = _q;
        while (~p && nxt[p][c] == q) { nxt[p][c] = _q; p = link[p]; }
    }
    void dfs(int u) {
        for (int v : ch[u]) dfs(v);
        if (!pos[u]) pos[u] = pos[ch[u][0]];
    }
    void add_string(const char s[], int n) {
        for (int i = 1; i <= n; ++i) {
            sum[i] = sum[i - 1] + c[s[i] - 'a'];
            add_char(s[i] - 'a');
            pos[last] = i;
        }
        for (int i = 1; i <= tot; ++i) {
            ch[link[i]].push_back(i);
        }
        dfs(0);
    }
    bool check(int C) {
        long long cnt = 0;
        for (int i = 1; i <= tot; ++i) {
            int P = pos[i], L = P - len[i] + 1, R = P - len[link[i]];
            while (L < R) {
                int M = (L + R) >> 1;
                if (sum[P] - sum[M - 1] <= C) R = M;
                else L = M + 1;
            }
            if (sum[P] - sum[L - 1] <= C) cnt += P - len[link[i]] - L + 1;
        }
        return cnt >= k;
    }
};

Suffix_Automaton<N, 26> sam;

void solve() {
    scanf("%d %lld", &n, &k);
    scanf("%s", s + 1);
    for (int i = 0; i < 26; ++i) {
        scanf("%d", c + i);
    }
    sam.init(n);
    sam.add_string(s, n);
    int L = 1, R = sam.sum[n];
    while (L < R) {
        int M = (L + R) >> 1;
        if (sam.check(M)) R = M;
        else L = M + 1;
    }
    if (sam.check(L)) printf("%d\n", L);
    else printf("-1\n");
}

int main() {
    int T; scanf("%d", &T);
    while (T--) solve();
    return 0;
}