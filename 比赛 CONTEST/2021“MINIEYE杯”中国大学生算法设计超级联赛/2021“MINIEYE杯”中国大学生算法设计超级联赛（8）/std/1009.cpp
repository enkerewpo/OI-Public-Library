#include <bits/stdc++.h>
#define ll long long
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
const int maxn = 100010;
const int maxq = 30;
int T, opt, n, thi, len;
char s[maxn], a[maxn];
struct Trie {
    int son[maxn * 30][26], las[maxn * 30], fla[maxn * 30], r;
    void clear() {
        memset(son, 0, sizeof(son));
        memset(fla, 0, sizeof(fla));
        memset(las, 0, sizeof(las));
        r = 1;
    }
    int add(int thi, char x) {
        if (son[thi][x] == 0) {
            r++;
            son[thi][x] = r;
        }

        return son[thi][x];
    }
} tre;
int main() {

      freopen("std.in","r",stdin);
      freopen("std.out","w",stdout);

    T = read();

    for (opt = 1; opt <= T; opt++) {
        scanf("%s", s);
        len = strlen(s);
        tre.clear();

        for (int j = 0; j < len; j++) {
            thi = 1;

            for (int k = 0; k < min(len - j, maxq); k++) {
                thi = tre.add(thi, s[j + k] - 'a');

                if (tre.las[thi] <= j) {
                    tre.las[thi] = j + k + 1;
                    tre.fla[thi]++;
                }
            }
        }

        n = read();

        for (int i = 1; i <= n; i++) {
            scanf("%s", a);
            thi = 1;
            len = strlen(a);

            for (int j = 0; j < len; j++) {
                thi = tre.add(thi, a[j] - 'a');
            }

            printf("%d\n", tre.fla[thi]);
        }
    }

    return 0;
}
