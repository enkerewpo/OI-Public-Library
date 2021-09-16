#include<bits/stdc++.h>
using namespace std;
#define LL long long
#define LD long double
#define ull unsigned long long
const int N=(1<<20)+10;
const int INF=2e9;
const LL inf=1e18;
const LL P=998244353;
void init(){
	return;
}
LL qpow(LL x,LL y){
	LL re=1;
	while(y){
		if(y&1) re=re*x%P;
		x=x*x%P;y>>=1;
	}
	return re;
}

void get_min(int &x,int y){
	if(x>y) x=y;
}

void get_max(int &x,int y){
	if(x<y) x=y;
}

int n,m;
int a[N],b[N];
int A[N],B[N];
LL ans[N];
void MAIN(){
	scanf("%d",&n);
	for(int i=0;i<n;++i){
		scanf("%d",&a[i]);A[i]=a[i];
	}
	for(int i=0;i<n;++i){
		scanf("%d",&b[i]);B[i]=b[i];
	}
	m=1;
	while(m<n) m<<=1;
	for(int i=n;i<m;++i){
		A[i]=B[i]=-INF;
		a[i]=b[i]=INF;
	}
	for(int j=1;j<m;j<<=1)
		for(int i=m-1;i>=0;--i){
			if(!(i&j)) {
				get_max(A[i],A[i^j]);
				get_max(B[i],B[i^j]);
				get_min(a[i],a[i^j]);
				get_min(b[i],b[i^j]);
			}
		}
	ans[n]=-inf;
	for(int i=n-1;i>=0;--i){
		ans[i]=-inf;
		if(A[i]!=-INF&&B[i]!=-INF){
			ans[i]=max(ans[i],(LL)A[i]*B[i]);
		}
		if(A[i]!=-INF&&b[i]!=INF){
			ans[i]=max(ans[i],(LL)A[i]*b[i]);
		}
		if(a[i]!=INF&&B[i]!=-INF){
			ans[i]=max(ans[i],(LL)a[i]*B[i]);
		}
		if(a[i]!=INF&&b[i]!=INF){
			ans[i]=max(ans[i],(LL)a[i]*b[i]);
		}
		ans[i]=max(ans[i],ans[i+1]);
	}
	LL re=0;
	for(int i=0;i<n;++i){
		//if(ans[i]<0) puts("???");
		ans[i]=ans[i]%P;
		re+=ans[i];
//		cout<<ans[i]<<endl; 
	}
	re=re%P;
	re=(re%P+P)%P;
	printf("%lld\n",re);
	return;
}
int main(){
	freopen("2.in","r",stdin);
//	freopen("1.out","w",stdout);
	init();
	int ttt=1;scanf("%d",&ttt);
	while(ttt--) MAIN();
	return 0;
}
/*
1
4
9 1 4 1
5 4 1 1
*/
 
