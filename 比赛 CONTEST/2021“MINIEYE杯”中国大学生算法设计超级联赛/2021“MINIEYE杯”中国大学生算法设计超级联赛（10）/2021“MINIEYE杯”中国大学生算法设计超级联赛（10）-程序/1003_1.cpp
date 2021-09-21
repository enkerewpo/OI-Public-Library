#include <bits/stdc++.h>
using namespace std;
const int N = 710, UP = 31500;
bitset<UP> f[N];

void init() {
	f[0][0]=1;
	for (int i=1; i<N; i++) {
		for (int k=1; k<=i; k++) f[i]|=f[i-k]<<(k*(i-k));
	}
}
void print(int x) {
	int lim=min(UP-1,x*(x-1)/2);
	for (int i=0; i<=lim; i++) if (f[x][i]) printf("%d ",i);
	for(int i=lim+1;i*2<=x*(x-1);i++) printf("%d ",i);
	putchar('\n');
}
int main() {
	// freopen("line.in","r",stdin);
	// freopen("line.out","w",stdout);
	init();
	int T=0;
	for(cin>>T;T;T--){
		int n;
		cin>>n;
		print(n);
	}
}
