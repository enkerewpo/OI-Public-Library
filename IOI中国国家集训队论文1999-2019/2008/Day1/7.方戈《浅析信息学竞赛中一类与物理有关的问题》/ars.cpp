#include <stdio.h>
#include <stdlib.h>
#include <memory.h>
#include <math.h>
#define Eps 1e-8
#define Equal(a, b) (fabs((a) - (b)) < Eps)
#define MAXN 101
#define MAXM 101
double pos[MAXN][3];
int ord[MAXN];
double a[MAXN * 3][MAXM];
int P, N, M, testID;
bool vis[MAXN * 3], ans1, ans2;
int main() {
  int v1, v2, k;
  double delta, mul;
  freopen("fg.in", "r", stdin);
  freopen("fg.out", "w", stdout);
  while (scanf("%d%d", &N, &M) && (N || M)) {
    P = 0;
    for (int i = 0; i < N; i ++) {
      scanf("%lf%lf%lf", &pos[i][0], &pos[i][1], &pos[i][2]);
      if (!Equal(pos[i][2], 0)) {
        ord[i] = P;
        P += 3;
      } else ord[i] = -1;
    }
    memset(a, 0, sizeof(a));
    for (int i = 0; i < M; i ++) {
      scanf("%d%d", &v1, &v2);
      v1 --; v2 --;
      for (int j = 0; j < 3; j ++) {
        delta = pos[v1][j] - pos[v2][j];
        if (ord[v1] != -1) {
          a[ord[v1] + j][i] = delta;
        }
        if (ord[v2] != -1) {
          a[ord[v2] + j][i] = -delta;
        }
      }
    }
    for (int i = 0; i < P / 3; i ++) {
      a[i * 3 + 2][M] = 1;
    }
    memset(vis, 0, sizeof(vis));
    for (int i = 0; i < M; i ++) {
      k = -1;
      for (int j = 0; j < P; j ++) {
        if (!vis[j] && !Equal(a[j][i], 0)) {
          k = j;
          break;
        }
      }
      if (k == -1) continue;
      vis[k] = true;
      for (int j = 0; j < P; j ++) if (j != k && !Equal(a[j][i], 0)) {
        mul = a[j][i] / a[k][i];
        for (int w = i; w <= M; w ++) {
          a[j][w] -= a[k][w] * mul;
        }
      }
    }
    ans1 = true;
    ans2 = false;
    for (int i = 0; i < P; i ++) if (!vis[i]) {
      if (!Equal(a[i][M], 0)) {
        ans1 = false;
        break;
      } else {
        ans2 = true;
      }
    }
    printf("Sculpture %d: ", ++ testID);
    if (!ans1) printf("NON-STATIC\n");
    else if (ans2) printf("UNSTABLE\n");
    else printf("STABLE\n");
  }
  return 0;
}
