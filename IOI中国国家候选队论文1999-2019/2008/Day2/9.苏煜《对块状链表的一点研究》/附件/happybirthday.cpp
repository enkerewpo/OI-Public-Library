#include<stdio.h>
#include<string.h>
#include "happybirthday_lib_c.h"
#include "happybirthday_lib_c.cpp"


const int BLOCKSIZE = 1000;
const int MAXL = 500000+10;
const int MAXB = 2*MAXL/BLOCKSIZE+100;

int frcount[MAXL];

int freelist[MAXB];
int freepos;

int newnode(){
	return freelist[freepos++];
}
void delnode(int t){
	freelist[--freepos]=t;
}

int next[MAXB];
int data[MAXB][BLOCKSIZE];
int bcount[MAXB];
int account;

void find(int &p, int &b){
	for(b=0; b!=-1 && p>bcount[b]; b=next[b])
		p -= bcount[b];
}
void fillblock(int b,int str[],int n,int e){
	next[b]=e;
	bcount[b]=n;
	memcpy(data[b], str, n*sizeof(int));
}
void splite(int b,int p){
	if(b==-1 || bcount[b]==p)return;
	int t=newnode();
	fillblock(t, data[b]+p, bcount[b]-p, next[b]);
	next[b]=t;
	bcount[b]=p;
}
void maintainlist(int b){
	int t;
	while(b!=-1 && (t=next[b])!=-1 && bcount[b] + bcount[t] < BLOCKSIZE){
		memcpy(data[b]+bcount[b], data[t], bcount[t]*sizeof(int));
		bcount[b]+=bcount[t];
		next[b]=next[t];
		delnode(t);
	}
}
int rank(int key){
	int b,rank=0,i;
	for(b=0; b!=-1 && next[b]!=-1 && frcount[data[next[b]][0]]<key; b=next[b])
		rank += bcount[b];
	for(i=0; i<bcount[b]; ++i)if(frcount[data[b][i]]>=key)break;
	rank += i-1;
	return rank;
}

int insert(int people){
	int b, p = rank(frcount[people])+1;
	find(p, b);
	if(bcount[b] == BLOCKSIZE){
		splite(b, p);
		if(p==BLOCKSIZE){
			p=0;
			b=next[b];
			if(bcount[b]==BLOCKSIZE)splite(b, p);
		}
	}
	for(int i=bcount[b]; i>p; --i)data[b][i]=data[b][i-1];
	data[b][p]=people;
	++bcount[b];
	++account;
}

int remove(int p){
	int b;
	find(p, b);
	if(p == bcount[b]){
		b=next[b];
		p=0;
	}
	for(int i=p; i<bcount[b]; ++i)data[b][i]=data[b][i+1];
	--bcount[b];
	--account;
	maintainlist(b);
}
int select(int rank){
	int b;
	find(rank, b);
	if(rank==bcount[b]){b=next[b]; rank=0;}
	return data[b][rank];
}
void initlist(){
	for(int i=1; i<MAXB; ++i)freelist[i]=i;
	freepos=1;
	next[0]=-1;
	account=bcount[0]=0;
}

int main(){
	init();
	initlist();
	long n=0,c,lukynumber,r,order;
	bool isboy;
	int people;
	while(getpresent(c,lukynumber,isboy)){
		++n;
		frcount[n]=c;
		insert(n);
		r=rank(c)+1;
		r+=lukynumber*(isboy?1:-1);
		if(r<0||r>=account)tell(-1);
		else{
			people=select(r);
			tell(people);
			remove(r);
			if(--frcount[people])insert(people);
		}
	}
	return 0;
}
