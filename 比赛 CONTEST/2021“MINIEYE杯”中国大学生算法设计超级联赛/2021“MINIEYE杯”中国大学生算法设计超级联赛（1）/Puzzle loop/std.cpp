#include<bits/stdc++.h>
#define rep(i,x,y) for(auto i=(x);i<=(y);++i)
#define dep(i,x,y) for(auto i=(x);i>=(y);--i)
#define fr first
#define sc second
using namespace std;
typedef long long ll;
typedef pair<int,int>pii;
const int inf=1e9;
const int N=19;
const int mo=998244353;
char s[N];
int idh[N][N],ids[N][N];
bitset<1000>a[1000];
void sol(){
	int h,w;
	scanf("%d%d",&h,&w);
	int n=0,m=0;
	rep(i,1,h)rep(j,1,w-1)idh[i][j]=++m;
	rep(i,1,h-1)rep(j,1,w)ids[i][j]=++m;
	++m;
	rep(i,1,h)rep(j,1,w){
		a[++n].reset();
		if(i>1)a[n][ids[i-1][j]]=1;
		if(j>1)a[n][idh[i][j-1]]=1;
		if(i<h)a[n][ids[i][j]]=1;
		if(j<w)a[n][idh[i][j]]=1;
	}
	rep(i,1,h-1){
		scanf("%s",s+1);
		rep(j,1,w-1)if(s[j]!='.'){
			a[++n].reset();
			a[n][idh[i][j]]=a[n][idh[i+1][j]]=a[n][ids[i][j]]=a[n][ids[i][j+1]]=1;
			a[n][m]=s[j]-'0';
		}
	}
	int nw=1;
	rep(j,1,m-1){
		int x=0;
		rep(i,nw,n)if(a[i][j]){
			x=i;break;
		}
		if(!x)continue;
		if(x!=nw)swap(a[nw],a[x]);
		rep(i,1,n)if(i!=nw&&a[i][j])a[i]^=a[nw];
		++nw;
	}
	rep(i,nw,n)if(a[i].any()){
		printf("0\n");return;
	}
	int ans=1;
	rep(i,nw,m-1)ans=ans*2%mo;
	printf("%d\n",ans);
}
int main(){int t;
	//freopen("in.txt","r",stdin);
	//freopen("ans.txt","w",stdout);
	scanf("%d",&t);
	rep(i,1,t)sol();	
}
