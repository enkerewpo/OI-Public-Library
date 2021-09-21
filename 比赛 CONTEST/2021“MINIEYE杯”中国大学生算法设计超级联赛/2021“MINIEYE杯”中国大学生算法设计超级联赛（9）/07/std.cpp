#include<bits/stdc++.h>
using namespace std;
#define N 10000005
int n,m,x;
char c[5];
struct node {
	int next,last,v,b;
}a[N];
struct A {
	int _size,_start,_end;
	inline void insertl(int x) {
		if (_start) a[_start].last=x;
		a[x].next=_start;
		a[x].last=0;
		_start=x;
		if (!_end) _end=x;
		_size++;
	}
	inline void insertr(int x) {
		if (_end) a[_end].next=x;
		a[x].last=_end;
		a[x].next=0;
		_end=x;
		if (!_start) _start=x;
		_size++;
	}
	inline int popl() {
		if (!_size) return _start=_end=0;
		while (a[_start].v) _start=a[_start].next;
		a[_start].last=0;
		return _start;
	}
	inline int popr() {
		if (!_size) return _start=_end=0;
		while (a[_end].v) _end=a[_end].last;
		a[_end].next=0;
		return _end;
	}
	inline void remover() {
		_size--;
		if (!_size) {
			_start=_end=0;
			return ;
		}
		while (a[_end].v) _end=a[_end].last;
		_end=a[_end].last;
		a[_end].next=0;
	}
	inline void removel() {
		_size--;
		if (!_size) {
			_start=_end=0;
			return ;
		}
		while (a[_start].v) _start=a[_start].next;
		_start=a[_start].next;
		a[_start].last=0;
	}
}L,R;
int main() {
    int C=0,D=0;
	scanf("%d",&m);
	int tot=0;
	for (int i=1;i<=m;i++) {
		scanf("%s",c);
		if (c[0]=='L') {
			++tot;
			a[tot].b=1;
			L.insertl(tot);
		}
		else if (c[0]=='R') {
			++tot;
			a[tot].b=2;
			R.insertr(tot);
		}
		else if (c[0]=='G') {
			int x;
			scanf("%d",&x);
			if (a[x].b==1) L._size--;
			else R._size--;
			a[x].v=1;
			C++;
		}
		else {
			printf("%d\n",R.popl());
			D++;
		}
		if (L._size>R._size) {
			int x=L.popr();
			L.remover();
			a[x].b=2;
			R.insertl(x);
		}
		else if (R._size-1>L._size) {
			int x=R.popl();
			R.removel();
			a[x].b=1;
			L.insertr(x);
		}
	}
	assert(C<=1500000);
	assert(D<=1500000);
	//cout<<C<<' '<<D<<_endl;
}
