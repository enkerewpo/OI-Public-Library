#include<bits/stdc++.h>
#define fo(i, x, y) for(int i = x, _b = y; i <= _b; i ++)
#define ff(i, x, y) for(int i = x, _b = y; i <  _b; i ++)
#define fd(i, x, y) for(int i = x, _b = y; i >= _b; i --)
#define ll long long
#define pp printf
#define hh pp("\n")
using namespace std;

const int N = 3005;

int n, mo;

int c[N][N];

ll ak[N], bk[N];

ll ans[N], ans0;

int T;

void work() {
	scanf("%d %d", &n, &mo);
	
	ans0 = 0;
	fo(i, 1, n + 1) ans[i] = 0;
	
	fo(i, 0, n) {
		c[i][0] = 1 % mo;
		fo(j, 1, i) c[i][j] = (c[i - 1][j - 1] + c[i - 1][j]) % mo;
	}
	
	fo(k, 1, n) {
		ak[0] = bk[0] = 1;
		fo(i, 1, n - k) ak[i] = ak[i - 1] * k % mo, bk[i] = bk[i - 1] * (k - 1) % mo;
		
		ll sum = 0;
		fo(i, 1, n - k) {
			ll v = ak[i - 1] * bk[n - k - i] % mo * c[n - i - 1][k - 1];
			sum = (sum + v) % mo;
			ans0 = (ans0 + v % mo * k) % mo;
		}
		ans0 = (ans0 + bk[n - k] * c[n - 1][k - 1]) % mo;
		ans[k] = (sum * n + bk[n - k] * c[n][k]) % mo;
	}
	fd(i, n, 1) ans[i] = (ans[i] + ans[i + 1]) % mo;
	
	pp("%lld\n", ans0);
	fo(i, 1, n - 1) pp("%lld ", ans[i]);
	pp("%lld\n", ans[n]);
}

int main() {
	scanf("%d", &T);
	fo(ii, 1, T) {
		work();
	}
}