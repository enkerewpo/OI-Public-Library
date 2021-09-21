#include<bits/stdc++.h>
#define MAXN 200005
#define INF 1000000000
#define MOD 1000000007
#define F first
#define S second
using namespace std;
typedef long long ll;
typedef pair<ll,ll> P;
int n,q,a[MAXN];
struct segtree
{
    int sum[4*MAXN];
    ll ssum[4*MAXN];
    void pushup(int k)
    {
        sum[k]=sum[k*2]+sum[k*2+1];
        ssum[k]=ssum[k*2]+ssum[k*2+1]+1LL*sum[k*2]*sum[k*2+1];
    }
    void build(int k,int l,int r)
    {
        if(l==r)
        {
            sum[k]=a[l]; ssum[k]=1LL*a[l]*a[l];
            return;
        }
        int mid=(l+r)/2;
        build(k*2,l,mid); build(k*2+1,mid+1,r);
        pushup(k);
    }
    void update(int k,int l,int r,int p,int v)
    {
        if(l==r)
        {
            ssum[k]+=2LL*v*sum[k]; ssum[k]+=1LL*v*v;
            sum[k]+=v;
            return;
        }
        int mid=(l+r)/2;
        if(p<=mid) update(k*2,l,mid,p,v); else update(k*2+1,mid+1,r,p,v);
        pushup(k);
    }
    int query_sum(int k,int l,int r,int x,int y)
    {
        if(l>y||x>r) return 0;
        if(l>=x&&r<=y) return sum[k];
        int mid=(l+r)/2;
        return query_sum(k*2,l,mid,x,y)+query_sum(k*2+1,mid+1,r,x,y);
    }
    int query_midpoint(int k,int l,int r,int ss)
    {
        if(l==r) return l;
        int mid=(l+r)/2;
        if(sum[k*2]>=ss) return query_midpoint(k*2,l,mid,ss); else return query_midpoint(k*2+1,mid+1,r,ss-sum[k*2]);
    }
    P query_ans(int k,int l,int r,int x,int y)
    {
        if(l>y||x>r) return P(0,0);
        if(l>=x&&r<=y) return P(ssum[k],sum[k]);
        int mid=(l+r)/2;
        P p=query_ans(k*2,l,mid,x,y),q=query_ans(k*2+1,mid+1,r,x,y);
        return make_pair(p.F+q.F+1LL*p.S*q.S,p.S+q.S);
    }
}seg;
int main()
{
    int _; cin >> _;
    while (_--){
        scanf("%d%d",&n,&q);
        for(int i=0;i<MAXN;i++) a[i]=0;
        for(int i=1;i<=n;i++)
        {
            int x;
            scanf("%d",&x);
            a[x]++;
        }
        int s=n,sz=200000;
        seg.build(1,1,sz);
        for(int i=0;i<q;i++)
        {
            int type,x,y;
            scanf("%d",&type);
            if(type==1)
            {
                scanf("%d%d",&x,&y);
                seg.update(1,1,sz,y,x);
                s+=x;
            }
            else
            {
                int pos=seg.query_midpoint(1,1,sz,s/2);
                int sum=seg.query_sum(1,1,sz,1,pos),val=seg.query_sum(1,1,sz,pos,pos);
                if(sum-val>=s-sum) pos--;
                P p=seg.query_ans(1,1,sz,1,pos); P q=seg.query_ans(1,1,sz,pos+1,sz);
                p.F-=p.S; q.F-=q.S;
                ll denom=1LL*s*(s-1);
                ll num=denom;
                num-=p.F; num-=q.F;
                ll g=__gcd(num,denom);
                num/=g; denom/=g;
                printf("%lld/%lld\n",num,denom);
            }
        }
    }
    return 0;
}
