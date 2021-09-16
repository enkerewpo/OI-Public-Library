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
char s[N][N];
int n,m,ans,a[2][N][N];
void ck(){
	n=n;
	rep(i,1,n)rep(j,1,m)
		if(a[0][i][j-1]^a[0][i][j]^a[1][i-1][j]^a[1][i][j])return;
	rep(i,1,n-1)rep(j,1,m-1)if(s[i][j]!='.')
		if((a[0][i][j]^a[0][i+1][j]^a[1][i][j]^a[1][i][j+1])!=s[i][j]-'0')return;
	++ans;
}
void dfs(int op,int x,int y){
	if(!op){
		if(y>=m)++x,y=1;
		if(x>n)x=y=op=1;
	}else{
		if(y>m)++x,y=1;
		if(x>=n){
			ck();return;
		}
	}
	a[op][x][y]=0;dfs(op,x,y+1);
	a[op][x][y]=1;dfs(op,x,y+1);
}
void sol(){
	scanf("%d%d",&n,&m);
	rep(i,1,n-1)scanf("%s",s[i]+1);
	rep(i,0,n+1)rep(j,0,m+1)a[0][i][j]=a[1][i][j]=0;
	ans=0;dfs(0,1,1);
	printf("%d\n",ans);
}
int main(){int t;
	freopen("in.txt","r",stdin);
	freopen("out.txt","w",stdout);
	scanf("%d",&t);
	rep(i,1,t)sol();	
}
