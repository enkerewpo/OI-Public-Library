#include<bits/stdc++.h>
#define rep(i,x,y) for(auto i=(x);i<=(y);++i)
#define dep(i,x,y) for(auto i=(x);i>=(y);--i)
#define fr first
#define sc second
using namespace std;
typedef long long ll;
typedef pair<int,int>pii;
const int inf=1e9;
const int N=1e5+10;
const int mo=998244353;
int a[N];
void sol(){int n,k;
	scanf("%d%d",&n,&k);
	int anl=-1,anr=n;
	rep(i,1,n)scanf("%d",&a[i]);
	rep(i,1,n){int x=0;
		rep(j,i,n){
			x^=a[j];
			if(j-i>=anr-anl)break;
			if(x>=k)anl=i,anr=j;
		}
	}
	if(anl>=0)printf("%d %d\n",anl,anr);
	else printf("-1\n");
}
int main(){int t;
	freopen("in.txt","r",stdin);
	freopen("out.txt","w",stdout);
	scanf("%d",&t);
	rep(i,1,t)sol();	
}
