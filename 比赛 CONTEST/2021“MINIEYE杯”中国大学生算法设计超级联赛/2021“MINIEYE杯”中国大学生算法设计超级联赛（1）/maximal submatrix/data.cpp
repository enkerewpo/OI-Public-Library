#include <bits/stdc++.h>
using namespace std;
typedef long long ll;
default_random_engine e;
int ui(int l,int r){
    uniform_int_distribution<int>u(l,r);
    return u(e);
}
ll ul(ll l,ll r){
    uniform_int_distribution<ll>u(l,r);
    return u(e);
}
double ud(double l,double r){
    uniform_real_distribution<double>u(l,r);
    return u(e);
}

int main()
{
    freopen("1.in","w",stdout);
    e.seed(time(0));srand(time(0));
    int T=10;
    printf("%d\n",T);
    while(T--){
        if(T==1){
            int n=ui(2000,2000),m=ui(2000,2000);
            printf("%d %d\n",n,m);
            for(int i=1;i<=n;i++){
                for(int j=1;j<=m;j++){
                    printf("%d ",ui(1,5e3));
                }
                printf("\n");
            }
        }else if(T==0){
            int n=ui(2000,2000),m=ui(2000,2000);
            printf("%d %d\n",n,m);
            for(int i=1;i<=n;i++){
                for(int j=1;j<=m;j++){
                    printf("%d ",i);
                }
                printf("\n");
            }
        }
        else {
            int n=ui(10,20),m=ui(10,20);
            printf("%d %d\n",n,m);
            for(int i=1;i<=n;i++){
                for(int j=1;j<=m;j++){
                    printf("%d ",ui(1,100));
                }
                printf("\n");
            }
        }
    }
    
}
