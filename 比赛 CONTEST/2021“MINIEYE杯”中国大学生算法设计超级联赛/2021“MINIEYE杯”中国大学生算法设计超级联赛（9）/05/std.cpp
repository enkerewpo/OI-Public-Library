#include<bits/stdc++.h>
#define pb push_back
using namespace std;
int dp[6800000][5],n,base[5],sz[5],res[5];
vector<int> d[4];
int main(){
    //freopen("input.txt","r",stdin);
    //freopen("output.txt","w",stdout);
    int _; cin >> _;
    while (_--){
        cin >> n;
        for (int i=0;i<4;i++) d[i].clear();
        while (n--){
            int x,y; cin >> x >> y;
            d[y-1].pb(x);
        }
        for (int i=0;i<4;i++) sort(d[i].begin(),d[i].end()),sz[i]=1+d[i].size();
        memset(dp,-1,sizeof(dp));
        for (int i=0;i<=4;i++) dp[0][i]=0;
        base[0]=1; for (int i=1;i<=4;i++) base[i]=base[i-1]*sz[i-1];
        for (int x=1;x<base[4];x++){
            for (int i=0;i<4;i++) res[i]=(x/base[i])%sz[i];
            dp[x][0]=0; for (int i=0;i<4;i++) if (res[i]) dp[x][0]=max(dp[x][0],d[i][res[i]-1]+dp[x-base[i]][i+1]);
            for (int j=1;j<=4;j++){
                dp[x][j]=2e9;
                for (int i=0;i<4;i++) if (res[i]) dp[x][j]=min(dp[x][j],dp[x-base[i]][j-1]);
            }
        }
        int ans=0;
        for (int j=0;j<=4;j++) ans=max(ans,dp[base[4]-1][j]);
        cout << ans << endl;
    }
    return 0;
}
