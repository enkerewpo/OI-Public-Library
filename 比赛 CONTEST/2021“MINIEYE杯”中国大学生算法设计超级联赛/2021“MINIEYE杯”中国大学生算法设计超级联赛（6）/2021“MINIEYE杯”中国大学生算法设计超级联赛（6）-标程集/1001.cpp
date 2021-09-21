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

#define MAXN 20100000
#define MAXM 2010000
#define MOD 998244353  //1000000007
#define INF 0x3f3f3f3f
#define LLINF 0x3f3f3f3f3f3f3f3f
#define EPS 1e-5

#define _ 0
using namespace std;

int notprime[MAXN]; 
vector<int> rec1;
vector<int> rec2;
void init()
{
	notprime[0]=notprime[1]=1;
	for (int i=2;i<MAXN;i++)
	{
		if (notprime[i])
			continue;
		if (i&1)
			rec2.push_back(i/2+1);
		rec1.push_back(i);
		for (int j=2*i;j<MAXN;j+=i)
			notprime[j]=1;
	}
}
int x;
void work()
{
	scanf("%d",&x);
	if (x>=0 && !notprime[x])
	{
		cout<<1<<endl;
		return;
	}
	if (x>=1 && (!notprime[2*x-1] || !notprime[2*x+1])) 
	{
		cout<<2<<endl;
		return;
	}
	int ans=INF;
	int t;
	if (x>=0)
	{
		t=*lower_bound(rec1.begin(),rec1.end(),x);
		ans=min(ans,2*t);
		t=*lower_bound(rec2.begin(),rec2.end(),x);
		ans=min(ans,2*t-1);
	}
	else
	{
		t=*lower_bound(rec1.begin(),rec1.end(),-x+1);
		ans=min(ans,2*t);
		t=*lower_bound(rec2.begin(),rec2.end(),-x+2);
		ans=min(ans,2*t-1);
	}
	cout<<ans<<endl;
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





