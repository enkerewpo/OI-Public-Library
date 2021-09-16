//    苔花如米小，也学牡丹开。 
//    Zhikun Wang (nocriz)
//    $_DATE

#include <bits/stdc++.h>
using namespace std;
 
using ll = long long; using db = long double; using str = string;
using pi = pair<int,int>; using pl = pair<ll,ll>; using pd = pair<db,db>;
using vi = vector<int>; using vb = vector<bool>; using vl = vector<ll>;
using vd = vector<db>; using vs = vector<str>;
using vpi = vector<pi>; using vpl = vector<pl>; using vpd = vector<pd>;

#define tcT template<class T
#define tcTU tcT, class U
tcT> using V = vector<T>;  tcT, size_t SZ> using AR = array<T,SZ>; tcT> using PR = pair<T,T>;

#define mp make_pair 
#define f first
#define s second
#define sz(x) int((x).size())
#define bg(x) begin(x)
#define all(x) bg(x), end(x)
#define rall(x) x.rbegin(), x.rend() 
#define sor(x) sort(all(x)) 
#define rsz resize
#define ins insert 
#define ft front()
#define bk back()
#define pb push_back
#define eb emplace_back 
#define pf push_front
#define lb lower_bound
#define ub upper_bound

tcT> int lwb(V<T>& a, const T& b) { return int(lb(all(a),b)-bg(a)); }

#define FOR(i,a,b) for (int i = (a); i < (b); ++i)
#define F0R(i,a) FOR(i,0,a)
#define ROF(i,a,b) for (int i = (b)-1; i >= (a); --i)
#define R0F(i,a) ROF(i,0,a)
#define each(a,x) for (auto& a: x)

const int MOD = 998244353;
const ll INF = 1e18; // not too close to LLONG_MAX
const db PI = acos((db)-1);
const int dx[4] = {1,0,-1,0}, dy[4] = {0,1,0,-1}; // for every grid problem!!
mt19937 rng((uint32_t)chrono::steady_clock::now().time_since_epoch().count()); 
template<class T> using pqg = priority_queue<T,vector<T>,greater<T>>;

constexpr int pct(int x) { return __builtin_popcount(x); } // # of bits set
constexpr int bits(int x) { return x == 0 ? 0 : 31-__builtin_clz(x); } // floor(log2(x)) 
constexpr int p2(int x) { return 1<<x; }
constexpr int msk2(int x) { return p2(x)-1; }
ll cdiv(ll a, ll b) { return a/b+((a^b)>0&&a%b); } // divide a by b rounded up
ll fdiv(ll a, ll b) { return a/b-((a^b)<0&&a%b); } // divide a by b rounded down
tcT> bool ckmin(T& a, const T& b) { return b < a ? a = b, 1 : 0; }
tcT> bool ckmax(T& a, const T& b) { return a < b ? a = b, 1 : 0; }
tcTU> T fstTrue(T lo, T hi, U f) { hi ++; assert(lo <= hi); while (lo < hi) { T mid = lo+(hi-lo)/2; f(mid) ? hi = mid : lo = mid+1; } return lo; }
tcTU> T lstTrue(T lo, T hi, U f) { lo --; assert(lo <= hi); while (lo < hi) { T mid = lo+(hi-lo+1)/2; f(mid) ? lo = mid : hi = mid-1; } return lo; }
tcT> void remDup(vector<T>& v) { sort(all(v)); v.erase(unique(all(v)),end(v)); }
tcTU> void erase(T& t, const U& u) { auto it = t.find(u); assert(it != end(t)); t.erase(it); } 

int ans = 1;
vi vis;
vi G[1000030];
int color[2][1000030],val[2][1000030];

int can = 0,cs[2];
vi cC[2],cS[2][2];

void dfs(int num,int ccol = 2){
	if(vis[num]){
		if(vis[num]!=ccol)can = 0;
		return;
	}
	vis[num] = ccol;
	F0R(i,2){
		cC[i].pb(val[i][num]);
		cs[i]^=color[i][num];
		cS[i][(ccol-2)^color[i][num]].pb(val[i][num]);
	}
	each(ct,G[num])dfs(ct,ccol^1);
}
void solve(){
	ans = 1;
	int n,m;cin>>n>>m;
	vis.clear();vis.rsz(n+10,0);
	F0R(i,n+5)G[i].clear();
	F0R(i,m){
		int u,v;cin>>u>>v;
		G[u].pb(v);
		G[v].pb(u);
	}
	F0R(j,2){
		FOR(i,1,n+1)cin>>val[j][i];
		FOR(i,1,n+1){char ch;cin>>ch;color[j][i] = (ch == 'R');}
	}
	FOR(i,1,n+1){
		if(!vis[i]){
			F0R(j,2){
				cs[j] = 0;cC[j].clear();cS[0][j].clear();cS[1][j].clear();
			}
			can = 1;
			dfs(i);
			sor(cC[0]);sor(cC[1]);sor(cS[0][0]);sor(cS[1][0]);sor(cS[0][1]);sor(cS[1][1]);
			if(cC[0]!=cC[1])ans = 0;
			if(can && (cS[0][0]!=cS[1][0] || cS[0][1]!=cS[1][1]))ans = 0;
			if(!can && cs[0]!=cs[1])ans = 0;
		}
	}
	if(ans){
		puts("YES");
	}else{
		puts("NO");
	}
}

int main() {
	ios::sync_with_stdio(false);
	int t;cin>>t;
	while(t--){
		solve();
	}
	// END OF CODE
	return 0;
}