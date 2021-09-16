#include<bits/stdc++.h>
using namespace std;
typedef long long LL;
typedef double DB;
const int N = 55;
const int M = 15;
const int MO = 998244353;
void ad(int&x,int y){
	x+=y;
	if(x>=MO)
		x-=MO;
}
int mul(int x,int y){
	return (LL)x*y%MO;
}
int n,m,a[N][N];
int b[M],f[M];
LL geth(){
	int i;
	LL h=0;
	for(i=1;i<=m;i++)
		h=h*2+b[i];
	for(i=1;i<=m;i++)
		h=h*16+f[i];
	if(f[f[f[f[m]-1]-1]-1]>1)
		return -1;
	return h;
}
void getbf(LL h){
	int i;
	for(i=m;i>=1;i--)
		f[i]=h&15,h>>=4;
	for(i=m;i>=1;i--)
		b[i]=h&1,h>>=1;
}
map<LL,int> mp;
vector<pair<LL,int> > v[2];
void dfs(int k){
	if(k==m+1){
		LL h=geth();
		if(h>=0)
		    v[0].push_back(make_pair(h,1));
		return;
	}
	int i;
	for(i=0;i<2;i++){
		if(a[1][k]>=0&&a[1][k]!=i)
			continue;
		b[k]=i;
		if(k==1||b[k]!=b[k-1])
			f[k]=k;
		else
			f[k]=f[k-1];
		dfs(k+1);
	}
}
LL nx(LL h,int t,int e){
	int i,x,y;
	getbf(h);
	if(b[t]==e){
		if(t==1)
			return h;
		if(f[t]==f[t-1])
			return -1;
		if(b[t]==b[t-1]){
			x=min(f[t],f[t-1]);
			y=max(f[t],f[t-1]);
			for(i=1;i<=m;i++)
				if(f[i]==y)
					f[i]=x;
		}
		return geth();
	}
	x=0;
	for(i=1;i<=m;i++)
		if(i!=t&&f[i]==f[t]){
			x=i;
			break;
		}
	if(!x)
		return -1;
	y=f[t];
	for(i=1;i<=m;i++)
		if(f[i]==y)
			f[i]=x;
	b[t]=e;
	f[t]=t;
	if(t!=1&&b[t]==b[t-1])
		f[t]=f[t-1];
	return geth();
}
void go(int i,int a){
	int j;
	LL x,y;
	for(j=0;j<v[0].size();j++){
		x=v[0][j].first;
		if(a!=1){
			y=nx(x,i,0);
			if(y>=0)
				v[1].push_back(make_pair(y,v[0][j].second));
		}
		if(a!=0){
			y=nx(x,i,1);
			if(y>=0)
				v[1].push_back(make_pair(y,v[0][j].second));
		}
	}
	v[0].clear();
	sort(v[1].begin(),v[1].end());
	x=-1;
	j=-1;
	for(i=0;i<v[1].size();i++){
		if(v[1][i].first==x)
			ad(v[0][j].second,v[1][i].second);
		else{
			v[0].push_back(v[1][i]);
			x=v[1][i].first;
			j++;
		}
	}
	v[1].clear();
}
int cal(LL h,int a1,int a2){
	int i,o=0;
	getbf(h);
	if(b[m-2]==b[m-1]&&b[m-1]==b[m])
		return 0;
	if(b[m-1]==b[m]){
		for(i=1;i<m-2;i++){
			if(b[i]==b[m]){
				if(f[i]!=f[m])
					return 0;
			}
			else{
				if(f[i]!=f[m-2])
					return 0;
			}
		}
		if(a1!=b[m]&&a2!=b[m])
			o++;
		if(a1!=b[m]&&a2!=b[m-2])
			o++;
		return o;
	}
	if(b[m-2]==b[m-1]){
		if(f[m-2]==f[m-1]){
			for(i=1;i<m-2;i++){
				if(b[i]==b[m]){
					if(f[i]!=f[m])
						return 0;
				}
				else{
					if(f[i]!=f[m-2])
						return 0;
				}
			}
			if(a1!=b[m-2]&&a2!=b[m-2])
				o++;
			return o;
		}
		for(i=1;i<m-2;i++){
			if(b[i]==b[m]){
				if(f[i]!=f[m])
					return 0;
			}
			else{
				if(f[i]!=f[m-2]&&f[i]!=f[m-1])
					return 0;
			}
		}
		if(a1!=b[m]&&a2!=b[m])
			o++;
		if(a1!=b[m]&&a2!=b[m-2])
			o++;
		return o;
	}
	if(f[m-2]==f[m]){
		for(i=1;i<m-2;i++){
			if(b[i]==b[m]){
				if(f[i]!=f[m])
					return 0;
			}
			else{
				if(f[i]!=f[m-1])
					return 0;
			}
		}
		if(a1!=b[m-1]&&a2!=b[m-1])
			o++;
		if(a1!=b[m]&&a2!=b[m-1])
			o++;
		if(a1!=b[m]&&a2!=b[m])
			o++;
		return o;
	}
	for(i=1;i<m-2;i++){
		if(b[i]==b[m]){
			if(f[i]!=f[m]&&f[i]!=f[m-2])
				return 0;
		}
		else{
			if(f[i]!=f[m-1])
				return 0;
		}
	}
	if(a1!=b[m-1]&&a2!=b[m-1])
		o++;
	return o;
}
int main()
{
	//freopen("input.txt","r",stdin);
	//freopen("std2.out","w",stdout);
	int T,i,j,s;
	scanf("%d",&T);
	while(T--){
		scanf("%d%d",&n,&m);
		for(i=1;i<=n;i++){
			for(j=1;j<=m;j++){
				scanf("%d",a[i]+j);
			}
		}
		if(n<m){
			for(i=1;i<=m;i++)
				for(j=i+1;j<=m;j++)
					swap(a[i][j],a[j][i]);
			swap(n,m);
		}
		v[0].clear();
		dfs(1);
		for(i=2;i<n;i++){
			for(j=1;j<=m;j++){
				go(j,a[i][j]);
			}
		}
		for(j=1;j<=m-2;j++)
			go(j,a[n][j]);
		s=0;
		for(i=0;i<v[0].size();i++)
			ad(s,mul(cal(v[0][i].first,a[n][m-1],a[n][m]),v[0][i].second));
		printf("%d\n",s);
	}
	return 0;
}
