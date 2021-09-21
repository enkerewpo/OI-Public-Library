#include<bits/stdc++.h>
using namespace std;

const int g = 10;
const int P = 1000000007;

int ksm(int b,int k){
	int ans=1;
	while (k) {
		if (k&1) ans=1ll*ans*b%P;
		b=1ll*b*b%P;
		k>>=1;
	}
	return ans;
}

int solve(){
	int t,v,R;
	scanf("%d%d%d",&t,&v,&R);
	if (4ll*g*t*t*t*v+4ll*v*v*t*t+1ll*g*g*t*t*t*t-4ll*R*R<=0) {
		return 0;
	}
	if (4ll*g*t*t*t*v+4ll*v*v*t*t+1ll*g*g*t*t*t*t-4ll*R*R>=8ll*g*t*t*t*v) {
		return 1;
	}
	return 1ll*(4ll*g*t*t*t*v+4ll*v*v*t*t+1ll*g*g*t*t*t*t-4ll*R*R)*ksm(8ll*g*t*t*t*v%P,P-2)%P;
}
int main()
{
	int t;
	scanf("%d",&t);
	while (t--) 
		printf("%d\n",solve());
}

