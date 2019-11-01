#include <stdio.h>
int n;
int list[524288];
int rank[2][524288];
int itree[20][524288];
int ans;

int main(void) {
  int i, t;
  int level, offset;

  scanf("%d", &n);
  for (i=1; i<=n; i++) scanf("%d", &list[i]);
  for (i=1; i<=n; i++) {
    scanf("%d", &t);
    rank[0][t] = i;
  }
  for (i=1; i<=n; i++) {
    scanf("%d", &t);
    rank[1][t] = i;
  }
  for (i=1; i<=n; i++) {
    t = 1;
    for (level=0, offset=rank[1][list[i]]; level<=19; level++,offset/=2) {
      if (!itree[level][offset] ||rank[0][list[i]]<itree[level][offset])
itree[level][offset] = rank[0][list[i]];
      if (offset%2 && itree[level][offset-1] &&itree[level][offset-1]<rank[0][list[i]]) {
        t = 0;
        break;
      }
    }
    ans += t;
  }
  printf("%d\n", ans);
  return 0;
}
