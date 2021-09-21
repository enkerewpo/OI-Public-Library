#include<bits/stdc++.h>
using namespace std;
typedef long long LL;
typedef double DB;
const int N = 111111;
const int M = N*60;
const int inf = 1e9+N;
int n,k,q,d,tot,rt,ls[M],rs[M];
int t[M],w[M],s[M],e[M];
void ch(int u,int x){
	w[u]+=x;
	t[u]+=x;
	s[u]+=x;
	e[u]+=x;
}
void modify2(int&u,int L,int R,int X,int l,int r){
	if(!u)
		u=++tot;
	if(L<=l&&r<=R){
		ch(u,X);
		return;
	}
	int h=l+r>>1;
	if(L<=h)
		modify2(ls[u],L,R,X,l,h);
	if(h<R)
		modify2(rs[u],L,R,X,h+1,r);
	t[u]=max(t[ls[u]],t[rs[u]])+w[u];
}
int solve(int u,int l,int r,int cl=0,int cr=k-1){
	int h=l+r>>1,fl;
	int u1=ls[u],l1=l,r1=h,u2=rs[u],l2=h+1,r2=r;
	int w1=w[u1],w2=w[u2],s=inf,o;
	while(l1!=r1){
		u1=rs[u1];
		w1+=w[u1];
		l1=(l1+r1>>1)+1;
	}
	while(l2!=r2){
		u2=ls[u2];
		w2+=w[u2];
		r2=l2+r2>>1;
	}
	l=0,r=k-1;
	o=-inf;
	while(l!=r){
		h=l+r>>1;
		if(cl<=h+1&&h+1<=cr)
			s=min(s,max(o,max(w1+t[rs[u1]],w2+t[ls[u2]])));
		if(cr<h+1)
			fl=0;
		else{
			if(h+1<cl)
				fl=1;
			else
				fl=w1+t[rs[u1]]>=w2+t[ls[u2]];
		}
		if(fl){
			o=max(o,w2+t[ls[u2]]);
			l=h+1;
			u1=rs[u1];
			u2=rs[u2];
		}
		else{
			o=max(o,w1+t[rs[u1]]);
			r=h;
			u1=ls[u1];
			u2=ls[u2];
		}
		w1+=w[u1];
		w2+=w[u2];
	}
	return s;
}
void modify1(int&u,int L,int R,int X,int l=0,int r=d){
	if(!u)
		u=++tot;
	if(L<=l*k&&r*k+k-1<=R){
		ch(u,X);
		return;
	}
	if(l==r){
		modify2(u,L,R,X,l*k,r*k+k-1);
		s[u]=t[u];
		return;
	}
	int h=l+r>>1;
	if(L<=h*k+k-1)
		modify1(ls[u],L,R,X,l,h);
	if((h+1)*k<=R)
		modify1(rs[u],L,R,X,h+1,r);
	t[u]=max(t[ls[u]],t[rs[u]])+w[u];
	if(L<=h*k&&(h+1)*k+k-1<=R)
		e[u]+=X;
	else{
		if(L<=(h+1)*k+k-1||h*k<=R)
			e[u]=solve(u,l,r)+w[u];
	}
	s[u]=min(min(s[ls[u]],s[rs[u]])+w[u],e[u]);
}
int query(int u,int L,int R,int l=0,int r=d){
	if(R<l*k+k-1||r*k<L)
		return inf;
	if(!u)
		return 0;
	if(L<=l*k&&r*k+k-1<=R)
		return s[u];
	if(l==r)
		return inf;
	int h=l+r>>1,o;
	if(R<=h*k+k-1)
		return query(ls[u],L,R,l,h)+w[u];
	if((h+1)*k<=L)
		return query(rs[u],L,R,h+1,r)+w[u];
	if(h*k<L||R<(h+1)*k+k-1)
		o=solve(u,l,r,max(0,L-h*k),min(k-1,R-(h+1)*k+1))+w[u];
	else
		o=e[u];
	return min(o,min(query(ls[u],L,R,l,h),query(rs[u],L,R,h+1,r))+w[u]);
}
int main()
{
	//freopen("input2.txt","r",stdin);
	//freopen("std.out","w",stdout);
	int T,i,l,r,x;
	scanf("%d",&T);
	while(T--){
		scanf("%d%d%d",&n,&k,&q);
		d=(n-1)/k;
		n=(d+1)*k;
		while(q--){
			scanf("%d%d%d",&i,&l,&r);
			l--,r--;
			if(i==1){
				scanf("%d",&x);
				modify1(rt,l,r,x);
			}
			else{
				printf("%d\n",query(rt,l,r));
			}
		}
		tot=0,rt=0;
		memset(ls,0,sizeof(ls));
		memset(rs,0,sizeof(rs));
		memset(t,0,sizeof(t));
		memset(w,0,sizeof(w));
		memset(s,0,sizeof(s));
		memset(e,0,sizeof(e));
	}
	return 0;
}
