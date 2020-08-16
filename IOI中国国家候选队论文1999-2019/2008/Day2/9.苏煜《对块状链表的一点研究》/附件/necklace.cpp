#include<stdio.h>
#include<string.h>

const int BLOCKSIZE	=	800;
const int MAXL		=	500000+10;
const int MAXBLOCK	=	MAXL/BLOCKSIZE*2+100;

inline void swap(int &a,int &b){a^=b;b^=a;a^=b;}
inline int min(int a,int b){return a<b?a:b;}

int freelist[MAXBLOCK];
int freepos;

inline int newnode(){return freelist[freepos++];}
inline void delnode(int t){freelist[--freepos]=t;}

int data[MAXBLOCK][BLOCKSIZE];
int count[MAXBLOCK];
int account[MAXBLOCK];
int side[MAXBLOCK][2];
int samevalue[MAXBLOCK];
int next[MAXBLOCK];
bool same[MAXBLOCK];
bool reversed[MAXBLOCK];

void reverseblock(int b){
	if(b==-1 || !reversed[b])return;
	reversed[b]=false;
	if(same[b])return;
	for(int l=0,r=count[b]-1; l<r; ++l,--r)swap(data[b][l], data[b][r]);
	swap(side[b][0], side[b][1]);
}
void maintainblock(int b){
	if(count[b]==0)return;
	if(same[b]){
		account[b]=!!count[b];
		side[b][0]=side[b][1]=samevalue[b];
	}else{
		int *str=data[b];
		account[b]=!!count[b];
		for(int i=count[b]-1; i>0; --i)if(str[i]!=str[i-1])++account[b];
		side[b][0]=str[0];
		side[b][1]=str[count[b]-1];
	}
}
void maintainlist(int b){
	for(; b!=-1; b=next[b])
		for(int t=next[b]; t!=-1 && count[b]+count[t]<=BLOCKSIZE; t=next[b]){
			if( !(same[b] && same[t] && samevalue[b]==samevalue[t]) ){
				reverseblock(b);
				reverseblock(t);
				if(same[b])for(int i=count[b]-1; i>=0; --i)data[b][i]=samevalue[b];
				same[b]=false;
				int cb=count[b],*str=data[b];
				if(same[t])for(int i=count[t]-1,sv=samevalue[t];i>=0;--i)str[cb+i]=sv;
				else for(int i=count[t]-1,*a=data[t];i>=0;--i)str[cb+i]=a[i];
			}
			count[b]+=count[t];
			next[b]=next[t];
			delnode(t);
			maintainblock(b);
		}
}
void find(int &p,int &b){
	for(b=0; b!=-1 && p>count[b]; b=next[b])
		p-=count[b];
}
void fillblock(int b,int n,int str[],int e){
	next[b]=e;
	count[b]=n;
	memcpy(data[b], str, n*sizeof(int));
	same[b]=reversed[b]=false;
	maintainblock(b);
}
void fillblock(int b,int n,int v,int e){
	next[b]=e;
	count[b]=n;
	same[b]=true;
	samevalue[b]=v;
	reversed[b]=false;
	maintainblock(b);
}
void splite(int b,int p){
	if(b==-1 || count[b]==p)return;
	int t=newnode();
	reverseblock(b);
	if(same[b])	fillblock(t, count[b]-p, samevalue[b], 	next[b]);
	else		fillblock(t, count[b]-p, data[b]+p, 	next[b]);
	count[b]=p;
	next[b]=t;
	maintainblock(b);
}
void insert(int p,int n,int str[]){
	int b,t,i;
	find(p,b);
	splite(b,p);
	for(i=0; i + BLOCKSIZE <= n; i+=BLOCKSIZE){
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
int list[MAXBLOCK];
void reverse(int p,int n){
	int b,i,t;
	find(p,b);
	splite(b,p);
	for(i=0,t=next[b]; n>count[t]; n-=count[t],++i,t=next[t])
		list[i]=t;
	if(n && t!=-1){
		splite(t,n);
		list[i++]=t;
		t=next[t];
	}
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
	for(t=next[b]; t!=-1 && n>count[t];n-=count[t], t=next[t])
		fillblock(t, count[t], v, next[t]);
	if(n && t!=-1){
		splite(t,n);
		fillblock(t, n, v, next[t]);
	}
	maintainlist(b);
}
void listswap(int i,int j){
	if(i==j)return;
	int bb,be,s1,s2;
	find(i,bb);
	while(count[bb]==i){bb=next[bb];i=0;}
	s1=same[bb] ? samevalue[bb] : reversed[bb] ? data[bb][count[bb]-i-1] : data[bb][i];
	find(j,be);
	while(count[be]==j){be=next[be];j=0;}
	s2=same[be] ? samevalue[be] : reversed[be] ? data[be][count[be]-j-1] : data[be][j];
	if(s1==s2)return;
	swap(s1,s2);
	if(same[bb]){for(int i=count[bb]-1; i>=0; --i)data[bb][i]=samevalue[bb];reversed[bb]=false;}
	if(same[be]){for(int i=count[be]-1; i>=0; --i)data[be][i]=samevalue[be];reversed[be]=false;}
	same[bb]=same[be]=false;
	(reversed[bb] ? data[bb][count[bb]-i-1] : data[bb][i]) = s1;
	(reversed[be] ? data[be][count[be]-j-1] : data[be][j]) = s2;
	maintainblock(bb);
	maintainblock(be);
}
int countsegment(int p,int n){
	if(n<=1)return n;
	int b;
	find(p,b);
	while(p==count[b]){b=next[b];p=0;}
	int res=1,i,t,l,r,*str=data[b];
	--n;
	if(!same[b]){
		if(reversed[b]){for(i=count[b]-p-1; i>0 && n>0; --i,--n)if(str[i]!=str[i-1])++res;}
		else{for(i=p+1; n>0 && i<count[b]; ++i,--n)if(str[i]!=str[i-1])++res;}
	}else n-=min(count[b]-p-1, n);
	for(t=b; next[t]!=-1 && n>count[next[t]]; t=next[t]){
		n -= count[next[t]];
		res += account[next[t]];
		if(side[t][!reversed[t]] == side[next[t]][reversed[next[t]]])--res;
	}
	if(n>0){--n;res+=(side[t][!reversed[t]]!=side[next[t]][reversed[next[t]]]);}
	t=next[t];str=data[t];
	if(!same[t]){
		if(reversed[t]){for(i=count[t]-2; i>=0 && n>0; --i,--n)if(str[i]!=str[i+1])++res;}
		else{for(i=1; n>0 && i<count[t]; ++i,--n)if(str[i]!=str[i-1])++res;}
	}
	return res;
}

int tstr[MAXL];
int n,c,q;

void flip(int n){
	reverse(1,n-1);
}
void rotate(int k,int n){
	reverse(0,n);
	reverse(0,k);
	reverse(k,n-k);
}
bool same_head_tail(){
	int b,t1,t2;
	for(b=0; b!=-1 && count[b]==0; b=next[b]);
	t1=side[b][reversed[b]];
	for(; next[b]!=-1; b=next[b]);
	t2=side[b][!reversed[b]];
	return t1==t2;
}
int countcircle(){
	int res=countsegment(0,n);
	if(same_head_tail())--res;
	if(res==0)res=1;
	return res;
}
void init(){
	next[0]=-1;
	count[0]=0;
	for(int i=1;i<MAXBLOCK;++i)freelist[i]=i;
	freepos=1;
	freopen("necklace.in","r",stdin);
	freopen("necklace.out","w",stdout);
	scanf("%d%d",&n,&c);
	for(int i=0;i<n;++i)scanf("%d",tstr+i);
	insert(0, n, tstr);
}
void solve(){
	char order[10];
	int k,i,j,x;
	scanf("%d",&q);
	for(; q; --q){
		scanf("%s",order);
		switch(order[0]){
			case 'R':
				scanf("%d",&k);
				rotate(k,n);
				break;
			case 'F':	
				flip(n);
				break;
			case 'S':
				scanf("%d%d",&i,&j);
				listswap(i-1,j-1);
				break;
			case 'P':
				scanf("%d%d%d",&i,&j,&x);
				if(j>=i)makesame(i-1, j-i+1, x);
				else{
					makesame(0, j, x);
					makesame(i-1, n-i+1, x);
				}
				break;
			case 'C':
				if(order[1]=='S'){
					scanf("%d%d",&i,&j);
					if(j>=i)printf("%d\n",countsegment(i-1, j-i+1));
					else{
						int res=countsegment(i-1, n-i+1);
						res+=countsegment(0,j);
						if(same_head_tail())--res;
						printf("%d\n",res);
					}
				}else	printf("%d\n",countcircle());
		}
	}
	fclose(stdin);
	fclose(stdout);
}
int main(){
	init();
	solve();
}
