#include <bits/stdc++.h>
using namespace std;

typedef pair<int, int> pii;

const int P = 998244353;
int add(int a, int b) { a += b; return a < P ? a : a - P; }
int sub(int a, int b) { a -= b; return a < 0 ? a + P : a; }

const int N = 100001;
int a[N], dp[N];

void solve(int l, int r) {
    if (l + 1 == r) return;
    int mid = (l + r) >> 1;
    solve(l, mid);
    vector<int> pos(r - l);
    iota(pos.begin(), pos.end(), l);
    sort(pos.begin(), pos.end(), [&](int i, int j) { return a[i] < a[j]; });
    vector<int> ls, rs;
    vector<int> sum(1, 0);
    for (int i : pos) {
        if (i < mid) {
            while (!ls.empty() && ls.back() < i)
                sum.pop_back(), ls.pop_back();
            ls.push_back(i);
            sum.push_back(add(sum.back(), dp[i]));            
        }
        else {
            while (!rs.empty() && rs.back() > i)
                rs.pop_back();
            if (ls.empty()) continue;
            int id1 = partition_point(ls.begin(), ls.end(), [&](int x) { return a[x] < a[i]; }) - ls.begin();
            int id2 = rs.empty() ? 0 : partition_point(ls.begin(), ls.end(), [&](int x) { return a[x] < a[rs.back()]; }) - ls.begin();
            dp[i] = add(dp[i], sub(sum[id1], sum[id2]));
            rs.push_back(i);
        }
    }
    solve(mid, r);
}

int main(void) {
    int T; scanf("%d", &T);
    while (T--) {
        int n; scanf("%d", &n);
        for (int i = 1; i <= n; ++i)
            scanf("%d", &a[i]);
        for (int i = 1, v = INT_MAX; i <= n; ++i) {
            if (v > a[i])
                dp[i] = 1;
            else 
                dp[i] = 0;
            v = min(v, a[i]);
        }
        solve(1, n + 1);
        int ans = 0;
        for (int i = n, v = 0; i >= 1; --i) {
            if (v < a[i])
                ans = add(ans, dp[i]);
            v = max(v, a[i]);
        }
        printf("%d\n", ans);
    }
    return 0;
}