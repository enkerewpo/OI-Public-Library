#include<bits/stdc++.h>
using namespace std;
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
const long long inf = 1e18+2,P=1000000007; 
struct Point{
	int x,y;
	Point (int a1=0,int a2=0) :x(a1),y(a2) {}
	friend Point operator + (Point p1,Point p2){
		return Point(p1.x+p2.x,p1.y+p2.y);
	}
	friend Point operator - (Point p1,Point p2){
		return Point(p1.x-p2.x,p1.y-p2.y);
	}
	long long mod2(){
		return 1ll*x*x+1ll*y*y;
	}
	long double mod(){
		return sqrtl(1ll*x*x+1ll*y*y);
	}
}a[200005],b[200005];

long long mulpoint(Point p1,Point p2){
	return (1ll*p1.x*p2.x+1ll*p1.y*p2.y);
}
long long mulcross(Point p1,Point p2){
	return (1ll*p1.x*p2.y-1ll*p2.x*p1.y);
}

long double disptos(Point p,Point s1,Point s2){
	Point v=p-s1,u=s2-s1;
	if (mulpoint(u,v)<0 || mulpoint(u,v)>u.mod2()) return min((p-s1).mod(),(p-s2).mod());
	return fabsl(mulcross(u,v)/u.mod());
}

long long ksm(int a,int k){
	int ans=1;
	while (k){
		if (k&1) {
			ans=1ll*ans*a%P;
		}
		a=1ll*a*a%P;
		k>>=1;
	}
	return ans;
}

int disptos_INT(Point p,Point s1,Point s2){
	Point v=p-s1,u=s2-s1;
	if (mulpoint(u,v)<0 || mulpoint(u,v)>u.mod2()) return min((p-s1).mod2(),(p-s2).mod2())%P;
	return ((mulcross(v,u)%P)*(mulcross(v,u)%P))%P*ksm(u.mod2()%P,P-2)%P;
}

int n,m;

int nxt(int x){return x==n?1:x+1;}
void solve()
{
    n=gti();
	for (int i=1;i<=n;i++){
		a[i]={gti(),gti()};
	}
	
    m=gti();
	for (int i=1;i<=m;i++){
		b[i]={gti(),gti()};
	}
	
	int j=1;
	long double Min=inf;
	for (int k=1;k<=n;k++) {
		if (disptos(b[1],a[k],a[nxt(k)])<Min) {
			Min=disptos(b[1],a[k],a[nxt(k)]);
			j=k;
		}
	}
	long double ans=0;
	int True_ans=-1;
	for (int i=1;i<=m;i++) {
		while (disptos(b[i],a[j],a[nxt(j)])>=disptos(b[i],a[nxt(j)],a[nxt(nxt(j))])-1e-12) j=nxt(j);
		if (disptos(b[i],a[j],a[nxt(j)])>ans) {
			ans=disptos(b[i],a[j],a[nxt(j)]);
			True_ans=disptos_INT(b[i],a[j],a[nxt(j)]);
		}
	}
	printf("%d\n",True_ans);
}

int main(){
	int t=gti();
	while (t--){
		solve();
	}
}

