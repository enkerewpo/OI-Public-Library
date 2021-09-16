#include<bits/stdc++.h>
using namespace std;

const int P = 1000000007;
int Num[2000005][2];
int Sum[2000005];

int work(int len,int type) {
	if (len<=0) return 0;
	if (Num[len][type]) return Num[len][type];
	if (type==0) {
		return Num[len][type]=work(len-2,1)+1;
	}else{
		int mid=(len+1)/2;
		return Num[len][type]=work(mid-1-1,1)+work(len-mid-1,1)+1;
	}
}

int ksm(int b,int k){
	int ans=1;
	while (k){
		if (k&1) ans=1ll*ans*b%P;
		b=1ll*b*b%P;
		k>>=1;
	}
	return ans;
}
void init()
{
	for (int i=1;i<=1000000;i++) work(i,0);
	for (int i=1;i<=1000000;i++) {
		Sum[i]=(Sum[i-1]+Num[i][0])%P;
	}
}
void solve()
{
	int n;
	scanf("%d",&n);
	printf("%lld\n",1ll*(2*Sum[n-2]+n)*ksm(n,P-2)%P);
}
int main()
{
	init();
	int t;
	scanf("%d",&t);
	while (t--) solve();
}

