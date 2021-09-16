#include <bits/stdc++.h>
#define DB double
#define LL long long

#define MST(a,b) memset((a),(b),sizeof(a))

#ifdef _DEBUG_
#define MRK() cout<<"Mark"<<endl;
#define WRT(x) cout<<#x<<" = "<<(x)<<endl;
#else
#define MRK() ;
#define WRT(x) ;
#endif

#define MAXN 1010000
#define MAXM 2010000
#define MOD 998244353  //1000000007
#define INF 0x3f3f3f3f
#define LLINF 0x3f3f3f3f3f3f3f3f
#define EPS 1e-5

#define _ 0
using namespace std;

int n;
vector<int> g[MAXN]; 
LL a[MAXN],b[MAXN];
int col[MAXN]; 
vector<vector<LL> > op;
void init()
{

}

void dfs(int pos,int f)
{
	col[pos]=col[f]^1;
	for (auto p:g[pos])
		if (p!=f)
			dfs(p,pos);
}

void operation(int x,int y,LL w)
{
	op.push_back({x,y,w});
	a[x]^=w;
	a[y]^=w;
	b[x]+=w;
	if (col[x]!=col[y])
		b[y]+=w;
	else
		b[y]-=w;
}

bool cmp(int x,int y)
{
	return b[x]<b[y];
}

bool check()
{
	LL asum[2]={0,0};
	LL bsum[2]={0,0};
	dfs(1,1);
	for (int i=1;i<=n;i++)
	{
		if ((a[i]&1)^(b[i]&1))
			return false;
		asum[col[i]]^=a[i];
		bsum[col[i]]+=b[i];
	}
	if (asum[0]^asum[1])
		return false;
	if (asum[0]>-bsum[0])
		return false; 
	
	vector<int> v[2];
	for (int i=1;i<=n;i++)
		v[col[i]].push_back(i);
	if (v[0].size() && v[1].size()) 
	{
		operation(v[0][0],v[1][0],asum[0]);
		operation(v[0][0],v[1][0],(-bsum[0]-asum[0])/2);
		operation(v[0][0],v[1][0],(-bsum[0]-asum[0])/2);
	}
	for (int c=0;c<2;c++)
	{
		if (v[c].size()<2)
			continue;
		for (int i=0;i+1<v[c].size();i++)
		{
			LL tmp=a[v[c][i]];
			operation(v[c][i],v[c][i+1],tmp);
		}
		sort(v[c].begin(),v[c].end(),cmp);
		int l=0,r=v[c].size()-1;
		while (l<r)
		{
			LL tmp=min(-b[v[c][l]],b[v[c][r]]);
			assert(tmp%2==0);
			operation(v[c][l],v[c][r],tmp/2);
			operation(v[c][l],v[c][r],tmp/2);
			if (l<r && b[v[c][l]]==0) l++;
			if (l<r && b[v[c][r]]==0) r--;
		}
	}
	
	for (int i=1;i<=n;i++)
	{
		assert(a[i]==0);
		assert(b[i]==0);
	}
	
	return true;
	
}

void work()
{
	LL x,y,w;
	cin>>n;
	for (int i=1;i<=n;i++)
	{
		g[i].clear();
		cin>>a[i];
		b[i]=0;
	}
	for (int i=1;i<n;i++)
	{
		cin>>x>>y>>w;
		b[x]+=w;
		b[y]+=w;
		g[x].push_back(y);
		g[y].push_back(x);
	}
	op.clear();
	bool ans=check();
	if (ans==1)
		cout<<"YES"<<endl;
	else
	{
		cout<<"NO"<<endl;
		return ;
	}
	cout<<op.size()<<endl;
	for (auto p:op)
		cout<<p[0]<<' '<<p[1]<<' '<<p[2]<<endl;
}

int main()
{
	init();
	int casenum=1;
	scanf("%d",&casenum);
	for (int testcase=1;testcase<=casenum;testcase++)
	{
		work();
	}
	return ~~(0^_^0);
}





