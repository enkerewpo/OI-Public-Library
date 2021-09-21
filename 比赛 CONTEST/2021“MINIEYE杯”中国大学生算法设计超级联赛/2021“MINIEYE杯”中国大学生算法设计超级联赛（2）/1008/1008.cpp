#include<bits/stdc++.h>
#define N 500
using namespace std;
typedef long long ll;
int n,m;
map<string,int>mp;
string s;
int f[109][109],dp[1009][15],mx[52][1009];
inline ll rd(){
	ll x=0;char c=getchar();bool f=0;
	while(!isdigit(c)){if(c=='-')f=1;c=getchar();}
	while(isdigit(c)){x=(x<<1)+(x<<3)+(c^48);c=getchar();}
	return f?-x:x;
}
struct node{
	int x,y;
};
vector<node>vec[N];
void solve(){
	n=rd();
	char s1[20];
	for(int i=1;i<=n;++i){
		cin>>s1;
		mp[s1]=i;
    }
    m=rd();
    int x,y;
    for(int i=1;i<=m;++i){
        cin>>s1;
		int id=mp[s1];
		x=rd();y=rd(); 
		vec[id].push_back(node{x,y});
    }
    int t=rd();int p=rd();
    memset(f,0x3f,sizeof(f));
    memset(dp,-0x3f,sizeof(dp));
    memset(mx,0,sizeof(mx));
    for(int i=1;i<=n;++i){
    	f[i][0]=0;
    	for(int j=0;j<vec[i].size();++j)
    	    for(int k=120;k>=vec[i][j].x;--k)
    	        f[i][k]=min(f[i][k],f[i][k-vec[i][j].x]+vec[i][j].y);
    	for(int k=120;k>=100;--k)f[i][k]=min(f[i][k],f[i][k+1]); 
    	for(int k=1;k<=100;++k)if(f[i][k]<=500)mx[i][f[i][k]]=max(mx[i][f[i][k]],k);
    }
    dp[0][0]=0;
    for(int i=1;i<=n;++i){
    	for(int j=t;j>=1;--j){
			for(int k=p;k>0;--k)dp[j][k]=dp[j][k-1];
			dp[j][0]=-1e9;
    	    for(int k=0;k<=p;++k)
			    for(int l=1;l<=f[i][100]&&l<=j;++l){
    	    	    if(mx[i][l]>=60)dp[j][k]=max(dp[j-l][k]+mx[i][l],dp[j][k]);
    	    	    else if(k)dp[j][k]=max(dp[j-l][k-1]+mx[i][l],dp[j][k]);
    	        }
    	}
    	dp[0][0]=-1e9;
    }
    int ans=-1;
    for(int i=1;i<=t;++i){
        for(int j=0;j<=p;++j){
		    ans=max(ans,dp[i][j]);
		} 
	}
    mp.clear();
    for(int i=1;i<=n;++i)vec[i].clear();
	
}
int main(){
	int T=rd();
	while(T--)solve(); 
	return 0;
}
