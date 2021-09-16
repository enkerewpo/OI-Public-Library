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
    e.seed(time(0));srand(time(0));
    int T=5;
    printf("%d\n",T);
    while(T--){
        if(T==0){
            int n=ui(2e5,2e5);
            printf("%d\n",n);
            for(int i=1;i<=n;i++){
                printf("%d %d %d %d\n",ui(-1e9,1e9),ui(-1e9,1e9),ui(1,1e9),ui(0,1e9));
            }
        }else{
            int n=ui(100,2000);
            printf("%d\n",n);
            for(int i=1;i<=n;i++){
                printf("%d %d %d %d\n",ui(-1e3,1e3),ui(-1e3,1e3),ui(1,1e3),ui(0,1e3));
            }
        }
        
    }
    
}
