#include<stdio.h>
#include<string.h>
const int MaxN=265000;
int f[MaxN],last[MaxN],head[MaxN],next[MaxN];
int r[MaxN],p[MaxN],a[MaxN*4];
bool used[MaxN];
int n,m,z;

void init(){
	//freopen("2131.in","r",stdin);
	//freopen("2131.out","w",stdout);
	scanf("%d%d",&m,&n);
	for(int i=0;i<m;++i)scanf("%d",&p[i]);
	n+=m;
}
inline void use(int x,int p){
	used[x]=true;
	f[x]=x;
	head[x]=last[p]=p;
	next[p]=0;
}
int find(int x){
	if(x==f[x])return x;
	return f[x]=find(f[x]);
}
void uni(int i,int j){
	i=find(i);
	j=find(j);
	if(i==j)return;
	next[last[head[j]]]=head[i];
	last[head[j]]=last[head[i]];
	f[i]=j;
}
void inittree(){
	for(z=1;z<n;z=z<<1);z<<=1;
	for(int i=z>>1;i<z;++i)a[i]=1;
	for(int i=(z>>1)-1;i;--i)a[i]=a[i+i]+a[i+i+1];
}
int remove(int p){
	int i=1;
	while(i<z){
		if(p<=a[i]){
			--a[i];
			i=i+i;
		}else{
			p-=a[i];
			i=i+i+1;
		}
	}
	return i-z+1;
}
void solve(){
	int i,j,x;
	for(i=1;i<=n;++i){f[i]=i-1;used[i]=false;}
	for(i=0;i<m;++i){
		if(used[p[i]]){
			x=find(p[i]);
			use(x+1,i+1);
			uni(x,x+1);
			if(used[x+2])uni(x+1,x+2);
		}else{
			use(p[i],i+1);
			uni(p[i],p[i]+1);
			if(used[p[i]-1])uni(p[i]-1,p[i]);
		}
	}
	inittree();
	memset(r,0,sizeof(r));
	for(i=n;i>0;--i){
		if(used[i]){
			for(j=head[find(i)];j;j=next[j])
				r[remove(p[j-1])]=j;
			while(used[i] && i)--i;
		}
	}
	
	for(i=n;i;--i)if(r[i])break;
	printf("%d\n",i);
	for(j=1;j<=i;++j){
		if(j>1)printf(" ");
		printf("%d",r[j]);
	}
	printf("\n");
}
int main(){
	init();
	solve();
}
