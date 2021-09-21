#include<bits/stdc++.h>
#define MAXN 100005
#define INF 1000000000
#define MOD 1000000007
#define F first
#define S second
using namespace std;
typedef long long ll;
typedef pair<int,int> P;
int n,m;
ll k;
vector<vector<int> > v;
int main()
{
    //freopen("input.txt","r",stdin);
    //freopen("output.txt","w",stdout);
    int _; cin >> _;
    int sumnm=0;
    while (_--){
        scanf("%d%d%lld",&n,&m,&k);
        sumnm+=n*m;
        v.resize(n);
        for(int i=0;i<n;i++)
        {
            v[i].resize(m);
            for(int j=0;j<m;j++) scanf("%d",&v[i][j]);
        }
        if(k==1)
        {
            int maxi=0;
            for(int i=0;i<m;i++) maxi=max(maxi,v[0][i]);
            printf("%d\n",maxi);
        }
        else if(k%2==0)
        {
            int maxi=0;
            for(int i=0;i<m;i++)
            {
                int mini=INF;
                for(int j=0;j<n;j++) mini=min(mini,v[j][i]);
                maxi=max(maxi,mini);
            }
            printf("%d\n",max(v[0][0],maxi));
        }
        else
        {
            int mini=INF;
            for(int i=0;i<n;i++)
            {
                int maxi=0;
                for(int j=0;j<m;j++) maxi=max(maxi,v[i][j]);
                mini=min(mini,maxi);
            }
            printf("%d\n",max(v[0][0],mini));
        }
    }
    //cout<<sumnm<<endl;
    assert(sumnm<=1000000);
    return 0;
}
