#include <bits/stdc++.h>
using namespace std;
using ll = long long; 
#define tcT template<class T
#define tcTU tcT, class U
#define FOR(i,a,b) for (int i = (a); i < (b); ++i)
#define F0R(i,a) FOR(i,0,a)
#define ROF(i,a,b) for (int i = (b)-1; i >= (a); --i)
#define R0F(i,a) ROF(i,0,a)
#define each(a,x) for (auto& a: x)
const int mod = 1000000007;
constexpr int pct(int x) { return __builtin_popcount(x); } // # of bits set
ll fdiv(ll a, ll b) { return a/b-((a^b)<0&&a%b); } // divide a by b rounded down
tcTU> T lstTrue(T lo, T hi, U f) { lo --; assert(lo <= hi); while (lo < hi) { T mid = lo+(hi-lo+1)/2; f(mid) ? lo = mid : hi = mid-1; } return lo; }

const int MX = (2<<22)+10;
ll a,b,c,d,e,f;
int N,miv[MX],xv2[MX],yv2[MX],resv[MX],li[MX*2],ri[MX*2];

inline int mul(int x,int y){return 1ll*x*y%mod;}
inline int add(int x,int y){return x+y>=mod?x+y-mod:x+y;}
inline int sub(int x,int y){return x-y<0?x-y+mod:x-y;}
inline int sq(int x){return 1ll*x*x%mod;}
int mpow(int a,int b){return b == 0 ? 1 : ( b&1 ? mul(a,sq(mpow(a,b/2))) : sq(mpow(a,b/2)));}

void solve(){
    cin>>a>>b>>c>>d>>e>>f;
    ll xbnd = lstTrue(0,4000000,[&](ll x){return (4*c*a-e*e)*x*x<=4*c*f;});
    ll ybnd = lstTrue(0,4000000,[&](ll x){return (4*c*a-e*e)*x*x<=4*a*f;});
    int cn = max(b+xbnd,d+ybnd)+10;
    N = 1;while(N<cn)N*=2;
    F0R(i,N){
        yv2[i] = miv[i];
        xv2[i] = 1ll*yv2[i]*yv2[i]%mod;
        resv[i] = 0;
    }
    F0R(ii,N){
        if(ii<b-xbnd || ii>b+xbnd){
            li[ii+N] = 1;ri[ii+N] = 0;
            continue;
        }
        ll i = ii-b,cv = e*e*i*i-4*c*(a*i*i-f),ce = sqrt(cv);
        while(ce*ce>cv)ce-=1; while((ce+1)*(ce+1)<=cv)ce+=1;
        ri[ii+N] = fdiv(-e*i+ce,c*2)+d;
        li[ii+N] = fdiv(-e*i-ce+c*2-1,c*2)+d;
    }
    int msk = N-2;
    R0F(i,N){
        li[i] = N-((N-max(li[i*2],li[i*2+1]))&msk);
        ri[i] = ((min(ri[i*2],ri[i*2+1])+1)&msk)-1;
        if(pct(i) == 1)msk-=msk&-msk;
    }
    auto conv = [&](int* xxa,int i){
        for(int s =0;s<N;s+=i*2){
            int* f1 = xxa+s,*f2 =xxa+s+i;
            for(int j=0;j<i;j++){ int c1 = f1[j],c2 = f2[j]; f1[j]=add(c1,c2); f2[j]=sub(c1,c2); }
        }
    };
    for(int i = 1;i<N;i*=2){
        int s;
        function<void(int,int)> calc= [&](int l,int r){
            for(int j=l;j<r;j+=i){
                int *a = xv2+s,*b = yv2+j,*res = resv+(s^j);
                for(int k=0;k<i;k++) res[k]=(1ll*a[k]*b[k]+res[k])%mod;
            }
        };
        for(s =0;s<N;s+=i){
            int id = (N+s)/i;
            if(li[id]>ri[id])continue;
            if(li[id/2]>ri[id/2]){
                calc(li[id],ri[id]+1);
            }else{
                calc(li[id],li[id/2]);
                calc(ri[id/2]+1,ri[id]+1);
            }
        }
        conv(xv2,i);conv(yv2,i);conv(resv,i);
    }
    for(int i = 1;i<N;i*=2) conv(resv,i);
    int ans = 0;
    F0R(i,N) ans=add(ans,(1ll*((1ll*resv[i]*i)%mod)*((1ll*i*i)%mod))%mod);
    ans=mul(ans,mpow(N,mod-2));
    cout<<ans<<"\n";
}

int main() {
    int T;cin>>T;
    miv[0] = miv[1]= 1;
    FOR(i,2,MX) miv[i] = mod-(long long)mod/i*miv[mod%i]%mod;
    while(T--){
        solve();
    }
    return 0;
}