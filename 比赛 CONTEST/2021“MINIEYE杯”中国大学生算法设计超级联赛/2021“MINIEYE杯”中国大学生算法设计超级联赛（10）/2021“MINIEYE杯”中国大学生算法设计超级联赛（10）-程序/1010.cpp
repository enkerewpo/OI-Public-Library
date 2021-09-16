#include<bits/stdc++.h>
using namespace std;
typedef long long ll;
typedef long double ld;
typedef unsigned long long ull;
ll a,b,c,n,m;
void write(ll x){
    if (x==-1||x>1e18)
        cout<<"none"<<endl;
    else cout<<x<<endl;
}
ld f(ll x){
    ld fz=(ld)a*x*x+(ld)b*x+(ld)c;
    if (abs(fz)>1e16)return fz;
    else {
        ll f=(ll)a*x*x+b*x+c;
        return f;
    }    
}
void info(){
    cerr<<a<<' '<<b<<' '<<c<<endl;
    ld x1=(-b-sqrt((ld)b*b-(ld)4*a*c))/(2*a);
    ld x2=(-b+sqrt((ld)b*b-(ld)4*a*c))/(2*a);
    ld x0=(-(ld)b/(2*a)),v=f(x0);
    fprintf(stderr,"%Lf %Lf\n",x1,x2);
    fprintf(stderr,"%Lf %Lf\n",x0,v);
}
int T;
int main(){
//    freopen("a.in","r",stdin);
	scanf("%d", &T);
	for(; T; T --) {
 	   cin>>n>>m;
        a=b=c=0;
        for (int i=1;i<=n;i++){
            ll a1,b1,a2,b2;
            scanf("%lld%lld%lld%lld",&b1,&a1,&b2,&a2);
            a+=a1*a2,
            b+=b1*a2+b2*a1;
            c+=b1*b2;
        }
        for (int i=1;i<=m;i++){
            ll a1,b1,a2,b2;
            scanf("%lld%lld%lld%lld",&b1,&a1,&b2,&a2);
            a-=a1*a2,
            b-=b1*a2+b2*a1;
            c-=b1*b2;
        }
    //    info();
        if (c>0){
            write(0);
            continue;
        }
        if (a==0){
            if (b<=0){
                write(-1);
                continue;
            }
            else {
                write((c/-b)+1);
                continue;
            }
        }
        if (a>0){
            ld x2=(-b+sqrt((ld)b*b-(ld)4*a*c))/(2*a);
            if (x2>1.1e18){
                write(-1);
                continue;
            }
            for (ll i=x2-100;i<=x2+100;i++){
                if (i>=0&&f(i)>0){
    //                cerr<<f(i-1)<<' '<<i<<endl;
                    x2=i;
                    break;
                }
            }
            write(x2);
            continue;
        }
        if (a<0){
            ld x0=-(b/(2*a));
            int can=0;
            for (ll i=x0-100;i<=x0+100;i++){
                if (i>=0&&f(i)>0){
                    can=1;
                    break;
                }
            }
            if (!can){
                write(-1);
                continue;
            }
            ld x1=(-b+sqrt((ld)b*b-(ld)4*a*c))/(2*a);
            for (ll i=x1-100;i<=x1+100;i++){
                if (i>=0&&f(i)>0){
                    x1=i;
                    break;
                }
            }
            if (x1>=0)write(x1);
            else write(-1);
            continue;
        }
    }
}