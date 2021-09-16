#include <bits/stdc++.h>
using namespace std;

const int N = 1000000 + 9;
const int M = 998244353;

long long f[N], _S[N];

void Pre() {
    long long pow2 = 1;
    for (int i = 1; i < N; ++i) {
        pow2 = pow2 * 2 % M;
        f[i] = (pow2 - f[i] + M) % M;
        _S[i] = (f[i] + _S[i - 1]) % M;
        for (int j = i + i; j < N; j += i) {
            f[j] = (f[j] + f[i]) % M;
        }
    }
}

long long Pow2(long long n) {
    long long r = 1, x = 2;
    for (; n; n >>= 1) {
        if (n & 1) r = r * x % M;
        x = x * x % M;
    }
    return r;
}

struct Du {
    int tot, sqrtn;
    long long n, S[N * 2];
    int id(long long x) { return x <= sqrtn ? x : tot - n / x; }
    void Pre(long long _n) {
        tot = 1; n = _n; sqrtn = sqrt(n + 0.5);
        for (long long l = 1, r; l <= n; l = r + 1) {
            r = n / (n / l);
            S[tot++] = r < N ? _S[r] : -1;
        }
    }
    long long Calc_S(long long n) {
        if (~S[id(n)]) return S[id(n)];
        long long s = 0;
        for (long long l = 2, r; l <= n; l = r + 1) {
            r = n / (n / l);
            s += (r - l + 1) % M * Calc_S(n / l) % M;
        }
        s = ((Pow2(n + 1) - 2 - s) % M + M) % M;
        return S[id(n)] = s;
    }
    long long Calc_Ans(long long n) {
        Pre(n); Calc_S(n);
        long long ans = Pow2(n);
        for (long long l = 1, r; l <= n / 2; l = r + 1) {
            r = min(n / (n / l), n / 2);
            ans += (n / l - 1) * (S[id(r)] - S[id(l - 1)]) % M;
        }
        return (ans % M + M) % M;
    }
} du;

void solve() {
    long long n;
    scanf("%lld", &n);
    printf("%lld\n", du.Calc_Ans(n));
}

int main() {
    Pre();
    int T; scanf("%d", &T);
    while (T--) solve();
    return 0;
}