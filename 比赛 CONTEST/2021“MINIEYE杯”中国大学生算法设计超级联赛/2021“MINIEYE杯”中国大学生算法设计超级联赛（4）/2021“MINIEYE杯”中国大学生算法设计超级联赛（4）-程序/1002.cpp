// Correct solution in time complexity O(n^2)
// Method: DFS
// Author: HeRaNO
#include <cstdio>
#include <vector>
#define MAXN 2005

const int N  = 2000;
const int b  = 19560929;
const int M1 = 1000000007;
const int M2 = 1000000009;

int n, ans, c[MAXN], p[MAXN], cnt[MAXN], _1[MAXN], _2[MAXN];
std::vector <int> g[MAXN];

inline void init(int n)
{
	_1[0] = _2[0] = 1;
	for (int i = 1; i <= n; i++)
		_1[i] = 1LL * _1[i - 1] * b % M1,
		_2[i] = 1LL * _2[i - 1] * b % M2;
	return ;
}

inline void fadd1(int &x, int y){ x += y; if (x >= M1) x -= M1; return ; }
inline void fadd2(int &x, int y){ x += y; if (x >= M2) x -= M2; return ; }

inline void add(int x)
{
	if (!cnt[x]) ++ans;
	++cnt[x]; return ;
}

inline void del(int x)
{
	if (cnt[x] == 1) --ans;
	--cnt[x]; return ; 
}

inline void DFS(int x, int f)
{
	add(c[x]); p[x] = ans;
	for (auto v : g[x]) if (v != f) DFS(v, x);
	del(c[x]);
	return ;
}

inline void Solve()
{
	scanf("%d", &n);
	for (int i = 2, x; i <= n; i++)
	{
		scanf("%d", &x);
		g[x].push_back(i); g[i].push_back(x);
	}
	for (int i = 1; i <= n; i++) scanf("%d", &c[i]);
	for (int i = 1; i <= n; i++)
	{
		DFS(i, -1);
		int h1 = 0, h2 = 0;
		for (int j = 1; j <= n; j++)
		{
			fadd1(h1, 1LL * p[j] * _1[j - 1] % M1);
			fadd2(h2, 1LL * p[j] * _2[j - 1] % M2);
		}
		printf("%d %d\n", h1, h2);
	}
	for (int i = 1; i <= n; i++)
		g[i].clear();
	return ;
}

int main()
{
	int T;
	init(N - 1);
	scanf("%d", &T);
	while (T--) Solve();
	return 0;
}