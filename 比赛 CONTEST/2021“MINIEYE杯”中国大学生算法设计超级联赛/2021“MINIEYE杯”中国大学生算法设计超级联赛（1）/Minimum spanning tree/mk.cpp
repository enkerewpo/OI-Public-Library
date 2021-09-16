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
	int t=100;
	printf("%d\n",t);
	rep(i,1,t){
		int n=ui(2,10000000);
		printf("%d\n",n);
	}
}
