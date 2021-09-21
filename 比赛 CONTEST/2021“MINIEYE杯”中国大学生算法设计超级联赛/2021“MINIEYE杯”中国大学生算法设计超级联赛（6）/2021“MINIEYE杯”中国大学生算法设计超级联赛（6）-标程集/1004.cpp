#include <bits/stdc++.h>

using namespace std;

void solve() {
	int n, t, ptr = 0; 
	scanf("%d%d", &n, &t);
	vector<int> euler(1, n-1);
	for(int i = 0; i < n/2; ++i) {
		int sgn = 1, ct = i;
		for(int d = 1; d < n; ++d) {
			euler.push_back(ct);
			ct = (ct + sgn*d + n-1) % (n-1);
			sgn *= -1;
		}
		euler.push_back(n-1);
	}
	while(t--) {
		int len; scanf("%d", &len);
		len++;
		while(len--) {
			printf("%d%c", euler[ptr++]+1, " \n"[len == 0]);
		}
		ptr--;
	}
}
int main(){
	int T; scanf("%d", &T);
	for(int i = 1; i <= T; ++i) {
		printf("Case #%d:\n", i);
		solve();
	}
    return 0;
}

