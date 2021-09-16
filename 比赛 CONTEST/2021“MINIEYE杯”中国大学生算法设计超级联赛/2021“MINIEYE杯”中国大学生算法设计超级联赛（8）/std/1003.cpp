#include <bits/stdc++.h>
using namespace std;
int read() {
    int tot = 0, fh = 1;
    char c = getchar();

    while ((c < '0') || (c > '9')) {
        if (c == '-')
            fh = -1;

        c = getchar();
    }

    while ((c >= '0') && (c <= '9')) {
        tot = tot * 10 + c - '0';
        c = getchar();
    }

    return tot * fh;
}
const int maxn = 5010;
const long long inf = 9 * 1e18;
struct node {
    long long x, y;
} a[maxn];
long long mp[maxn][maxn], f[maxn];
long long ans;
int i, j, k;
int n, mi, t;
long long len(int x, int y) {
    return (a[x].x - a[y].x) * (a[x].x - a[y].x) + (a[x].y - a[y].y) * (a[x].y - a[y].y);
}
int opt, T;
int main() {

    //  freopen("data.in","r",stdin);
    //  freopen("data.out","w",stdout);

    T = read();

    for (opt = 1; opt <= T; opt++) {

        n = read();
        ans = 0;

        for (i = 1; i <= n; i++) {
            a[i].x = read();
            a[i].y = read();
        }

        for (i = 1; i <= n; i++) {
            mp[i][i] = 0;

            for (j = i + 1; j <= n; j++) {
                mp[i][j] = len(i, j);
                mp[j][i] = mp[i][j];
            }
        }

        for (i = 1; i <= n; i++)
            f[i] = mp[1][i];

        f[1] = inf;

        for (k = 1; k < n; k++) {
            mi = 1;

            for (i = 2; i <= n; i++)
                if (f[mi] > f[i])
                    mi = i;

            t = 1;

            for (i = 1; i <= n; i++)
                if ((f[i] == inf) && (mp[t][mi] > mp[i][mi]))
                    t = i;

            ans = max(ans, mp[t][mi]);
            f[mi] = inf;

            for (i = 1; i <= n; i++)
                if (f[i] != inf)
                    f[i] = min(f[i], mp[mi][i]);
        }

        printf("%lld\n", ans);

    }

    return 0;
}
