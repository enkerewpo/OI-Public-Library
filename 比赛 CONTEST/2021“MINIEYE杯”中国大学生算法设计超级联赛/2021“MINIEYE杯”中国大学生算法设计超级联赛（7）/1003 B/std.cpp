#include<bits/stdc++.h>
const int M=1e9+7;
typedef long long ll;
typedef long double ld;
const ld eps=1e-4;

namespace GTI
{
	char gc(void)
	{
		const int S=1<<17;
		static char buf[S],*s=buf,*t=buf;
		if (s==t) t=buf+fread(s=buf,1,S,stdin);
		if (s==t) return EOF;
		return *s++;
	}
	int gti(void)
	{
		int a=0,b=1,c=gc();
		for (;!isdigit(c);c=gc()) b^=(c=='-');
		for (;isdigit(c);c=gc()) a=a*10+c-'0';
		return b?a:-a;
	}
};
using GTI::gti;

int main(void)
{
	for (int t=gti();t;t--)
	{
		int k=gti(),x0=gti(),y0=gti(),x1=gti(),y1=gti(),x2=gti(),y2=gti();
		ll d=x2-x1,h=y0-y1,S=(2ll*k-5)*d*h,p=60000ll*d*h;
		for (int i=1;i<=k&&p;i++) p>>=1;
		S+=p/10000,p%=10000,k=p%10,p/=10;
		printf("%lld.%03lld\n",S,p+(k>=5));
	}
	return 0;
}

