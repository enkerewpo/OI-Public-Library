#include<bits/stdc++.h>
#define rep(i,x,y) for(auto i=(x);i<=(y);++i)
#define dep(i,x,y) for(auto i=(x);i>=(y);--i)
#define fr first
#define sc second
using namespace std;
typedef long long ll;
typedef pair<int,int>pii;
const int inf=1e9;
const int N=1e6+10;
const int M=1e7+20;
const int mo=998244353;
bool v[M];
int tot,p[N];
ll a[N];
void sol(){int n;
	scanf("%d",&n);
	printf("%lld\n",ll(3+n)*(n-2)/2+a[upper_bound(p+1,p+tot+1,n)-p-1]);
}
int main(){int t;
	//freopen("in.txt","r",stdin);
	//freopen("ans.txt","w",stdout);
	rep(i,2,M-1){
		if(!v[i])p[++tot]=i;
		rep(j,1,tot){
			if(i*p[j]>=M)break;
			v[i*p[j]]=1;
			if(!(i%p[j]))break;
		}
	}
	rep(i,2,tot)a[i]=p[i]+a[i-1];
	scanf("%d",&t);
	rep(i,1,t)sol();	
}
