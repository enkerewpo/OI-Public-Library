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



void init()
{

}
LL Cp,Cm,H0,A1,D1,N;

LL damageM(LL n,LL t,LL x)
{
	if (x<0 || x>min(t,n))
		return 0;
	return Cm*(n-x)*x+Cp*(t-x);
}
 
//survive for t turns, need Cp*max(1,A1-D0)<=damage whcih means max(1,A1-D0)<=damage/Cp 
LL check(LL damage,LL t)
{
	LL diff=damage/Cp;
	if (diff<1)
		return 0; 
	
	LL D0=max(0ll,A1-diff);
	LL tmp=0;
	LL n=N-D0;
	if (n<0)
		return 0;
	tmp=max(tmp,Cp*max(1ll,n-D1)*t);
	tmp=max(tmp,damageM(n,t,0));
	tmp=max(tmp,damageM(n,t,min(t,n)));
	tmp=max(tmp,damageM(n,t,(Cm*n-Cp)/(2*Cm)));
	tmp=max(tmp,damageM(n,t,(Cm*n-Cp-1)/(2*Cm)+1));
	return tmp;
}

void work()
{
	scanf("%lld%lld%lld%lld%lld%lld",&Cp,&Cm,&H0,&A1,&D1,&N);
	LL ans=0;
	for (int L=1,R=-1;L<=(H0-1);L=R+1)
	{
    	int val=(H0-1)/L;
    	R=(H0-1)/val;
    	ans=max(ans,check(R,val+1));
	}
    ans=max(ans,check(LLINF,1));
    printf("%lld\n",ans);
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





