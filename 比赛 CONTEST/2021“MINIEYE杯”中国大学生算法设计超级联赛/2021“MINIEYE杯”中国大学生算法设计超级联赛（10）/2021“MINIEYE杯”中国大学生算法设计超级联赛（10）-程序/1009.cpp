#include <cstdio>
#include <cstring>
#include <algorithm>
#define fo(i,a,b) for(int i=a;i<=b;i++)
#define fd(i,a,b) for(int i=a;i>=b;i--)
using namespace std;

typedef long long ll;

int read() {
	char ch;
	for(ch=getchar();ch<'0'||ch>'9';ch=getchar());
	int x=ch-'0';
	for(ch=getchar();ch>='0'&&ch<='9';ch=getchar()) x=x*10+ch-'0';
	return x;
}

void write(int x) {
	if (!x) {puts("0");return;}
	char ch[20];int tot=0;
	for(;x;x/=10) ch[++tot]=x%10;
	fd(i,tot,1) putchar(ch[i]+'0');
	puts("");
}

const int N=1e7+5,Mo=998244353;

int f[N],inv[N],q,k,a,b;

void pre(int N) {
	inv[0]=inv[1]=1;
	fo(i,2,N) inv[i]=(ll)(Mo-Mo/i)*inv[Mo%i]%Mo;
	fo(i,1,N) f[i]=0;
	f[1]=1;
	fo(i,1,N-1) {
		(f[i+1]+=(ll)b*(4*i-2)%Mo*f[i]%Mo)%=Mo;
		if (i==k) a=(ll)a*f[i]%Mo;
		if (i>=k) (f[i+1]+=(ll)a*(2*i-3*k+2)%Mo*f[i-k+1]%Mo)%=Mo;
		if (i>=2*k) (f[i+1]-=(ll)a*a%Mo*(i-3*k+1)%Mo*f[i-2*k+1]%Mo)%=Mo;
		if (i==k) (f[i+1]+=(ll)a*(2*k-1)%Mo)%=Mo;
		f[i+1]=(ll)f[i+1]*inv[i+1]%Mo;
	}
	fo(i,1,N) f[i]=((ll)f[i]*f[i]%Mo+f[i-1])%Mo;
}

void solve() {
	q=read();k=read();a=read();b=read();
	(a-=b)%=Mo;pre(1e7);
	for(;q;q--) {
		int l=read(),r=read();
		int ans=(f[r]-f[l-1])%Mo;
		write((ans+Mo)%Mo);
	}
}

int main() {
	for(int ty=read();ty;ty--) solve();
	return 0;
}