#include <bits/stdc++.h>
using namespace std;
const int N = 5e5 + 10;
int n, a[N], b[N], m;
int fa[N];
vector<int> ri[N];
set<int> sp;
int cnt;
vector<int> e[N];
int gf(int x) {
    return fa[x] == 0 ? x : fa[x] = gf(fa[x]);
}

void link(int L, int R, int d){
    set<int> :: iterator it
        = sp.lower_bound(L);
    int las = 0;
    while (it != sp.end() && *it <= R) {
        e[*it].push_back(d);
        e[d].push_back(*it);
        if (las) {
            fa[las] = *it;
        }
        las = *it;
        it = sp.lower_bound(gf(*it)+1);
    }
}
int can,vis[N];
void dfs(int x) {
    for(int y : e[x]) {
        if (vis[y] == 0) {
            vis[y] = 3 - vis[x];
            dfs(y);
        } else {
            if (vis[y] == vis[x]) can = 0;
        }
    }
}

int sum[N], bd[N];
void read(int &x) {
    char c; while((c=getchar())>'9'||c<'0');
    x=c-'0';while((c=getchar())>='0'&&c<='9')x=x*10+c-'0';
}

int TT;

int main() {
    //freopen("data.in","r",stdin);
    for(scanf("%d", &TT); TT; TT --) {
        cin >> n >> m;
        memset(a,0,sizeof a);
        memset(b,0,sizeof b);
        memset(fa,0,sizeof fa);
        memset(vis,0,sizeof vis);
        can=0;
        memset(sum,0,sizeof sum);
        memset(bd,0,sizeof bd);
        for(int i=0;i<N;i++)ri[i].clear(),e[i].clear();
        sp.clear();
        cnt=0;
        for(int i = 1; i <= m; i++) {
            read(a[i]), read(b[i]);
            if (a[i] > b[i]) swap(a[i], b[i]);
            if (a[i] == 1 && b[i] == n || a[i] == b[i] - 1) {
                continue;
            }
            ri[a[i]].push_back(b[i]);
            sum[b[i]]++;
        }
        for(int i = 1; i <= n; i++) sum[i]+=sum[i-1];
        memcpy(bd,sum,sizeof sum);
        
        for(int i = 1; i <= n; i++) {
            sort(ri[i].begin(), ri[i].end());
            ri[i].resize(unique(ri[i].begin(), ri[i].end()) - ri[i].begin());
        }
        for(int i = n; i; i--) {
            for(int y : ri[i]) {
                sp.insert(bd[y]);
                // cerr << i << " " << y << " " << cnt bd[y]<< endl;
                bd[y]--;
            }
        }
        memcpy(bd,sum,sizeof sum);
        for(int i = n; i; i--) {
            for(int y : ri[i]) {
                ++cnt;
                link(sum[i]+1, sum[y-1], bd[y]);
                sp.erase(bd[y]);
                bd[y]--;
            }
        }

        int ans = 1;
        for(int i = 1; i <= m; i++) {
            if (vis[i] == 0) {
                can = 2; vis[i] = 1, dfs(i);
                if (can == 0) {
                    ans = 0; break;
                }
            }
        }
        cout << (ans ? "Yes\n" : "No\n");
    }

}