#include <iostream>
#include <cstdio>
#include <cstdlib>
#include <algorithm>
#include <cmath>
using namespace std;
const int maxn=1e6+10;
int T,n,m,k,fa[maxn],now,ans;
struct da{int u,v,w;}q[maxn];
bool cmp(da aa,da bb){return aa.w<bb.w;}
int getf(int x)
{
	if (fa[x]==x) return x;
	fa[x]=getf(fa[x]);
return fa[x];
}
void solve()
{
	scanf("%d%d%d",&n,&m,&k); now=n; ans=0;
	for (int i=1;i<=n;i++) fa[i]=i;
	for (int i=1;i<=m;i++) scanf("%d%d%d",&q[i].u,&q[i].v,&q[i].w);
	sort(q+1,q+m+1,cmp);
	for (int i=1;i<=m;i++)
	{
		if (q[i].w!=q[i-1].w){if (now==k) {printf("%d\n",ans); return;}}
		if (getf(q[i].u)==getf(q[i].v)) continue;
		now--; fa[getf(q[i].u)]=getf(q[i].v); ans=q[i].w;
	}
	printf("%d\n",now==k?ans:-1);
}
int main()
{
	//freopen("1.in","r",stdin);
	//freopen("1.out","w",stdout);
	scanf("%d",&T);
	while (T--) solve();
return 0;
}