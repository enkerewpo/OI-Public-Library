#include<stdio.h>
#include<string.h>

const int MAXL		=	135000;
const int BLOCKSIZE	=	800;
const int MAXBLOCK	=	2*MAXL/BLOCKSIZE*2+100;

int n,m;
int str[MAXL*2];

//node list operation
int freelist[MAXBLOCK];
int freepos;

inline int newnode(){
	return freelist[freepos++];
}
inline void delnode(int t){
	freelist[--freepos]=t;
}

//block list operation
int data[MAXBLOCK][BLOCKSIZE];
int count[MAXBLOCK];
int next[MAXBLOCK];

void find(int &p,int &b){
	for(b=0; b!=-1 && p>count[b]; b=next[b])
		p -= count[b];
}
void maintainlist(int b){
	for(; b!=-1; b=next[b])
		for(int t=next[b]; t!=-1 && count[b] + count[t] <= BLOCKSIZE; t=next[b]){
			memcpy(data[b]+count[b], data[t], count[t]*sizeof(int));
			count[b]+=count[t];
			next[b]=next[t];
			delnode(t);
		}
}
void blockfill(int b,int str[],int n,int e){
	next[b]=e;
	count[b]=n;
	memcpy(data[b], str, n*sizeof(int));
}
void splite(int b,int p){
	if(b==-1 || count[b]==p)return;
	int t = newnode();
	blockfill(t, data[b]+p, count[b]-p, next[b]);
	count[b]= p;
	next[b] = t;
}
void insert(int p,int n,int str[]){
	int b,i,t;
	find(p,b);
	splite(b,p);
	for(i=0; i+BLOCKSIZE <= n; i+=BLOCKSIZE){
		t=newnode();
		blockfill(t, str+i, BLOCKSIZE, next[b]);
		next[b]=t;
		b=t;
	}
	if(n-i){
		t=newnode();
		blockfill(t, str+i, n-i, next[b]);
		next[b]=t;
	}
	maintainlist(b);
}
int erase(int p,int n){
	int b,e;
	find(p,b);
	splite(b,p);
	for(e=next[b]; e!=-1 && n > count[e]; e=next[e])n -= count[e];
	if(n){splite(e,n);e=next[e];}
	for(int t=next[b]; t!=e; t=next[b]){
		next[b]=next[t];
		delnode(t);
	}
	maintainlist(b);
}
int getcount(){
	int sum=0;
	for(int b=0; b!=-1; b=next[b])
		sum+=count[b];
	return sum;
}
int get(){
	for(int b=0,i=0; b!=-1; b=next[b]){
		memcpy(str+i, data[b], count[b]*sizeof(int));
		i+=count[b];
	}
}

//uni-set operation
int nextfree[MAXL];

int root(int x){
	if(x>m || x == nextfree[x])return x;
	return nextfree[x]=root(nextfree[x]);
}

//main
void init(){
	freopen("2131.in","r",stdin);
	freopen("2131.out","w",stdout);
	scanf("%d%d",&n,&m);
	for(int i=m; i>=0 ; --i)nextfree[i]=i;
	for(int i=1; i<MAXBLOCK; ++i)freelist[i]=i;
	freepos=1;
	next[0]=-1;
	count[0]=0;
	memset(str,0,sizeof(str));
	insert(0, m, str);
}
void solve(){
	int s,t,x,i;
	for(s=1; s<=n; ++s){
		scanf("%d",&t);
		x = root(t);
		if(x <= m){
			erase(x-1,1);
			++nextfree[x];
		}
		str[0]=s;
		insert(t-1, 1, str);
	}
	n = getcount();
	get();
	while(n && str[n-1]==0)--n;
	printf("%d\n",n);
	printf("%d",str[0]);
	for(i=1; i<n; ++i)printf(" %d",str[i]);
	printf("\n");
}
int main(){
	init();
	solve();
	return 0;
}

