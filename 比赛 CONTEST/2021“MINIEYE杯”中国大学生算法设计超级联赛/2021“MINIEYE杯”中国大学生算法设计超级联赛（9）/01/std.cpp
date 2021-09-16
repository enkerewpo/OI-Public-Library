#include<bits/stdc++.h>
using namespace std;
typedef unsigned long long ull;
ull x;
int _,tot,mx;
void work(ull x){
    if (x<=8){
        printf("p1\n"); tot++;
        if (x>1) printf("add %d\n",10-(x-1)),tot++;
    } else if (x<16){
        printf("dup\n");
        printf("sub %d\n",10-(16-x));
        tot+=2;
    } else {
        ull t=x&15;
        if (t<=8){
            work(x>>4);
            printf("mul %d\n",1); tot++;
            if (t) printf("add %d\n",10-t),tot++;
        } else {
            work((x>>4)+1);
            printf("mul %d\n",1);
            printf("sub %d\n",10-(16-t));
            tot+=2;
        }
    }
}
int main(){
    cin >> _;
    while (_--){
        tot=0;
        cin >> x;
        if (!x){
            printf("p1\nsub 0\nend\n");
            continue;
        }
        printf("p1\n");
        for (int i=1;i<=7;i++) {
            printf("dup\n");
            printf("add %d\n",i);
        }
        printf("dup\nadd 1\n");
        work(x);
        printf("end\n");
        assert(tot<=32);
    }
    return 0;
}
