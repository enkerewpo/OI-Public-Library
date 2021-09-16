#include<bits/stdc++.h>
#define N 200009
using namespace std;
typedef long long ll;
const int mod=1e9+7;
ll a[N][2];
int n,m;
inline ll rd(){
	ll x=0;char c=getchar();bool f=0;
	while(!isdigit(c)){if(c=='-')f=1;c=getchar();}
	while(isdigit(c)){x=(x<<1)+(x<<3)+(c^48);c=getchar();}
	return f?-x:x;
}
inline void MOD(ll &x){x=x>=mod?x-mod:x;}
struct matrix{
	ll a[2][2];
	matrix(){memset(a,0,sizeof(a));a[0][0]=a[1][1]=1;}
	inline matrix operator *(const matrix &b)const{
		matrix c;c.a[0][0]=c.a[1][1]=0;
		for(int i=0;i<2;++i)
		    for(int j=0;j<2;++j)
		        for(int k=0;k<2;++k)
		            MOD(c.a[i][j]+=a[i][k]*b.a[k][j]%mod);
	    return c;
    }
}; 
matrix rev,wk;
inline void wok(int cnt,int l,int r,int L,int R,matrix tag);
inline void upd(int cnt,int l,int r,int tag,int L,int R,int x);
inline void clear(matrix &a){
	memset(a.a,0,sizeof(a.a));
	a.a[0][0]=a.a[1][1]=1;
}
struct seg{
	ll sum[2],sm,adtag[2],sum1[2];
	matrix tag;
}tr[N<<2];
inline void pushup(int cnt){
	MOD(tr[cnt].sm=tr[cnt<<1].sm+tr[cnt<<1|1].sm);
	MOD(tr[cnt].sum[0]=tr[cnt<<1].sum[0]+tr[cnt<<1|1].sum[0]);
	MOD(tr[cnt].sum[1]=tr[cnt<<1].sum[1]+tr[cnt<<1|1].sum[1]);
	MOD(tr[cnt].sum1[0]=tr[cnt<<1].sum1[0]+tr[cnt<<1|1].sum1[0]);
	MOD(tr[cnt].sum1[1]=tr[cnt<<1].sum1[1]+tr[cnt<<1|1].sum1[1]);
}
inline void pushdown(int cnt,int l,int r){
	int mid=(l+r)>>1;
	wok(cnt<<1,l,mid,l,mid,tr[cnt].tag);
	wok(cnt<<1|1,mid+1,r,mid+1,r,tr[cnt].tag);
	clear(tr[cnt].tag); 
    for(int i=0;i<2;++i){
        upd(cnt<<1,l,mid,i,l,mid,tr[cnt].adtag[i]);
        upd(cnt<<1|1,mid+1,r,i,mid+1,r,tr[cnt].adtag[i]);
        tr[cnt].adtag[i]=0;
    }
}
void build(int cnt,int l,int r){
    if(l==r){
    	tr[cnt].sum[0]=a[l][0];
    	tr[cnt].sum[1]=a[l][1];
    	tr[cnt].sm=a[l][0]*a[l][1]%mod;
    	tr[cnt].sum1[0]=a[l][0]*a[l][0]%mod;
    	tr[cnt].sum1[1]=a[l][1]*a[l][1]%mod;
    	return;
    }
    int mid=(l+r)>>1; 
    build(cnt<<1,l,mid);
    build(cnt<<1|1,mid+1,r);
    pushup(cnt);
}
void upd(int cnt,int l,int r,int tag,int L,int R,int x){
    if(l>=L&&r<=R){
    	MOD(tr[cnt].adtag[tag]+=x);
    	(tr[cnt].sum1[tag]+=1ll*x*x%mod*(r-l+1)%mod+2ll*x*tr[cnt].sum[tag]%mod)%=mod;
    	MOD(tr[cnt].sum[tag]+=1ll*x*(r-l+1)%mod); 
    	MOD(tr[cnt].sm+=1ll*x*tr[cnt].sum[tag^1]%mod);
    	return; 
    }
    int mid=(l+r)>>1;
    pushdown(cnt,l,r);
    if(L<=mid)upd(cnt<<1,l,mid,tag,L,R,x);
    if(mid<R)upd(cnt<<1|1,mid+1,r,tag,L,R,x);
    pushup(cnt);
}
void wok(int cnt,int l,int r,int L,int R,matrix x){
	if(l>=L&&r<=R){
		ll sm=tr[cnt].sm;
		ll c=x.a[0][0],d=x.a[0][1],e=x.a[1][0],f=x.a[1][1];
		ll xx=tr[cnt].sum1[0],yy=tr[cnt].sum1[1];
		tr[cnt].sm=tr[cnt].sum1[0]*c%mod*d+tr[cnt].sum1[1]*e%mod*f+tr[cnt].sm*(c*f%mod+d*e%mod);
		tr[cnt].sm=tr[cnt].sm%mod;
		tr[cnt].sum1[0]=(c*c%mod*xx+e*e%mod*yy+2ll*c*e%mod*sm)%mod;
		tr[cnt].sum1[1]=(d*d%mod*xx+f*f%mod*yy+2ll*d*f%mod*sm)%mod;
		xx=tr[cnt].sum[0];yy=tr[cnt].sum[1];
		tr[cnt].sum[0]=(xx*c+yy*e)%mod;
		tr[cnt].sum[1]=(xx*d+yy*f)%mod;
		xx=tr[cnt].adtag[0];yy=tr[cnt].adtag[1];
		tr[cnt].adtag[0]=(xx*x.a[0][0]+yy*x.a[1][0])%mod;
		tr[cnt].adtag[1]=(xx*x.a[0][1]+yy*x.a[1][1])%mod;
		tr[cnt].tag=tr[cnt].tag*x;
		return;
	}
	int mid=(l+r)>>1;
	pushdown(cnt,l,r);
	if(mid>=L)wok(cnt<<1,l,mid,L,R,x);
	if(mid<R)wok(cnt<<1|1,mid+1,r,L,R,x); 
	pushup(cnt);
}
ll q(int cnt,int l,int r,int L,int R){
	if(l>=L&&r<=R)return tr[cnt].sm;
	int mid=(l+r)>>1;
	pushdown(cnt,l,r);
	ll ans=0;
	if(mid>=L)ans+=q(cnt<<1,l,mid,L,R);
	if(mid<R)MOD(ans+=q(cnt<<1|1,mid+1,r,L,R));
	return ans;
}
int main(){
	n=rd();
	for(int i=1;i<=n;++i){
		a[i][0]=rd();a[i][1]=rd();
	}
    build(1,1,n);
    m=rd();
    int l,r,tag,x,opt;
    while(m--){
    	opt=rd();
		wk.a[0][0]=wk.a[0][1]=3;
		wk.a[1][0]=2;
        wk.a[1][1]=mod-2;
        rev.a[0][0]=rev.a[1][1]=0;
		rev.a[0][1]=rev.a[1][0]=1;
    	if(opt==1){
    		tag=rd();l=rd();r=rd();x=rd();
    		upd(1,1,n,tag,l,r,x);
    	}
    	if(opt==2){
    		l=rd();r=rd();
			
    		wok(1,1,n,l,r,wk);
    	}
    	if(opt==3){
    		l=rd();r=rd();
    		wok(1,1,n,l,r,rev);
    	}
    	if(opt==4){
    		l=rd();r=rd();
    		printf("%lld\n",q(1,1,n,l,r));
    	}
    }
	return 0;
}

