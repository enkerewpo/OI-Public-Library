#include<bits/stdc++.h>
#define fo(i, x, y) for(int i = x, _b = y; i <= _b; i ++)
#define ff(i, x, y) for(int i = x, _b = y; i <  _b; i ++)
#define fd(i, x, y) for(int i = x, _b = y; i >= _b; i --)
#define ll long long
#define pp printf
#define hh pp("\n")
using namespace std;

int bp[105], p[105], p0;

void build_p(int n) {
	fo(i, 2, n) {
		if(!bp[i]) p[++ p0] = i;
		fo(j, 2, n / i) bp[i * j] = 1;
	}
}

#define ull unsigned long long

int T; ull n;
int k;

ull ans;

const int M = (1 << 8) + 5;

struct nod {
	ull a[M], b[M];
	int a0, b0;
} a[17];

void dg(int x, ull y, int xs) {
	if(x > k) {
		if(xs == 1) {
			a[k].a[++ a[k].a0] = y;
		} else {
			a[k].b[++ a[k].b0] = y;
		}
		return;
	}
	dg(x + 1, y * p[x], -xs);
	dg(x + 1, y, xs);
}

const int m = 9699690;
const int fm = 1658880;

int f[m + 5];

void build() {
	for(k = 1; k <= 16; k ++) {
		if(k <= 8) {
			dg(1, 1, 1);
		} else {
			dg(9, 1, 1);
		}
	}
	fo(j, 1, 8) for(int i = p[j]; i <= m; i += p[j])
		f[i] = 1;
	fo(i, 1, m) f[i] = (!f[i]) + f[i - 1];
}

int main() {
//	freopen("a.in", "r", stdin);
//	freopen("a.out", "w", stdout);
	build_p(100);
	build();
	for(scanf("%d", &T); T; T --) {
		scanf("%llu %d", &n, &k);
		ans = 0;
		if(k <= 8) {
			fo(i, 1, a[k].a0) {
				ans += n / a[k].a[i];
			}
			fo(i, 1, a[k].b0) {
				ans -= n / a[k].b[i];
			}
		} else {
			fo(i, 1, a[k].a0) {
				ull t = n / a[k].a[i];
				ans += ((t / m) * fm + f[t % m]);
			}
			fo(i, 1, a[k].b0) {
				ull t = n / a[k].b[i];
				ans -= ((t / m) * fm + f[t % m]);
			}
		}
		pp("%llu\n", ans);
	}
}
