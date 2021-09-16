#include<bits/stdc++.h>
using namespace std;
#define ls (x<<1)
#define rs (x<<1|1)
const int N = 1e5 + 5;
const int inf = 0x3f3f3f3f;
vector<int>e[N];
int tr[2][N << 2], lz[2][N << 2];

void push_down(int f, int x, int l, int r, int mid) {
	if (lz[f][x] == -1)return;
	tr[f][ls] = lz[f][x] * (mid - l + 1);
	tr[f][rs] = lz[f][x] * (r - mid);
	lz[f][ls] = lz[f][rs] = lz[f][x];
	lz[f][x] = -1;
}
void update(int f,int x, int l, int r, int L, int R, int v) {
	if (L <= l && R >= r) {
		tr[f][x] = (r - l + 1) * v;
		lz[f][x] = v;
		return;
	}
	int mid = (l + r) >> 1;
	push_down(f, x, l, r, mid);
	if (R <= mid)update(f, ls, l, mid, L, R, v);
	else if (L > mid)update(f, rs, mid + 1, r, L, R, v);
	else {
		update(f, ls, l, mid, L, mid, v);
		update(f, rs, mid + 1, r, mid + 1, R, v);
	}
	tr[f][x] = tr[f][ls] + tr[f][rs];
}
int query(int f, int x, int l, int r, int L, int R) {
	if (!tr[f][x])return inf;
	if (l == r)return l;
	int mid = l + r >> 1;
	push_down(f, x, l, r, mid);
	if (L <= l && R >= r) {
		if (tr[f][ls] > 0) return query(f, ls, l, mid, l, mid);
		else return query(f, rs, mid + 1, r, mid + 1, r);
	}
	else {
		if (R <= mid)return query(f, ls, l, mid, L, R);
		else if (L > mid)return query(f, rs, mid + 1, r, L, R);
		else return min(query(f, ls, l, mid, L, mid), query(f, rs, mid + 1, r, mid + 1, R));
	}
}
int main() {
	int T;
	scanf("%d", &T);
	while (T--) {
		int n, m, k;
		scanf("%d %d %d", &n, &m, &k);
		for (int i = 1; i <= n; ++i)e[i].clear();
		for (int i = 1; i <= (m << 2); ++i) {
			tr[0][i] = tr[1][i] = 0;
			lz[0][i] = lz[1][i] = -1;
		}
		for (int i = 0; i < k; ++i) {
			int x, y;
			scanf("%d %d", &x, &y);
			e[x].push_back(y);
		}
		long long ans = 0;
		update(0, 1, 1, m, 1, 1, 1);
		for (int x = 1; x <= n; ++x) {
			int l = 0;
			sort(e[x].begin(), e[x].end());
			for (auto& y : e[x]) {
				if (y - 1 >= l + 1) {
					int pos = query((x & 1) ^ 1, 1, 1, m, l + 1, y - 1);
					if (pos != inf)update(x & 1, 1, 1, m, pos, y - 1, 1);
				}
				l = y;
			}
			if (l + 1 <= m) {
				int pos = query((x & 1) ^ 1, 1, 1, m, l + 1, m);
				if (pos != inf)update(x & 1, 1, 1, m, pos, m, 1);
			}
			ans += tr[x & 1][1];
			update((x & 1) ^ 1, 1, 1, m, 1, m, 0);
		}
		printf("%lld\n", ans);
	}
	return 0;
}