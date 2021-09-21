#include<bits/stdc++.h>
using namespace std;
#define LL long long
LL T,n;
int main()
{
	scanf("%lld",&T);
	while(T--){
		scanf("%lld",&n);
		if((n&(-n))==n){
			printf("%lld\n",max(0ll,n/2-1));
			continue;
		}
		while((n&(-n))!=n)n-=(n&(-n));
		printf("%lld\n",n-1);
	}
}
