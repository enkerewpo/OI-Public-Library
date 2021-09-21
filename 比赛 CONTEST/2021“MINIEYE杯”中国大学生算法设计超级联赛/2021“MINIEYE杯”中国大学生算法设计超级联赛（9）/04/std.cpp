#include<bits/stdc++.h>
using namespace std;
typedef long long ll;
const int maxn=1e6+10;
int M,n,ans,f[maxn],nf[maxn],inv[maxn],sum[maxn],P;
void add(int &x,int y){x+=y; if (x>=M)x-=M;}
void sub(int &x,int y){x-=y; if (x<0) x+=M;}
int C(int x,int y){
    if (y<0||y>x) return 0;
    return 1ll*f[x]*nf[y]%M*nf[x-y]%M;
}
int qsum(int l,int r){
    int ret=sum[r];
    if (l>0) sub(ret,sum[l-1]);
    return ret;
}
void init(){
    inv[1]=1; for (int i=2;i<maxn;i++) inv[i]=M-1ll*(M/i)*inv[M%i]%M;
    f[0]=nf[0]=1; for (int i=1;i<maxn;i++) f[i]=1ll*f[i-1]*i%M,nf[i]=1ll*nf[i-1]*inv[i]%M;
    sum[0]=C(n,0); for (int i=1;i<maxn;i++) sum[i]=(sum[i-1]+C(n,i))%M;
}
int main(){
    //freopen("input.txt","r",stdin);
    //freopen("output.txt","w",stdout);
    int _; cin >> _;
    while (_--){
        cin >> n >> M;
        init();
        ans=n; P=1; for (int i=1;i<=n;i++) P=1ll*inv[2]*P%M;
        for (int i=1;i<n;i++){
            int l=(n-i+1)/2,r=(n+i)/2;
            int res=qsum(l,r);
            for (int j=1;j*(i+1)<=r;j++){
                if (j&1) sub(res,2ll*qsum(l-j*(i+1),r-j*(i+1))%M);
                else add(res,2ll*qsum(l-j*(i+1),r-j*(i+1))%M);
            }
            res=1ll*res*P%M;
            sub(ans,1ll*res*res%M);
        }
        cout << ans << endl;
    }
}
