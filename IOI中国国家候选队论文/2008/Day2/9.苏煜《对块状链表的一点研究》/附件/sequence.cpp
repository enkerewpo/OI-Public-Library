#include<stdio.h>
#include<string.h>

const int oo		=	2000000000;
const int BLOCKSIZE	=	700;
const int MAXL		=	500000+10;
const int MAXBLOCK	=	MAXL/BLOCKSIZE*2+1000;

void swap(int &a,int &b){a^=b;b^=a;a^=b;}
int max(int a,int b){return a>b?a:b;}
int min(int a,int b){return a<b?a:b;}

int data[MAXBLOCK][BLOCKSIZE];
int count[MAXBLOCK];
int samevalue[MAXBLOCK];
int totsum[MAXBLOCK];
int sidemax[MAXBLOCK][2];
int maxsum[MAXBLOCK];
bool same[MAXBLOCK];
bool reversed[MAXBLOCK];
int next[MAXBLOCK];

int freelist[MAXBLOCK];
int freepos;

int newnode(){
	return freelist[freepos++];
}
#define delnode(t){freelist[--freepos]=t;}

void find(int &p,int &b){
	for(b=0; p> count[b]; b=next[b])
		p-=count[b];
}
void maintainblock(int b){
	if(same[b]){
		totsum[b]=samevalue[b] * count[b];
		if(samevalue[b]>0)maxsum[b]=totsum[b];
		else maxsum[b]=samevalue[b];
		sidemax[b][0]=sidemax[b][1]=maxsum[b];
	}else{
		totsum[b]=0;maxsum[b]=-oo;
		for(int last=0,i=count[b]-1; i>=0; --i){
			totsum[b] += data[b][i];
			last += data[b][i];
			if(maxsum[b] < last)maxsum[b]=last;
			if(last < 0)last=0;
		}
		sidemax[b][0]=-oo;
		for(int last=0,i=0; i<count[b]; ++i){
			last += data[b][i];
			if(sidemax[b][0] < last)sidemax[b][0] = last;
		}
		sidemax[b][1]=-oo;
		for(int last=0,i=count[b]-1; i>=0; --i){
			last += data[b][i];
			if(sidemax[b][1] < last)sidemax[b][1] = last;
		}
	}
}
void reverseblock(int b){
	if(b==-1 || !reversed[b])return;
	reversed[b]=false;
	if(same[b])return;
	for(int l=0,r =count[b]-1; l<r; ++l,--r)swap(data[b][l], data[b][r]);
	swap(sidemax[b][0], sidemax[b][1]);
}
void maintainlist(int b){
	for(bool x=false; b!=-1; b=next[b],x=false){
		for(int t=next[b]; t!=-1 && count[b] + count[t] <= BLOCKSIZE; t=next[b],x=true){
			if( !(same[b] && same[t] && samevalue[b]==samevalue[t]) ){
				reverseblock(b);
				reverseblock(t);
				if(same[b])for(int i=0; i<count[b]; ++i)data[b][i]=samevalue[b];
				for(int i=0; i<count[t]; ++i)
					data[b][count[b]+i] = same[t] ? samevalue[t] : data[t][i];
				same[b]=false;
			}
			count[b]+=count[t];
			next[b]=next[t];
			delnode(t);
		}
		if(x)maintainblock(b);
	}
}
void fillblock(int b,int sv,int n,int e){
	same[b]=true;
	samevalue[b]=sv;
	next[b]=e;
	count[b]=n;
	reversed[b]=false;
	maintainblock(b);
}
void fillblock(int b,int str[],int n,int e){
	same[b]=reversed[b]=false;
	count[b]=n;
	next[b]=e;
	memcpy(data[b], str, n*sizeof(int));
	maintainblock(b);
}
void splite(int b,int p){
	if(b==-1 || count[b] == p)return;
	int t=newnode();
	reverseblock(b);
	if(same[b])fillblock(t, samevalue[b], count[b]-p, next[b]);
	else	fillblock(t, data[b]+p, count[b]-p, next[b]);
	next[b]=t;
	count[b]=p;
	maintainblock(b);
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
		fillblock(t=newnode(), str+i, n-i, next[b]);
		next[b]=t;
	}
	maintainlist(next[b]);
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
}
int list[MAXBLOCK];
void reverse(int p,int n){
	int b,e,i,t;
	find(p,b);
	splite(b,p);
	for(e=next[b]; n>count[e]; e=next[e])n-=count[e];
	splite(e,n);
	e=next[e];
	for(i=0,t=next[b]; t!=e; t=next[t],++i)list[i]=t;
	next[b]=list[--i];
	for(; i>=0; --i){
		next[list[i]] = i ? list[i-1] : t;
		reversed[list[i]] = ! reversed[list[i]];
	}
	maintainlist(b);
}
void makesame(int p,int n,int v){
	int b,t;
	find(p,b);
	splite(b,p);
	for(t=next[b]; n>count[t]; n -= count[t],t=next[t])
		fillblock(t, v, count[t], next[t]);
	if(n){
		splite(t,n);
		fillblock(t, v, n, next[t]);
	}
	maintainlist(b);
}
int getsum_in_block(int b,int p,int n){
	int sum,l,r;
	if(same[b])return samevalue[b] * n;
	if(reversed[b]){l = count[b] - p - n;	r = count[b] - p - 1;}
	else {l = p;	r = p + n - 1;}
	for(sum=0; l<=r; ++l)sum+=data[b][l];
	return sum;
}
void getsum(int p,int n){
	int b,t;
	find(p, b);
	int sum,i;
	sum=getsum_in_block(b, p, min(n, count[b] - p));
	n -= min(n, count[b] - p);
	for(t=next[b]; n>count[t]; t=next[t]){
		sum+=totsum[t];
		n-=count[t];
	}
	sum+=getsum_in_block(t, 0, n);
	printf("%d\n",sum);
}
void getmaxsum(){
	int res=-oo,last=0;
	for(int b=0; b!=-1; b=next[b]){
		res = max(res, last+sidemax[b][reversed[b]]);
		res = max(res, maxsum[b]);
		last= max(last+totsum[b], sidemax[b][!reversed[b]]);
		last= max(last, 0);
	}
	printf("%d\n",res);
}
void init(){
	freopen("sequence.in","r",stdin);
	freopen("sequence.out","w",stdout);
	for(int i=1; i<MAXBLOCK; ++i)freelist[i]=i;
	freepos=1;
	count[0]=0;
	next[0]=-1;
	same[0]=reversed[0]=false;
}
int tstr[MAXL];
int main(){
	int n,m,i,s,p,v;
	char order[10];
	init();
	scanf("%d%d",&n,&m);
	for(i=0; i<n; ++i)scanf("%d",tstr+i);
	insert(0, n, tstr);
	for(s=0; s<m; ++s){
		scanf("%s",order);
		if(order[2]=='X')getmaxsum();
		else switch(order[0]){
		case 'I':
			scanf("%d%d",&p,&n);
			for(i=0;i<n;++i)scanf("%d",tstr+i);
			insert(p, n, tstr);
			break;
		case 'D':
			scanf("%d%d",&p,&n);
			erase(p-1, n);
			break;
		case 'M':
			scanf("%d%d%d",&p,&n,&v);
			makesame(p-1, n ,v);
			break;
		case 'R':
			scanf("%d%d",&p,&n);
			reverse(p-1, n);
			break;
		case 'G':
			scanf("%d%d",&p,&n);
			getsum(p-1, n);
			break;
		}
	}
	fclose(stdin);
	fclose(stdout);
}
