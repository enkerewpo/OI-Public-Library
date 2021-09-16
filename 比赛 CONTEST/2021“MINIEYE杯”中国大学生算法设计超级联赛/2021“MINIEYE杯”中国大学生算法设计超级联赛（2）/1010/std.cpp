#include<bits/stdc++.h>
using namespace std;
#define LL long long
#define LD long double
#define ull unsigned long long
const LL N=5e5+10;
const LL INF=1e18;
LL a,P,b;
int cnt=0;
void init(){
	return;
}

void add(LL &x,LL y){
	x+=y;if(x>=P)x-=P;
}

LL mul(LL x,LL y){
	LL re=0;
	while(y){
		if(y&1) add(re,x);
		add(x,x);y>>=1;
	} 
	return re;
}

inline long long Mul(long long x,long long y){
    long long tmp=(x*y-(long long)((long double)x/P*y+1.0e-8)*P);
    return (tmp+P)%P;
}

LL qpow(LL x,LL y){
	LL re=1,re2;
	while(y){
		if(y&1) {
			re=Mul(re,x);
		}
		x=Mul(x,x);
		y>>=1;
	}
	return re;
}

void MAIN(){
	scanf("%lld%lld",&a,&P);
	b=qpow(a,(P-1)/2);
	if(b==1) {
		puts("0");
	}
	else if(b==P-1) {
		puts("1");
	}
	else{
	//	cout<<a<<" "<<P<<" "<<b<<endl;
		++cnt;
	}
	return;
}
int main(){
	freopen("1.in","r",stdin);
	freopen("1.out","w",stdout);
	init();
	int ttt=1;scanf("%d",&ttt);
	while(ttt--) MAIN();
	//cout<<cnt<<endl;
	return 0;
}
/*

*/
 
