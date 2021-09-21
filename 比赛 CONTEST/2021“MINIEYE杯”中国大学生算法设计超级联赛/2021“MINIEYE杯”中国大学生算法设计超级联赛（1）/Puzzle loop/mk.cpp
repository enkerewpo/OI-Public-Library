#include<bits/stdc++.h>
#define rep(i,x,y) for(auto i=(x);i<=(y);++i)
#define dep(i,x,y) for(auto i=(x);i>=(y);--i)
using namespace std;
typedef long long ll;
default_random_engine e;
int ui(int l,int r){
	uniform_int_distribution<int>u(l,r);
	return u(e);
}
ll ul(ll l,ll r){
	uniform_int_distribution<ll>u(l,r);
	return u(e);
}
double ud(double l,double r){
	uniform_real_distribution<double>u(l,r);
	return u(e);
}
const int N=2e6+10;
bool v[N];
int main(){
	e.seed(time(0));srand(time(0));
	freopen("in.txt","w",stdout);
	int t=100,n,m;
	printf("%d\n",t);
	rep(i,1,t){
		if(i<=95)n=ui(2,9),m=ui(2,9);
		else n=ui(16,17),m=ui(16,17);
		//n=ui(2,4),m=ui(2,4);
		printf("%d %d\n",n,m);
		rep(i,1,n-1){
			rep(j,1,m-1){
				int w=ui(0,2);
				if(w>1)printf(".");else printf("%d",w);
			}
			printf("\n");
		}
	}
}
