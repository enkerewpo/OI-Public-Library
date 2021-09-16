#include <bits/stdc++.h>

using namespace std;
using ll = long long;

int main() {
  ios::sync_with_stdio(false);
  cin.tie(0);
  int T;
  cin >> T;
  while (T--) {
    int n;
    cin >> n;
    vector<ll> s(n + 1);
    vector<int> f(n + 1);
    int sumF = 0;
    for (int i = 1; i <= n; i++) {
      cin >> s[i];
      string str;
      cin >> str;
      f[i] = (str[0] - '0') * 100 + (str[2] - '0') * 10 + str[3] - '0';
      sumF += f[i];
    }
    while (sumF * sumF >= 10000 * (n + 2)) {
      sumF -= 1;
    }
    ll ans = 0;
    for (int sum = 1; sum <= sumF; sum++) {
      vector<ll> dp(sum + 1);
      for (int i = 1; i <= n; i++) {
        if (f[i] == 0 || f[i] > sum) {
          continue;
        }
        ll s2 = s[i] * (100 * 100 + f[i] * f[i] - f[i] * sum);
        if (s2 <= 0) {
          continue;
        }
        for (int j = sum; j >= f[i]; j--) {
          dp[j] = max(dp[j], dp[j - f[i]] + s2);
        }
      }
      ans = max(ans, dp[sum]);
    }
    for (int i = 1; i <= n; i++) {
      if (f[i] == 0) {
        ans += s[i] * 100 * 100;
      }
    }
    string ret = to_string(ans);
    while (ret.size() < 5) {
      ret = "0" + ret;
    }
    ret = ret.substr(0, ret.size() - 4) + "." + ret.substr(ret.size() - 4, 4);
    ret += "00000";
    cout << ret << "\n";
  }
  return 0;
}