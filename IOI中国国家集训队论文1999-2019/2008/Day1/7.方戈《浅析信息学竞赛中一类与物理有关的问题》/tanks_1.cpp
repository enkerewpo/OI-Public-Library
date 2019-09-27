#include <stdio.h>
#include <stdlib.h>
#include <memory.h>
#include <math.h>
#define Eps 1e-10
#define KP 0.097
#define MAXN 11
double col_height[MAXN], pipe_height[MAXN], height[MAXN];
int N, testID;
double ans;
int work(int ID, double P, double V) {
  double a, b, c, delta, x1, x2;
  //(height[0] - height[ID] - x) * KP = V * P / (V - x) - 1
  //((height[0] - height[ID]) * KP + 1 - x * KP)(V - x) = V * P
  a = KP;
  b = - ((height[0] - height[ID]) * KP + 1) - V * KP;
  c = ((height[0] - height[ID]) * KP + 1) * V - V * P;
  delta = b * b - 4 * a * c;
  x1 = (- b - sqrt(delta)) / (2 * a);
  x2 = (- b + sqrt(delta)) / (2 * a);
  if (x1 < -Eps) height[ID] += x2;
  else height[ID] += x1;
  return 0;
}
int main() {
  double h1, h2, V, P;
  freopen("tanks.in", "r", stdin);
  freopen("tanks.out", "w", stdout);
  while (scanf("%d", &N) && N) {
    V = ans = 0;
    for (int i = 0; i < N; i ++) {
      scanf("%lf", &col_height[i]);
      V += col_height[i];
    }
    for (int i = 0; i < N - 1; i ++) {
      scanf("%lf", &pipe_height[i]);
    }
    memset(height, 0, sizeof(height));
    height[0] = col_height[0];
    height[1] = pipe_height[0];
    V -= height[0];
    V -= height[1];
    P = 1;
    for (int i = 1; i < N; i ++) {
      h1 = pipe_height[i] - pipe_height[i - 1];
      h2 = pipe_height[i];
      if (i == N - 1 || P * V / (V - h1) - 1 >= (col_height[0] - pipe_height[i]) * KP) {
        work(i, P, V);
        break;
      } else if (P * V / (V - h1 - h2) - 1 >= (col_height[0] - pipe_height[i]) * KP) {
        height[i] += h1;
        height[i + 1] = V - h1 - P * V / ((col_height[0] - pipe_height[i]) * KP + 1);
        break;
      } else {
        height[i] += h1;
        height[i + 1] += h2;
        P = P * V / (V - h1 - h2);
        work(i, P, col_height[i] - pipe_height[i]);
        V -= h1 + h2 + col_height[i] - pipe_height[i];
      }
    }
    for (int i = 0; i < N; i ++) {
      ans += height[i]; 
    }
    printf("Case %d: %.3lf\n\n", ++ testID, ans);
  }
  return 0;
}
