#include<bits/stdc++.h>
#define LL long long 
#define maxn 70005
using namespace std;
const int mo=998244353;
LL G,Gi;

LL n,m;
LL a[maxn],b[maxn];
int rev[maxn];
LL _a[maxn],_b[maxn];
LL lim;

LL upd(LL x){
	if(x>=mo)x-=mo;
	return x;
}

LL ksm(LL a,int k){
	LL res=1,p=a;
	while(k){
		if(k&1)res=res*p%mo;
		p=p*p%mo;
		k>>=1;
	}
	return res;
}

void ntt(int len,LL *a,int f){
	for(int i=0;i<len;i++)if(i<rev[i])swap(a[i],a[rev[i]]);
	for(int step=1;step<len;step<<=1){
		LL wn=ksm(f==1?G:Gi,(mo-1)/(step<<1));
		for(int l=0;l<len;l+=step<<1){
			LL w=1;
			for(int k=l;k<l+step;k++){
				LL x=a[k]%mo,y=a[k+step]*w%mo;
				a[k]=(x+y);
				a[k+step]=(x-y+mo);
				w=w*wn%mo;
			}
		}
	}
	for(int i=0;i<len;i++)a[i]=a[i]%mo;
	LL inv=ksm(len,mo-2);
	if(f==-1)for(int i=0;i<len;i++)a[i]=a[i]*inv%mo;
}

struct poly{
	LL a[maxn],n;
	void clear(){
		memset(a,0,sizeof(a));
		n=0;
	}
	poly(){
		clear();
	}
	void set(int sz){
		for(int i=sz+1;i<=n;i++)a[i]=0;
		n=sz;
	}
	void unit(){
		clear();
		a[0]=1;
	}
	void add(const poly &b){
		int m=max(n,b.n);
		for(int i=0;i<=m;i++)a[i]=(a[i]+b.a[i])%mo;
		n=m;
	}
	void mul(const poly &b){
		LL sz=1,t=0;
		while(sz<=n+b.n)sz<<=1,t++;
		for(int i=0;i<sz;i++)rev[i]=(rev[i>>1]>>1)|((i&1)<<t-1);
		ntt(sz,a,1);
		for(int i=0;i<sz;i++)_b[i]=b.a[i];
		ntt(sz,_b,1);
		for(int i=0;i<sz;i++)a[i]=a[i]*_b[i]%mo;
		ntt(sz,a,-1);
		n=sz-1;
		if(sz-1>lim)set(lim);
	}
	void print(){
	//	cout<<n<<endl;
		for(int i=1;i<=lim;i++)printf("%lld ",a[i]);
		puts("");
	}
}F0,F1,Fn,res,t;

struct matrix{
	poly a[3][3];
	int n,m;
	void clear(){
		memset(a,0,sizeof(a));
		n=m=0;
	}
	matrix(){
		clear();
	}
	void unit(int k){
	
		clear();
		n=m=k;
		for(int i=1;i<=k;i++)a[i][i].unit();
	}
	void print(){
		for(int i=1;i<=n;i++){
			for(int j=1;j<=m;j++){
				cout<<i<<" "<<j<<endl;
				a[i][j].print();
			}
		}
	}
}m0,M,p,c,d,u,M0;

void mul1(matrix &a,matrix &x){
	u=x;
	c.n=a.n,c.m=u.m;
	LL sz=1,bt=0,ma=0,mx=0;
	for(int i=1;i<=a.n;i++)for(int j=1;j<=a.m;j++)ma=max(ma,a.a[i][j].n);
	for(int i=1;i<=u.n;i++)for(int j=1;j<=u.m;j++)mx=max(mx,u.a[i][j].n);
	while(sz<=ma+mx)sz<<=1,bt++;
	for(int i=0;i<sz;i++)rev[i]=(rev[i>>1]>>1)|((i&1)<<bt-1);
	for(int i=1;i<=a.n;i++)for(int j=1;j<=a.m;j++)ntt(sz,a.a[i][j].a,1);
	for(int i=1;i<=u.n;i++)for(int j=1;j<=u.m;j++)ntt(sz,u.a[i][j].a,1);
	for(int i=1;i<=c.n;i++){
		for(int j=1;j<=c.m;j++){
			res.clear();
			for(int k=1;k<=a.m;k++){
				for(int w=0;w<sz;w++)t.a[w]=a.a[i][k].a[w]*u.a[k][j].a[w]%mo;
				ntt(sz,t.a,-1);
				t.n=sz-1;
				if(sz>lim)t.set(lim);
				res.add(t);
			}
			c.a[i][j]=res;
		}
	}
	a.n=c.n,a.m=c.m;
	for(int i=1;i<=a.n;i++)for(int j=1;j<=a.m;j++)a.a[i][j]=c.a[i][j];
}

void mul2(matrix &a){
	c.n=a.n,c.m=a.m;
	LL sz=1,bt=0,ma=0;
	for(int i=1;i<=a.n;i++)for(int j=1;j<=a.m;j++)ma=max(ma,a.a[i][j].n);
	while(sz<=ma+ma)sz<<=1,bt++;
	for(int i=0;i<sz;i++)rev[i]=(rev[i>>1]>>1)|((i&1)<<bt-1);
	for(int i=1;i<=a.n;i++)for(int j=1;j<=a.m;j++)ntt(sz,a.a[i][j].a,1);
	for(int i=1;i<=c.n;i++){
		for(int j=1;j<=c.m;j++){
			res.clear();
			for(int k=1;k<=a.m;k++){
				for(int w=0;w<sz;w++)t.a[w]=a.a[i][k].a[w]*a.a[k][j].a[w]%mo;
				ntt(sz,t.a,-1);
				t.n=sz-1;
				if(sz>lim)t.set(lim);
				res.add(t);
			}
			c.a[i][j]=res;
		}
	}
	a.n=c.n,a.m=c.m;
	for(int i=1;i<=a.n;i++)for(int j=1;j<=a.m;j++)a.a[i][j]=c.a[i][j];
}

void qpow(matrix &p,LL k){
	d.unit(p.n);
	while(k){
		if(k&1)mul1(d,p);
		mul2(p);
		k>>=1;
	}
	p.n=d.n,p.m=d.m;
	for(int i=1;i<=p.n;i++)for(int j=1;j<=p.m;j++)p.a[i][j]=d.a[i][j];
}
int T;

int main(){
	freopen("data.in","r",stdin);
	freopen("1.out","w",stdout);
	G=3,Gi=ksm(G,mo-2);
	scanf("%d",&T);
	F0.a[0]=1,F0.n=0;
	F1.a[0]=1,F1.a[1]=1,F1.a[2]=1,F1.n=2;
	m0.n=2,m0.m=1,m0.a[1][1]=F1,m0.a[2][1]=F0;
	M0.n=M0.m=2;
	M0.a[1][1].a[0]=M0.a[1][1].a[1]=M0.a[1][1].a[2]=1,M0.a[1][1].n=2;
	M0.a[1][2].a[1]=1,M0.a[1][2].a[2]=2,M0.a[1][2].a[3]=1,M0.a[1][2].n=3;
	M0.a[2][1].a[0]=1,M0.a[2][2].a[0]=0,M0.a[2][1].n=M0.a[2][2].n=0;
	while(T--){
		scanf("%lld%lld",&n,&m);
		M=M0;
		lim=m;
		qpow(M,n-1);
		mul1(M,m0);
		Fn=M.a[1][1];
		Fn.print();
	}
	
}
