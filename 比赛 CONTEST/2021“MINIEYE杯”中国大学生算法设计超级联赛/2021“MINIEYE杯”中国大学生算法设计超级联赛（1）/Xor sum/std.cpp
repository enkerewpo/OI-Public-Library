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
const int M=3e6+10;
const int mo=998244353;
int p[M][2],mx[M],a[N];
void sol(){
	int n,k;
	scanf("%d%d",&n,&k);
	rep(i,1,n){
		scanf("%d",&a[i]);
		a[i]^=a[i-1];
	}
	int anl=-1,anr=n,tot=1;
	mx[1]=-1;
	p[1][0]=p[1][1]=0;
	rep(i,0,n){
		int x=1,res=-1;
		dep(j,29,0){
			int w=(a[i]>>j)&1;
			if(!((k>>j)&1)){
				if(p[x][w^1])res=max(res,mx[p[x][w^1]]);
				x=p[x][w];
			}else x=p[x][w^1];
			if(!x)break;
		}
		if(x)res=max(res,mx[x]);
		if(res>=0&&i-res<anr-anl)anl=res,anr=i;
		x=1;
		dep(j,29,0){
			int w=(a[i]>>j)&1;
			if(!p[x][w]){
				p[x][w]=++tot;mx[tot]=-1;
				p[tot][0]=p[tot][1]=0;
			}
			x=p[x][w];
			mx[x]=max(mx[x],i);
		}
	}
	if(anl>=0)printf("%d %d\n",anl+1,anr);
	else printf("-1\n");
}
int main(){int t;
	//freopen("in.txt","r",stdin);
	//freopen("ans.txt","w",stdout);
	scanf("%d",&t);
	rep(i,1,t)sol();
}
