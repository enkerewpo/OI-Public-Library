#include<bits/stdc++.h>
using namespace std;
typedef long long ll;
const int maxn=1e5+10;
ll a[maxn],b[maxn],h;
int _,n,s,t;
int main(){
    //freopen("input.txt","r",stdin);
    //freopen("output.txt","w",stdout);
    scanf("%d",&_);
    while (_--){
        scanf("%d%d%d%lld",&n,&s,&t,&h); n--;
        assert(s+t<=n);
        for (int i=1;i<=n;i++) scanf("%lld",&a[i]);
        for (int i=1;i<=n;i++) scanf("%lld",&b[i]);
        sort(a+1,a+n+1);
        sort(b+1,b+n+1);
        a[0]=b[0]=1; a[n+1]=b[n+1]=h;
        ll sa=0,sb=1;
        for (int i=t+1;i<=n-s;i++) sa+=a[i],sb+=b[i];
        ll aL=sa+a[t],aR=sa+a[n-s+1];
        ll bL=sb+b[t],bR=sb+b[n-s+1];
        if (aR<bL) puts("IMPOSSIBLE");
        else if (aL>=bR){
            printf("%lld\n",1-h);
        } else {
            ll r=0;
            if (aL>=bL) r=max(r,a[t]-1);
            if (bR<=aR) r=max(r,h-b[n-s+1]);
            printf("%lld\n",sb-sa-r);
        }
    }
    return 0;
}
