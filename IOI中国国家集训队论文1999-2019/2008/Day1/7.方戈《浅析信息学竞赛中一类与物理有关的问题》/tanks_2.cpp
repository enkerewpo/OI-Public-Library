#include <stdio.h>
#include <stdlib.h>
#include <memory.h>
#include <math.h>
#define Eps 1e-10
#define MAXN 100
#define oo 1990518000
double H[MAXN], hi[MAXN], sum[MAXN];
double nowh[MAXN];
int testID, N;
double ans;
int work2(int pos, double V, double P) {
  double a, b, c, t1, t2, delta;
//  V * P / (V - x) - 1 = 0.097 * (H[0] - nowh[pos] - x);
  a = 0.097;
  b = - (1 + 0.097 * (H[0] - nowh[pos])) - 0.097 * V;
  c = (1 + 0.097 * (H[0] - nowh[pos]) - P) * V;
  delta = sqrt(b * b - a * c * 4);
  t1 = (-b - delta) / (a * 2);
  t2 = (-b + delta) / (a * 2);
  if (t1 > -Eps) nowh[pos] += t1;
  else nowh[pos] += t2;
  return 0;
}
int work(int left, double P) {
  double rest, V, t;
  int k;
  work2(left, sum[left] - nowh[left], P);
  if (nowh[left] < hi[left + 1]) return 0;
  nowh[left] = hi[left + 1];
  P = P * (sum[left] - hi[left]) / (sum[left] - nowh[left]);
  V = sum[left] - nowh[left];
  rest = V - P * V / (1 + 0.097 * (H[0] - nowh[left]));
  for (int i = left + 1; i < N; i ++) {
    if (rest < hi[i] && rest < hi[i + 1]) {
      nowh[i] = rest; return 0;
    }
    if (hi[i + 1] <= hi[i]) {
      nowh[i] = hi[i + 1];
      P = P * V / (V - nowh[i]);
      V -= nowh[i];
      rest -= nowh[i];
    } else {
      nowh[i] = hi[i];
      P = P * V / (V - nowh[i]);
      V -= sum[i];
      work(i, P);
      k = i;
      break;
    }
  }
  for (int i = k - 1; i >= left + 1; i --) {
    t = V - P * V / (1 + 0.097 * (H[0] - nowh[left]));
    if (nowh[i] + t < hi[i]) {
      nowh[i] += t; return 0;
    }
    P = P * V / (V - hi[i] + nowh[i]);
    V -= H[i] - nowh[i];
    nowh[i] = hi[i];
    work2(i, H[i] - nowh[i], P);
  }
  work2(left, V, P);
}
int main() {
  freopen("tanks.in", "r", stdin);
  freopen("tanks.out", "w", stdout);
  while (scanf("%d", &N) && N) {
    for (int i = 0; i < N; i ++) {
      scanf("%lf", &H[i]);
    }
    sum[N] = 0;
    for (int i = N - 1; i >= 0; i --) {
      sum[i] = H[i] + sum[i + 1];
    }
    for (int i = 1; i < N; i ++) {
      scanf("%lf", &hi[i]);
    }
    hi[N] = 0;
    memset(nowh, 0, sizeof(nowh));
    nowh[0] = H[0];
    for (int i = 1; i < N; i ++) {
      nowh[i] = hi[i];
      if (hi[i] >= hi[i + 1]) {
        work2(i, H[i] - nowh[i], 1);
      } else {
        hi[N] = oo;
        work(i, 1);
        break;
      }
    }
    ans = 0;
    for (int i = 0; i < N; i ++) {
      ans += nowh[i];
    }
    printf("Case %d: %.3lf\n\n", ++ testID, ans);
  }
  return 0;
}
