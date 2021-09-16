#include <bits/stdc++.h>

using namespace std;

int main() {
  ios::sync_with_stdio(false);
  cin.tie(0);
  int T;
  cin >> T;
  while (T--) {
    int n, m;
    cin >> n >> m;
    assert(m >= 1 && m <= n && n <= 100000);
    vector<int> f(n + 2);
    f[n + 1] = 1;
    while (m--) {
      int v;
      cin >> v;
      assert(v >= 1 && v <= n);
      assert(f[v] == 0);
      f[v] = 1;
    }
    vector<pair<int, int>> size;
    int have = 0;
    int count = 0;
    for (int i = 1; i <= n + 1; i++) {
      if (f[i]) {
        if (have) {
          size.push_back(make_pair(have, count));
        }
        have = 0;
        count += 1;
      } else {
        have += 1;
      }
    }
    sort(size.begin(), size.end());
    if (size.empty()) {
      cout << "YES\n";
      continue;
    }
    int sum = 0;
    for (auto s: size) {
      sum += s.first;
    }
    if (size.back().first <= sum - size.back().first + size.back().second) {
      cout << "YES\n";
    } else {
      cout << "NO\n";
    }
  }
  return 0;
}
