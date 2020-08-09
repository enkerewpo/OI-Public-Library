#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#include<time.h>

const int oo		=	2000000000;
const int MAXN		=	100000+10;
const int BLOCKSIZE	=	200;
const int MAXBLOCK	=	MAXN/BLOCKSIZE*2+100;

void swap(int &a,int &b){a^=b;b^=a;a^=b;}
int min(int a,int b){return a<b?a:b;}

int freelist[MAXBLOCK];
int freepos;

int newnode(){
	return freelist[freepos++];
}
void delnode(int t){
	freelist[--freepos]=t;
}


int data[MAXBLOCK][BLOCKSIZE];
int minimum[MAXBLOCK];
int count[MAXBLOCK];
int next[MAXBLOCK];
bool reversed[MAXBLOCK];

void find(int &p,int &b){
	for(b=0; p>count[b]; b=next[b])p-=count[b];
}
void reverseblock(int b){
	if(b==-1 || !reversed[b])return;
	reversed[b]=false;
	for(int l=0,r=count[b]-1; l<r; ++l,--r)swap(data[b][l],data[b][r]);
}
void maintainblock(int b){
	minimum[b]=oo;
	for(int i=count[b]-1; i>=0; --i)
		minimum[b]=min(minimum[b], data[b][i]);
}
void fillblock(int b, int str[], int n, int e){
	next[b]=e;
	count[b]=n;
	memcpy(data[b], str, n*sizeof(int));
	maintainblock(b);
}
void splite(int b,int p){
	if(b==-1 || count[b]==p)return;
	reverseblock(b);
	int t=newnode();
	fillblock(t, data[b]+p, count[b]-p, next[b]);
	count[b]=p;
	next[b]=t;
	maintainblock(b);
}
void maintainlist(int b){
	for(bool x=false; b!=-1; b=next[b],x=false){
		for(int t=next[b]; t!=-1 && count[b] + count[t] <= BLOCKSIZE; t=next[b]){
			x=true;
			next[b]=next[t];
			reverseblock(b);
			reverseblock(t);
			memcpy(data[b]+count[b], data[t], count[t]*sizeof(int));
			count[b]+=count[t];
			delnode(t);
		}
		if(x)maintainblock(b);
	}
}
void insert(int p,int n,int str[]){
	int b,i,t;
	find(p,b);
	splite(b,p);
	for(i=0; i+BLOCKSIZE <= n; i+=BLOCKSIZE){
		t=newnode();
		fillblock(t, str+i, BLOCKSIZE, next[b]);
		next[b]=t;
		b=t;
	}
	if(n-i){
		t=newnode();
		fillblock(t, str+i, n-i, next[b]);
		next[b]=t;
	}
	maintainlist(b);
}
void erase(int p,int n){
	int b,e;
	find(p,b);
	splite(b,p);
	for(e=next[b]; n>count[e]; e=next[e])n-=count[e];
	splite(e,n);
	e=next[e];
	for(int t=next[b]; t!=e; t=next[b]){
		next[b]=next[t];
		delnode(t);
	}
	maintainlist(b);
}
int list[MAXBLOCK];
void reverse(int p,int n){
	int b,e,i,t;
	find(p,b);
	splite(b,p);
	for(e=next[b]; n>count[e]; e=next[e])n-=count[e];
	splite(e,n);
	e=next[e];
	for(t=next[b],i=0; t!=e; ++i,t=next[t])list[i]=t;
	next[b]=list[--i];
	for(; i>=0; --i){
		next[list[i]] = i ? list[i-1] : e;
		reversed[list[i]] = ! reversed[list[i]];
	}
	maintainlist(b);
}
int findnum(int r){
	int n=0,b,i,delta;
	for(b=0; b!=-1 && minimum[b]!=r; b=next[b])n+=count[b];
	if(reversed[b]){i=count[b]-1;delta=-1;}
	else {i=0;delta=1;}
	for(; ; i+=delta,++n)if(data[b][i]==r)break;
	return n+1;
}
void init(){
	for(int i=1; i<MAXBLOCK; ++i)freelist[i]=i;
	freepos=1;
	next[0]=-1;
	count[0]=0;
}

int tstr[MAXN],tstr2[MAXN];
int n;

int cmp(const void *a,const void *b){
	int xa=*((int*)a);
	int xb=*((int*)b);
	if(tstr[xa]!=tstr[xb])return tstr[xa] - tstr[xb];
	return xa - xb;
}
void solve(){
	int i,p;
	for(i=0; i<n; ++i)scanf("%d",tstr+i);
	for(i=0; i<n; ++i)tstr2[i]=i;
	qsort(tstr2, n, sizeof(int), cmp);
	for(i=0; i<n; ++i)tstr[tstr2[i]]=i;
	insert(0, n, tstr);
	for(i=0; i<n; ++i){
		p=findnum(i);
		if(i)printf(" ");
		printf("%d",i+p);
		if(p>1)reverse(0,p);
		erase(0,1);
	}
	printf("\n");
}
int main(){
	while(scanf("%d",&n)==1 && n){
		init();
		solve();
	}
	fprintf(stderr, "%.2lf\n", clock()/(double)CLOCKS_PER_SEC);
}
