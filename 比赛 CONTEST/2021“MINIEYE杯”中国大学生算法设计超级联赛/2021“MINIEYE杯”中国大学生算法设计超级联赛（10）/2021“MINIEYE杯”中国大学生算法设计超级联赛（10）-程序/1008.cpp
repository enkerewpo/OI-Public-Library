#include <bits/stdc++.h>
#define fo(i,a,b) for(int i=a;i<=b;++i)
#define fod(i,a,b) for(int i=a;i>=b;--i)
#define N 200005
using namespace std;
char st[N];
int n,m1,m2,q,fs[N],nt[N],dt[N],fi[N],dx[N],nx[N];
int ft[N],f2[N],sz[N],s2[N],dfn[N],df2[N],dfw[N],cnt,cnt2;
void link(int x,int y)
{
	nt[++m1]=fs[x];
	dt[fs[x]=m1]=y;
}
void dfs(int k,int fa)
{
	dfw[dfn[k]=++cnt]=k;
	sz[k]=1;
	for(int i=fs[k];i;i=nt[i])
	{
		int p=dt[i];
		if(p!=fa) dfs(p,k),sz[k]+=sz[p];
	}
}
void lk(int x,int y)
{
	nx[++m2]=fi[x];
	dx[fi[x]=m2]=y;
}
void dfs2(int k,int fa)
{
	df2[k]=++cnt2;
	s2[k]=1;
	for(int i=fi[k];i;i=nx[i])
	{
		int p=dx[i];
		if(p!=fa) dfs2(p,k),s2[k]+=s2[p];
	}
}
int rt[N],t[40*N][2],sm[40*N],n1;
#define nwp(k) (k=(!k)?++n1:k)
void ins(int k,int w,int l,int r,int x)
{
	if(l==r) {sm[k]=sm[w]+1;return;}
	int mid=(l+r)>>1;
	if(x<=mid) nwp(t[k][0]),t[k][1]=t[w][1],ins(t[k][0],t[w][0],l,mid,x);
	else nwp(t[k][1]),t[k][0]=t[w][0],ins(t[k][1],t[w][1],mid+1,r,x);
	sm[k]=sm[t[k][0]]+sm[t[k][1]];
}
int tot=0;
int query(int k,int w,int l,int r,int x,int y)
{
	tot++;
	if(!k||sm[k]-sm[w]==0||x>r||y<l) return 0;
	if(x<=l&&r<=y) return sm[k]-sm[w];
	int mid=(l+r)>>1,tmp=0;
	return query(t[k][0],t[w][0],l,mid,x,y)+query(t[k][1],t[w][1],mid+1,r,x,y);
}

void solve() {
	cin>>n>>q;
	scanf("%s",st+1);
	int j=0;
	fo(i,2,n)
	{
		while(j&&st[j+1]!=st[i]) j=ft[j];
		if(st[j+1]==st[i]) j++;
		ft[i]=j;
	}
	j=n+1;
	f2[n]=n+1;
	fod(i,n-1,1)
	{
		while(j<=n&&st[j-1]!=st[i]) j=f2[j];
		if(st[j-1]==st[i]) j--;
		f2[i]=j;
	}
	fo(i,1,n) link(ft[i],i),lk(f2[i],i);
	dfs(0,0),dfs2(n+1,0);
	fo(i,1,n+1)
	{
		rt[i]=++n1;
		ins(rt[i],rt[i-1],1,n+1,df2[dfw[i]+1]);
	}
	fo(i,1,q)
	{
		int x,y;
		scanf("%d%d",&x,&y);
		y=n-y+1;
		printf("%d\n",query(rt[dfn[x]+sz[x]-1],rt[dfn[x]-1],1,n+1,df2[y],df2[y]+s2[y]-1));
	}
	m1=m2=0;fo(i,0,n+1) fs[i]=fi[i]=0;cnt=cnt2=0;
	fo(i,1,n+1) rt[i]=0;
	fo(i,1,n1) sm[i]=t[i][0]=t[i][1]=0;n1=0;
}

int main()
{
	int T;cin>>T;
	for(;T;T--) solve();
	return 0;
}
