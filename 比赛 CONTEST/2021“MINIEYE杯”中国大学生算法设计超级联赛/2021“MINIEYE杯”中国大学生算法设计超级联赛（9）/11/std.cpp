#include<bits/stdc++.h>
#define N 200005
#define pb push_back
using namespace std;
int st[N],en[N],F[N],fa[N],si[N],son[N],ans1[N],ans2[N],dis[N],q[N];
long long t[N*4],sum[N],Ans[N];
vector<int>B[N],A[N],T[N];
int a[N],n,m,vis[N],Time,Stack[N],b[N],tot;
inline void dfs(int x,int y) {
    if (!y) y=x;
    st[x]=++tot;
    F[x]=y;
    int gt=0;
    for (auto p:A[x]) {
        if (fa[x]==p) continue;
        if (si[p]>si[gt]) gt=p;
    }
    son[x]=gt;
    if (gt) dfs(gt,y);
    for (auto p:A[x]) {
        if (fa[x]==p || p==gt) continue;
        dfs(p,0);
    }
    en[x]=tot;
}
inline int find(int x,int y) {
    while (dis[F[x]]>dis[y]) {
        if (fa[F[x]]==y) return F[x];
        x=fa[F[x]];
    }
    return son[y];
}
inline void build(int x) {
    int l=0,r=1;q[1]=x;
    dis[x]=1;
    while (l<r) {
        int k=q[++l];
        for (auto p:A[k]) {
            if (fa[k]==p) continue;
            fa[q[++r]=p]=k;
            dis[p]=dis[k]+1;
        }
    }
    for (int i=n;i;i--) si[q[i]]++,si[fa[q[i]]]+=si[q[i]];
}
inline bool cmp(int x,int y) {
    return st[x]<st[y];
}

inline void change(int o,int l,int r,int ll,int rr,long long p) {
    if (ll>rr) return ;
    if (l==ll&&r==rr) {
        t[o]+=p;
        return ;
    }
    int mid=(l+r)>>1;
    if (rr<=mid) change(o*2,l,mid,ll,rr,p);
    else if (ll>mid) change(o*2+1,mid+1,r,ll,rr,p);
    else change(o*2,l,mid,ll,mid,p),change(o*2+1,mid+1,r,mid+1,rr,p);
}
inline long long ask(int o,int l,int r,int ll) {
    if (l==ll&&r==ll) return t[o];
    int mid=(l+r)>>1;
    if (ll<=mid) return t[o]+ask(o*2,l,mid,ll);
    else return t[o]+ask(o*2+1,mid+1,r,ll);
}

inline void work(int x,int l,int r,vector<int>now, int v) {
    if (!v) {
        sort(now.begin(),now.end(),cmp);
        long long s=0;
        int last=l;
        for (auto p:now) {
            s+=sum[st[p]-1]-sum[last-1];
            last=en[p]+1;
        }
        s+=sum[r]-sum[last-1];
        last=l;
        for (auto p:now) {
            change(1,1,n,last,st[p]-1,s);
            last=en[p]+1;
        }
        change(1,1,n,last,r,s);
        for (auto p:now) work(p,st[p],en[p],B[p],1);
    }
    else {
        ans1[x]++;
        vector<int>s;
        s.clear();
        for (auto p:now) {
            int nf=find(p,x);
            if (vis[nf]!=Time) {
                vis[nf]=Time;
                ans2[nf]++;
                T[nf].clear();
                s.pb(nf);
            }
            T[nf].pb(p);
        }
        if (vis[son[x]]!=Time&&son[x]) {
            change(1,1,n,st[son[x]],en[son[x]],sum[en[son[x]]]-sum[st[son[x]]-1]);
        }
        for (auto p:s) work(p,st[p],en[p],T[p],0);
    }
}



inline long long ask(int x,int y) {
    long long ans=ask(1,1,n,st[x]);
    ans+=Ans[x];
    ans-=1ll*y*a[x];
    while (x) {
        if (F[x]==1) return ans;
        x=F[x];
        ans+=1ll*(ans1[fa[x]]-ans2[x])*(sum[en[x]]-sum[st[x]-1]);
        x=fa[x];
    }
    return ans;
}

inline void work(vector<int>q) {
    int r=0;
    for (auto p:q) B[p].clear();
    B[0].clear();
    for (auto p:q) {
        while (r&&st[p]>en[Stack[r]]) r--;
        B[Stack[r]].pb(p);
        Stack[++r]=p;
    }
}

int main() {
    //freopen("0.in","r",stdin);
    //freopen("small.in","r",stdin);
    //freopen("small.out","w",stdout);
    int test;
    scanf("%d",&test);
    while (test--) {
        scanf("%d%d",&n,&m);
        tot=0;
        for (int i=1;i<=n;i++) A[i].clear(),Ans[i]=si[i]=fa[i]=ans1[i]=ans2[i]=son[i]=0;
        for (int i=1;i<=4*n;i++) t[i]=0;
        for (int i=1;i<n;i++) {
            int x,y;
            scanf("%d%d",&x,&y);
            A[x].pb(y);
            A[y].pb(x);
        }
        for (int i=1;i<=n;i++) scanf("%d",&a[i]);
        build(1);
        si[0]=0;
        dfs(1,0);
        for (int i=1;i<=n;i++) b[st[i]]=i;
        for (int i=1;i<=n;i++) sum[i]=sum[i-1]+a[b[i]];
        int s=0;
        for (int i=1;i<=m;i++) {
            ++Time;
            int id;
            scanf("%d",&id);
            if (id==1) {
                int k;
                s++;
                scanf("%d",&k);
                vector<int> q;
                q.resize(k);
                for (int j=1;j<=k;j++) scanf("%d",&q[j-1]),Ans[q[j-1]]+=a[q[j-1]];
                sort(q.begin(),q.end(),cmp);
                work(q);
                if (q[0]==1) work(1,1,n,B[1],1);
                else {
                    work(1,1,n,B[0],0);
                }
            }
            else {
                int x;
                scanf("%d",&x);
                printf("%lld\n",ask(x,s));
            }
        }
    }
}
