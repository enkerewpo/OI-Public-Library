#include<bits/stdc++.h>
using namespace std;
typedef long long ll;
const int N=2000000;
const int maxn=2e6+10;
const int K=30;
mt19937_64 gen(time(0));
int tot,prime[maxn],_,n,ans;
ll a[maxn];
bool p[maxn];
int calc(ll x,ll y){
    int cnt=0;
    for (int i=1;i<=n;i++) cnt+=(a[i]%x==y);
    return cnt;
}
int main(){
    //freopen("input.txt","r",stdin);
    //freopen("output.txt","w",stdout);
    for (int i=2;i<maxn;i++) if (!p[i]){
        prime[++tot]=i;
        for (int j=2;j*i<maxn;j++) p[i*j]=1;
    }
    scanf("%d",&_);
    while (_--){
        scanf("%d",&n);
        for (int i=1;i<=n;i++) scanf("%lld",&a[i]);
        ans=1;
        for (int i=1;i<=K;i++){
            int x,y;
            while (1){
                x=gen()%n+1;
                y=gen()%n+1;
                if (x!=y) break;
            }
            ll tmp=abs(a[x]-a[y]);
            for (int j=1;1ll*prime[j]*prime[j]<=tmp;j++){
                if (tmp%prime[j]==0){
                    ans=max(ans,calc(prime[j],a[x]%prime[j]));
                    while (tmp%prime[j]==0) tmp/=prime[j];
                }
            }
            if (tmp>1) ans=max(ans,calc(tmp,a[x]%tmp));
        }
        printf("%d\n",ans);
    }
    return 0;
}
