#include <stdio.h>
#include <stdlib.h>
#include <memory.h>
#define MAXN 1000
#define MAXM 1000
#define Eps 1e-8
const int dx[4] = {0, 1, 0, -1};
const int dy[4] = {1, 0, -1, 0};
int N, M, P, Q;
int map[MAXN][MAXM];
int size[MAXN*MAXM], pos[MAXN*MAXM], bl[MAXN*MAXM], fa[MAXN * MAXM];
double V[MAXN*MAXM], ans;
int list[MAXN*MAXM][2];
int bfs(int stx, int sty, int ID, int height) {
  int head = 0, tail = 1, x, y;
  bl[map[stx][sty]] = ID;
  list[0][0] = stx; list[0][1] = sty;
  while (head < tail) {
    size[ID] += height - map[list[head][0]][list[head][1]];
    for (int i = 0; i < 4; i ++) {
      x = list[head][0] + dx[i];
      y = list[head][1] + dy[i];
      if (x >= 0 && x < N && y >= 0 && y < M && bl[map[x][y]] == -1 && map[x][y] < height) {
        list[tail][0] = x;
        list[tail][1] = y;
        bl[map[x][y]] = ID;
        tail ++;
      }
    }
    head ++;
  }
  return 0;
}
int pour(int k) {
  int cnt = 0, t;
  int px = pos[k] / M, py = pos[k] % M;
  bool lower[4];
  double rest = 0;
  memset(lower, 0, sizeof(lower));
  for (int i = 0; i < 4; i ++) {
    if (px + dx[i] < 0 || px + dx[i] == N || py + dy[i] < 0 || py + dy[i] == M) {
      cnt ++;
    } else {
      t = map[px + dx[i]][py + dy[i]];
      if (t < k && (fa[bl[t]] != k || V[bl[t]] < size[bl[t]] - Eps)) {
        cnt ++;
        lower[i] = true;
      }
    }
  }
  for (int i = 0; i < 4; i ++) {
    if (px + dx[i] < 0 || px + dx[i] == N || py + dy[i] < 0 || py + dy[i] == M) {
      ans += V[bl[k]] / cnt;
    } else {
      t = map[px + dx[i]][py + dy[i]];
      if (lower[i]) {
        V[bl[t]] += V[bl[k]] / cnt;
      }
      if (fa[bl[t]] == k && V[bl[t]] > size[bl[t]]) {
        rest += V[bl[t]] - size[bl[t]];
        V[bl[t]] = size[bl[t]];
      }
    }
  }
  V[bl[k]] = rest;
  return 0;
}
bool can(int x, int y) {
  if (x == 0 || x == N - 1 || y == 0 || y == M - 1) return true;
  for (int i = 0; i < 4; i ++) {
    if (bl[map[x + dx[i]][y + dy[i]]] != -1) return true;
  }
  return false;
}
int main() {
  int v1, v2, v3, px, py, x, y;
  freopen("fg.in", "r", stdin);
  freopen("fg.out", "w", stdout);
  scanf("%d%d", &N, &M);
  for (int i = 0; i < N; i ++) {
    for (int j = 0; j < M; j ++) {
      scanf("%d", &map[i][j]);
      map[i][j] --;
      pos[map[i][j]] = i * M + j;
    }
  }
  memset(bl, 255, sizeof(bl));
  memset(fa, 255, sizeof(fa));
  for (int i = 0; i < N * M; i ++) {
    px = pos[i] / M;
    py = pos[i] % M;
    if (can(px, py)) {
      bl[i] = P ++;
      for (int j = 0; j < 4; j ++) {
        x = px + dx[j]; 
        y = py + dy[j];
        if (x >= 0 && x < N && y >= 0 && y < M && bl[map[x][y]] == -1 && map[x][y] < i) {
          fa[P] = i;
          bfs(x, y, P ++, i);
        }
      }
    }
  }
  scanf("%d", &Q);
  for (int i = 0; i < Q; i ++) {
    scanf("%d%d%d", &v1, &v2, &v3);
    v1 --; v2 --;
    V[bl[map[v1][v2]]] += v3;
  }
  for (int i = N * M - 1; i >= 0; i --) if (!size[bl[i]]) {
    while (true) {
      pour(i);
      if (V[bl[i]] < Eps) break;
    }
  }
  printf("%.2lf\n", ans);
  return 0;
}
