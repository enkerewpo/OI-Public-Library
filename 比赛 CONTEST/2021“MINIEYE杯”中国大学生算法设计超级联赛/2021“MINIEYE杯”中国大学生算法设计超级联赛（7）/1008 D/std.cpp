#include<bits/stdc++.h>
using std::max;
struct note{
	int x,y;
	friend note operator + (note a1,note a2){
		return {a1.x+a2.x,a1.y+a2.y};
	}
	friend note operator - (note a1,note a2){
		return {a1.x-a2.x,a1.y-a2.y};
	}
}list[200005],rt;

int curdir,n,cnt;
char do_list[2000005];

void get_to_do_list(note tar)
{
	note vec=tar-rt;
	int disf=0,disb=0,disr=0,disl=0;
	if (vec.x>0) {
		if (curdir==0) disr=vec.x;
		if (curdir==1) disf=vec.x;
		if (curdir==2) disl=vec.x;
		if (curdir==3) disb=vec.x;
	}else{
		if (curdir==0) disl=-vec.x;
		if (curdir==1) disb=-vec.x;
		if (curdir==2) disr=-vec.x;
		if (curdir==3) disf=-vec.x;
	}
	if (vec.y>0) {
		if (curdir==0) disf=vec.y;
		if (curdir==1) disl=vec.y;
		if (curdir==2) disb=vec.y;
		if (curdir==3) disr=vec.y;
	}else{
		if (curdir==0) disb=-vec.y;
		if (curdir==1) disr=-vec.y;
		if (curdir==2) disf=-vec.y;
		if (curdir==3) disl=-vec.y;
	}
	if (disf) {
		for (int i=1;i<=disf;i++) do_list[++cnt]='f';
		if (disr) {
			do_list[++cnt]='c';
			curdir=(curdir+1)%4;
			for (int i=1;i<=disr;i++) do_list[++cnt]='f';
		}else{
			do_list[++cnt]='u';
			curdir=(curdir-1+4)%4;
			for (int i=1;i<=disl;i++) do_list[++cnt]='f';
		}
	}else{
		if (disr) {
			do_list[++cnt]='c';
			curdir=(curdir+1)%4;
			for (int i=1;i<=disr;i++) do_list[++cnt]='f';
			do_list[++cnt]='c';
			curdir=(curdir+1)%4;
			for (int i=1;i<=disb;i++) do_list[++cnt]='f';
		}else{
			do_list[++cnt]='u';
			curdir=(curdir-1+4)%4;
			for (int i=1;i<=disl;i++) do_list[++cnt]='f';
			do_list[++cnt]='u';
			curdir=(curdir-1+4)%4;
			for (int i=1;i<=disb;i++) do_list[++cnt]='f';
		}
	}
}
void solve(){
	for (int i=0;i<=cnt+1;i++) do_list[i]='\0';
	cnt=0;
	scanf("%d%d%d",&rt.x,&rt.y,&curdir);
	scanf("%d",&n);
	for (int i=1;i<=n;i++) {
		scanf("%d%d",&list[i].x,&list[i].y);
	}
	for (int i=1;i<=n;i++) {
		get_to_do_list(list[i]);
		rt=list[i];
	}
	puts(do_list+1);
}

int main()
{
	int t;
	scanf("%d",&t);
	while (t--) solve();
}

