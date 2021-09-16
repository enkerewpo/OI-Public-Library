#include<bits/stdc++.h>
#define N 100009
using namespace std;
typedef long long ll;
int nxt[N],c[N],head[N],Q,ans[N];
int n,tot,tr[N],ch[N*20][2],sum[N*20];
inline ll rd(){
	ll x=0;char c=getchar();bool f=0;
	while(!isdigit(c)){if(c=='-')f=1;c=getchar();}
	while(isdigit(c)){x=(x<<1)+(x<<3)+(c^48);c=getchar();}
	return f?-x:x;
}
inline void add(int x,int y){while(x<=n)tr[x]+=y,x+=x&-x;}
inline int query(int x){int ans=0;while(x)ans+=tr[x],x-=x&-x;return ans;}
struct node{
	int l,r,x,id;
	inline bool operator <(const node &b)const{
		if(x!=b.x)return x<b.x;
		if(id!=b.id)return id<b.id;
		return l<b.l; 
	}
};
struct qq{
	int l,r,a,b;
}q[N];
vector<node>vec[N*20];
vector<node>::iterator it; 
void query(int rt,int now,int a,int b,int id){
	if(!rt&&now!=16)return;
	if(now<0){
	    vec[rt].push_back(node{q[id].l,q[id].r,n-q[id].r+1,id});
	    return;
	}
	int xx=(a&(1<<now))!=0,yy=(b&(1<<now))!=0;
	if(yy) vec[ch[rt][xx]].push_back(node{q[id].l,q[id].r,n-q[id].r+1,id});
	xx^=yy;
	query(ch[rt][xx],now-1,a,b,id);
}
void ins(int x,int id){
	int now=0;
	for(int i=16;i>=0;--i){
		int xx=(x&(1<<i))!=0;
		if(!ch[now][xx])ch[now][xx]=++tot;
		now=ch[now][xx];
		sum[now]++;
		vec[now].push_back(node{id,0,n-nxt[id]+2,0});
	}
}
void solve(){
	n=rd();
	for(int i=1;i<=n;++i){
		c[i]=rd();
    }
    for(int i=n;i>=1;--i){
    	if(!head[c[i]])nxt[i]=n+1;
    	else nxt[i]=head[c[i]];
    	head[c[i]]=i;
    }
    for(int i=1;i<=n;++i)ins(c[i],i);
    Q=rd();
    for(int i=1;i<=Q;++i){
    	q[i].l=rd();q[i].r=rd();q[i].a=rd();q[i].b=rd();
    	query(0,16,q[i].a,q[i].b,i);
    }
    for(int i=1;i<=tot;++i){
    	sort(vec[i].begin(),vec[i].end());
    	for(it=vec[i].begin();it!=vec[i].end();++it){
    		if(it->id==0){
			    add(it->l,1);	  
			}
    		else {
			  ans[it->id]+=query(it->r)-query(it->l-1);
		    }
    	}
    	for(it=vec[i].begin();it!=vec[i].end();++it){
    		if(it->id==0){
			  add(it->l,-1);
		    }
        }
    }
    for(int i=1;i<=Q;++i)printf("%d\n",ans[i]);
}
int main(){
    int T=1;
	while(T--){
		solve(); 
	}
	return 0;
}

