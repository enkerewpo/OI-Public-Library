#include<stdio.h>
#include<string.h>
#include<time.h>

const int MAXL		=	2*1024*1024+10;
const int BLOCKSIZE	=	20000;
const int MAXBLOCK	=	MAXL/BLOCKSIZE*2+100;

int min(int a,int b){return a<b?a:b;}

int freelist[MAXBLOCK];
int freepos;

int newnode(){
	return freelist[freepos++];
}
void delnode(int t){
	freelist[--freepos]=t;
}

char data[MAXBLOCK][BLOCKSIZE];
int count[MAXBLOCK];
int next[MAXBLOCK];

void find(int &p,int &b){
	for(b=0; b!=-1 && p>count[b]; b=next[b])p-=count[b];
}
void fillblock(int b,int n,char str[],int e){
	if(b==-1)return;
	next[b]=e;
	count[b]=n;
	memcpy(data[b], str, n);
}
void splite(int b,int p){
	if(b==-1 || p==count[b])return;
	int t=newnode();
	fillblock(t, count[b]-p, data[b]+p, next[b]);
	next[b]=t;
	count[b]=p;
}
void maintainlist(int b){
	for(; b!=-1; b=next[b])
		for(int t=next[b]; t!=-1 && count[b] + count[t] <= BLOCKSIZE; t=next[b]){
			memcpy(data[b]+count[b], data[t], count[t]);
			count[b]+=count[t];
			next[b]=next[t];
			delnode(t);
		}
}
void insert(int p,int n,char str[]){
	int b,t,i;
	find(p,b);
	splite(b,p);
	for(i=0; i+BLOCKSIZE <= n; i+=BLOCKSIZE){
		t=newnode();
		fillblock(t, BLOCKSIZE, str+i, next[b]);
		next[b]=t;
		b=t;
	}
	if(n-i){
		t=newnode();
		fillblock(t, n-i, str+i, next[b]);
		next[b]=t;
	}
	maintainlist(b);
}
void erase(int p,int n){
	int b,e;
	find(p,b);
	splite(b,p);
	for(e=next[b]; e!=-1 && n>count[e]; e=next[e])n-=count[e];
	splite(e,n);
	e=next[e];
	for(int t=next[b]; t!=e; t=next[b]){
		next[b]=next[t];
		delnode(t);
	}
	maintainlist(b);
}
void get(int p,int n,char str[]){
	int b,t,i;
	find(p,b);
	i=min(n, count[b]-p);
	memcpy(str, data[b]+p, i);
	for(t=next[b]; t!=-1 && i + count[t] <= n; i+=count[t],t=next[t])
		memcpy(str+i, data[t], count[t]);
	if(n-i && t!=-1)memcpy(str+i, data[t], n-i);
	str[n]='\0';
}
void init(){
	freopen("editor.in","r",stdin);
	freopen("editor.out","w",stdout);
	for(int i=1; i<MAXBLOCK; ++i)freelist[i]=i;
	freepos=1;
	next[0]=-1;
	count[0]=0;
}
char str[MAXL];
int cur=0;
void solve(){
	int t,k,n;char order[10],c;
	scanf("%d",&t);
	for(cur=0; t; --t){
		scanf("%s",order);
		switch(order[0]){
			case 'M':	scanf("%d",&k);cur=k;break;
			case 'I':
				scanf("%d",&n);
				for(int i=0; i<n; ++i){
					scanf("%c",&c);
					str[i]=c;
					if(c<32 || c>126)--i;
				}
				insert(cur, n, str);
				break;
			case 'D':	scanf("%d",&n);erase(cur, n);break;
			case 'G':	scanf("%d",&n);get(cur, n, str);printf("%s\n",str);break;
			case 'P':	--cur;break;
			case 'N':	++cur;break;
		}
	}
	fclose(stdin);
	fclose(stdout);
}
int main(){
	init();
	solve();
	fprintf(stderr, "%.2lf\n", clock()/(double)CLOCKS_PER_SEC);
}
