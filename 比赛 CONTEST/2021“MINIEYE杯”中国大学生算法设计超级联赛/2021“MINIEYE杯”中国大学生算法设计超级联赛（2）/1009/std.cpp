#include<bits/stdc++.h>
using namespace std;
#define LL long long
#define ull unsigned long long
const int N=100000+10;
const int M=100000;
const LL P=998244353;
void add(int &x,int y){
	x+=y;if(x>=P)x-=P;
}

int n,m;
int a[N];
bool is_pri[N+10];
int pri[N],cntp=0;
int c[N];
int g[1050][1050];
void init_pri(){
    for(int i=2;i<=M;++i){
        if(!is_pri[i]) {
            pri[++cntp]=i;
            c[i]=i;
        }
        for(int j=1;j<=cntp&&pri[j]*i<=M;++j){
            is_pri[pri[j]*i]=1;
            c[pri[j]*i]=pri[j];
            if(i%pri[j]==0) {
                break;
            }
        }
    }
}
void init(){
	init_pri();m=sqrt(M);
	for(int j=0;j<=m;++j) g[0][j]=j;
	for(int i=1;i<=m;++i){
		for(int j=0;j<i;++j) g[i][j]=g[j][i];
		g[i][i]=i;
		for(int j=i+1;j<=m;++j){
			g[i][j]=g[i][j-i];
		}
	}
	
//	cout<<pri[600]<<endl;
//	for(int i=2;i*i<=M;++i){
//		for(int j=i*i;j<=M;j+=i*i){
//			vis[j]=1;
//		}
//	}
//	for(int i=sqrt(M)+1;i<=M;++i){
//		if(!is_pri[i]){
//			for(int j=i;j<=M;j+=i){
//				vis[j]=1;
//			}
//		}
//	}
//	int x=0;
//	for(int i=1;i<=M;++i){
//		if(!vis[i]){
//			++x;
//			//cout<<x<<endl;
//		}
//	}
//	cout<<cntp<<endl;
//	cout<<x<<endl;
	return;
}
LL ans;
void dfs(int x,int v1,int v2,int v3){
	if(x==0){
		if(v1<=v2&&v2<=v3){
			if(v1==v2&&v1==v3){
				ans+=(LL)a[v1]*(a[v1]-1)*(a[v1]-2)/(LL)6;
			}
			else if(v2==v3){
				ans+=(LL)a[v2]*(a[v2]-1)/(LL)2*(LL)a[v1];
			}
			else{
				ans+=(LL)a[v1]*a[v2]*a[v3];
			}
		}
		return;
	}
	dfs(x-1,v1,v2,v3);
	if(v3*pri[x]<=M&&v1*pri[x]<=M){
		dfs(x-1,v1*pri[x],v2,v3*pri[x]); 
	}
	if(v3*pri[x]<=M&&v2*pri[x]<=M){
		dfs(x-1,v1,v2*pri[x],v3*pri[x]); 
	}
	if(v1*pri[x]<=M&&v2*pri[x]<=M){
		dfs(x-1,v1*pri[x],v2*pri[x],v3);
	}
	return;
}

void MAIN(){
	int u,v,w,x,y;
	scanf("%d",&n);ans=0;
	memset(a,0,sizeof(a));
	for(int i=1;i<=n;++i){
		scanf("%d",&u);
		v=1;w=1;
		while(u>1){
			w=c[u];x=0;
			while(u%w==0){
				u=u/w;
				++x;
			}
			if(x&1) v=v*w;
		}
		++a[v];
	}
	//cout<<pri[cntp]<<endl;
	int t=1;LL now;
	while(pri[t+1]<=m) ++t;
	dfs(t,1,1,1);
	for(int i=t+1;i<=cntp;++i){
		u=pri[i];
		for(int j=u,v=1;j<=M;j+=u,++v){
			if(!a[j]) continue;
			for(int k=j,w=v;k<=M;k+=u,++w){
				if(!a[k]) continue;
				if(j==k){
					now=(LL)a[j]*(a[j]-1)/(LL)2;
				}
				else{
					now=(LL)a[j]*a[k];
				}
				x=g[v][w];
				y=v*w/x/x;
				if(y>=1&&y<=M){
					ans+=(LL)a[y]*now;
				}
			}
		}
	}
	printf("%lld\n",ans);
	return;
}
int main(){
	init();
	int ttt=1;scanf("%d",&ttt);
	while(ttt--) MAIN();
	return 0;
}

