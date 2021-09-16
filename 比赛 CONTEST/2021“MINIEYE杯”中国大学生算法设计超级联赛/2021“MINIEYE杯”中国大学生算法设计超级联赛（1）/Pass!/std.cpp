#include<bits/stdc++.h>
using namespace std;
#define N 10000010
#define LL long long
#define MOD 998244353
LL T,n,x,base,B=sqrt(MOD);
unordered_map<LL,LL>mp;
LL qow(LL x,LL y){return y?(y&1?x*qow(x,y-1)%MOD:qow(x*x%MOD,y/2)):1;}
int main()
{
	scanf("%lld",&T);
	while(T--){
		scanf("%lld%lld",&n,&x);
		x=x*n%MOD*qow(n-1,MOD-2)%MOD;
		mp.clear();
		mp[1]=0;
		base=(n-1)*(n-1)%MOD;
		LL f1=(x+MOD-1)*(n-1)%MOD;
		LL f2=(x+1)%MOD;
		if(f1==1){
			printf("0\n");
			continue;
		}
		if(f2==1){
			printf("1\n");
			continue;
		}
		LL p=1,flg=0;
		for(LL i=1;i<=B;i++){
			p=p*base%MOD;
			mp[p]=i;
			if(f1==p){
				printf("%lld\n",2ll*i);
				flg=1;
				break;
			}
			if(f2==p){
				printf("%lld\n",2ll*i+1);
				flg=1;
				break;
			}
		}
		if(flg)continue;
		p=qow(p,MOD-2);
		for(LL k=1,kp=p;k*B<MOD;k++,kp=kp*p%MOD){
			if(mp.count(f1*kp%MOD)){
				printf("%lld\n",2ll*(k*B+mp[f1*kp%MOD]));
				flg=1;
				break;
			}
			if(mp.count(f2*kp%MOD)){
				printf("%lld\n",2ll*(k*B+mp[f2*kp%MOD])+1);
				flg=1;
				break;
			}
		}
		if(flg)continue;
		printf("-1\n");
	}
}
