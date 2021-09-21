#include<bits/stdc++.h>
#define F first
#define S second
using namespace std;
typedef pair<int,int>pi;
pi a[5005];
int b[5005],n,p,ans_best[5005],ans_worst[5005];
bool check1(int x,int y){
    int p=n;
    for (int i=n-y+1;i<=n;i++){
        if (p==x) p--;
        if (b[i]+a[p].F<=b[1]+a[x].F) return 0;
        p--;
    }
    return 1;
}
bool check2(int x,int y){
    int p=1;
    for (int i=y;i>=1;i--){
        if (p==x) p++;
        if (b[i]+a[p].F>b[n]+a[x].F) return 0;
        p++;
    }
    return 1;
}
int main(){
    int _; cin >> _;
    while (_--){
        cin >> n;
        for (int i=1;i<=n;i++){
            cin >> a[i].F;
            a[i].S=i;
        }
        for (int i=1;i<=n;i++) cin >> b[i];
        sort(a+1,a+n+1); reverse(b+1,b+n+1);
        p=n-1;
        for (int i=1;i<=n;i++){
            while (p>=0&&!check1(i,p)) p--;
            ans_worst[a[i].S]=p+1;
        }
        p=n-1;
        for (int i=n;i>=1;i--){
            while (p>=0&&!check2(i,p)) p--;
            ans_best[a[i].S]=n-p;
        }
        for (int i=1;i<=n;i++) cout << ans_best[i] << ' ' << ans_worst[i] << endl;
    }
    return 0;
}
