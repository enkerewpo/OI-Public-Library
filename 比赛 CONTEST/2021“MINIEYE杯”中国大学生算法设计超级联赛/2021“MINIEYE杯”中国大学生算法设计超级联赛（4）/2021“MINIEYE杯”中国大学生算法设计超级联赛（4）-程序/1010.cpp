#include <bits/stdc++.h>

using namespace std;

const int N = 400 + 10;
const int P = 1000000000 + 7;

int add(int a, int b) { return a + b < P ? a + b : a + b - P; }
int sub(int a, int b) { return a - b < 0 ? a - b + P : a - b; }
int mul(int a, int b) { return 1LL * a * b % P; }

int dx[] = {-1, 1, 0, 0};
int dy[] = {0, 0, -1, 1};

int id[N][N], tot;
int p[N][N][4];

int qpow(int a, int k = P - 2) {
    int res = 1;
    while (k) {
        if (k & 1)  res = mul(res, a);
        a = mul(a, a);
        k >>= 1;
    }
    return res;
}
 
struct Mat {
    int n, m, a[N][N];
    Mat operator * (const Mat &B) const {
        Mat res;
        res.n = n;
        res.m = B.m;
        for (int i = 1; i <= res.n; i++) {
            for (int j = 1; j <= res.m; j++) {
                int tmp = 0;
                for (int k = 1; k <= m; k++) {
                    tmp = add(tmp, mul(a[i][k], B.a[k][j]));
                }
                res.a[i][j] = tmp;
            }
        }
        return res;
    }
    Mat I() {
        Mat res;
        res.n = n;
        res.m = m;
        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= m; j++) {
                res.a[i][j] = i == j;
            }
        }
        return res;
    }
    void Print() {
        for (int i = 1; i <= m; i++) {
            for (int j = 1; j <= m; j++) {
                printf("%10d ", a[i][j]);
            } puts("");
        }
    }
    int Sum() {
        int res = 0;
        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= m; j++) {
                res = add(res, a[i][j]);
            }
        }
        return res;
    }
    void Update(int x, int y, int d) {
        if (d == 0) return;
        Mat A1, A2;
        A1.n = n;   A1.m = 1;
        for (int i = 1; i <= n; i++)    A1.a[i][1] = a[i][x];
        A2.n = 1;   A2.m = m;
        for (int j = 1; j <= m; j++)    A2.a[1][j] = a[y][j];
        Mat A12 = A1 * A2;
        assert(add(qpow(d), a[y][x]) != 0);
        int tmp = qpow(add(qpow(d), a[y][x]));
        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= n; j++) {
                a[i][j] = sub(a[i][j], mul(tmp, A12.a[i][j]));
            }
        }
    }
}A, B;


Mat inv(Mat A) {
    Mat B = A.I();
    int n = A.n;
    for (int i = 1; i <= n; i++) {
        int r = i;
        while (r <= n && A.a[r][i] == 0)  r++;
        if (r > n)  return A.I();
        for (int j = 1; j <= n; j++)    swap(A.a[i][j], A.a[r][j]), swap(B.a[i][j], B.a[r][j]);
        int inv_a_ii = qpow(A.a[i][i]);
        for (int j = 1; j <= n; j++) {
            A.a[i][j] = mul(A.a[i][j], inv_a_ii);
            B.a[i][j] = mul(B.a[i][j], inv_a_ii);
        }
        for (r = 1; r <= n; r++) {
            if (!A.a[r][i] || r == i)   continue;
            int tmp = A.a[r][i];
            for (int j = 1; j <= n; j++) {
                A.a[r][j] = sub(A.a[r][j], mul(tmp, A.a[i][j]));
                B.a[r][j] = sub(B.a[r][j], mul(tmp, B.a[i][j]));
            }
        }
    }
    return B;
}

int main() {
    int n, m, q;    scanf("%d %d %d", &n, &m, &q);
    A.n = A.m = B.n = n * m;
    B.m = 1;
    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= m; j++) {
            id[i][j] = ++tot;
            A.a[tot][tot] = B.a[tot][1] = 1;
        }
    }
    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= m; j++) {
            int u = id[i][j];
            for (int k = 0; k < 4; k++) {
                int x = i + dx[k], y = j + dy[k];    scanf("%d", &p[i][j][k]);
                if (x < 1 || x > n || y < 1 || y > m)   continue;
                else    A.a[u][id[x][y]] = sub(0, p[i][j][k]);
            }
        }
    }
    Mat AA = inv(A);
    while (q--) {
        int opt;    scanf("%d", &opt);
        if (opt == 1) {
            int i, j;   scanf("%d %d", &i, &j);
            int u = id[i][j];
            for (int k = 0; k < 4; k++) {
                int x = i + dx[k], y = j + dy[k], tmp;  scanf("%d", &tmp);
                if (x < 1 || x > n || y < 1 || y > m || tmp == p[i][j][k])   continue;
                else {
                    AA.Update(u, id[x][y], sub(p[i][j][k], tmp));
                    A.a[u][id[x][y]] = sub(0, p[i][j][k] = tmp);
                }
            }
        }
        else if (opt == 2) {
            // (AA * A).Print();
            int ans = (AA * B).Sum();
            printf("%d\n", ans);
        }
    }
    return 0;
}