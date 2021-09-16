#include <iostream>
#include <cstdio>
#include <cstdlib>
#include <cmath>
#include <algorithm>
#include <cstring>
using namespace std;
const int maxn=1e5+10;
int T,n,m,k,a[maxn],num[maxn],sum[maxn],ans[maxn];
struct da{int l,r,L,R,id;}q[maxn];
bool cmp(da aa,da bb){
        if (aa.l/k==bb.l/k){
                if ((aa.l/k)&1) return aa.r<bb.r;else return aa.r>bb.r;
       }
        return aa.l/k<bb.l/k;
}
void add(int x) {if (++num[x]==1) sum[x/k]++;}
void dec(int x) {if (--num[x]==0) sum[x/k]--;}
int calc(int x){
        int now=0;
        for (int i=0;i<x/k;i++) now+=sum[i];
        for (int i=(x/k)*k;i<=x;i++) now+=(num[i]>=1);
        return now;
}
void solve(){
        memset(num,0,sizeof num); memset(sum,0,sizeof sum); scanf("%d%d",&n,&m); k=313;
        for (int i=1;i<=n;i++) scanf("%d",&a[i]);
        for (int i=1;i<=m;i++) scanf("%d%d%d%d",&q[i].l,&q[i].L,&q[i].r,&q[i].R),q[i].id=i;
        sort(q+1,q+m+1,cmp); int pl=q[1].l,pr=q[1].r;
        for (int i=pl;i<=pr;i++) add(a[i]);
        ans[q[1].id]=calc(q[1].R)-calc(q[1].L-1);
        for (int i=2;i<=m;i++){
                while (pl>q[i].l) pl--,add(a[pl]);
                while (pr<q[i].r) pr++,add(a[pr]);
                while (pl<q[i].l) dec(a[pl]),pl++;
                while (pr>q[i].r) dec(a[pr]),pr--;
                ans[q[i].id]=calc(q[i].R)-calc(q[i].L-1);
        }
        for (int i=1;i<=m;i++) printf("%d\n",ans[i]);
}
int main(){
		freopen("1.in","r",stdin);
		freopen("1.out","w",stdout);
        scanf("%d",&T); while (T--) solve();
return 0;
}