#include<bits/stdc++.h>
#define LL long long
#define maxn 100005
#define ls rt<<1
#define rs rt<<1|1
using namespace std;

const LL mo=998244353;
LL a1[maxn],a2[maxn];
int T,n,q;
LL s1[maxn<<2],s2[maxn<<2],la[maxn<<2],tg[maxn<<2];

LL lowbit(LL x){
	return x&(-x);	
}

void pushup(int rt){
	s1[rt]=(s1[ls]+s1[rs])%mo;
	s2[rt]=(s2[ls]+s2[rs])%mo;
	tg[rt]=tg[ls]&tg[rs];
}

void pushdown(int rt){
	la[ls]=la[ls]*la[rt]%mo;
	la[rs]=la[rs]*la[rt]%mo;
	s1[ls]=s1[ls]*la[rt]%mo;
	s1[rs]=s1[rs]*la[rt]%mo;
	tg[ls]|=tg[rt];
	tg[rs]|=tg[rt];
	if(tg[ls])s2[ls]=0;
	if(tg[rs])s2[rs]=0;
	la[rt]=1;
}

void build(int rt,int l,int r){
	la[rt]=1,tg[rt]=0;
	if(l==r){
		s1[rt]=a1[l],s2[rt]=a2[l];
		return;
	}
	int mid=l+r>>1;
	build(ls,l,mid);
	build(rs,mid+1,r);
	pushup(rt);
}

LL query(int rt,int l,int r,int ll,int rr){
	if(ll<=l&&rr>=r){
		return (s1[rt]+s2[rt])%mo;
	}
	pushdown(rt);
	int mid=l+r>>1;
	LL ans=0;
	if(ll<=mid)ans+=query(ls,l,mid,ll,rr);
	if(rr>mid)ans+=query(rs,mid+1,r,ll,rr);
	ans%=mo;
	return ans;
}

void upd1(int rt,int l,int r,int ll,int rr){
	if(l==r){
		if(s2[rt])
			s2[rt]-=lowbit(s2[rt]);
		else{
			s1[rt]=0;
			tg[rt]=1;
		}
		return;
	}
	pushdown(rt);
	int mid=l+r>>1;
	if(ll<=mid&&!tg[ls])upd1(ls,l,mid,ll,rr);
	if(rr>mid&&!tg[rs])upd1(rs,mid+1,r,ll,rr);
	pushup(rt);
}

void upd2(int rt,int l,int r,int ll,int rr){
	if(ll<=l&&rr>=r){
		s1[rt]=s1[rt]*2%mo;
		la[rt]=la[rt]*2%mo;
		return;
	}
	pushdown(rt);
	int mid=l+r>>1;
	if(ll<=mid)upd2(ls,l,mid,ll,rr);
	if(rr>mid)upd2(rs,mid+1,r,ll,rr);
	pushup(rt);
}

int main(){
	scanf("%d",&T);
	while(T--){
		scanf("%d",&n);
		for(int i=1;i<=n;i++){
			LL x;
			scanf("%lld",&x);
			for(int k=30;k>=0;k--){
				if((1ll<<k)<=x){
					a1[i]=1ll<<k;
					a2[i]=x-a1[i];
					break;
				}
			}
		}
		build(1,1,n);
		scanf("%d",&q);
		for(int i=1;i<=q;i++){
			int opt,l,r;
			scanf("%d%d%d",&opt,&l,&r);
			if(opt==1){
				LL ans=query(1,1,n,l,r);
				printf("%lld\n",ans);
			}
			else if(opt==2)
				upd1(1,1,n,l,r);
			
			else
				upd2(1,1,n,l,r);
		}
	}
}
