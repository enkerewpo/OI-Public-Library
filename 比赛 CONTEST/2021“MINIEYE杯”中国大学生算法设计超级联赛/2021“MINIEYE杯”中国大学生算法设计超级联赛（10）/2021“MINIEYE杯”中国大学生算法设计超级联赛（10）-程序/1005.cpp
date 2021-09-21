#include<bits/stdc++.h>
#define fo(i,a,b)for(int i=a,_e=b;i<=_e;++i)
#define fd(i,a,b)for(int i=b,_e=a;i>=_e;--i)
#define ll long long
using namespace std;
const int N=1e6+5,M=6,mo=1e9+7;
int T;
int k=5,_n,n,m,w,pos,ts;
int s[N][26],fail[N],fa[N],d[N],len[N],ch[N];
ll sum[N],sum2[N],ad[N],jc[M],ny[M];
ll ans,tot[N][M],fail_tot[N][M],a[M],b[M];
char c[N];
int power(int x,int y){
	int t=1;
	for(;y;y>>=1,x=(ll)x*x%mo)if(y&1)t=(ll)t*x%mo;
	return t;
}
int main(){
	jc[0]=1;
	fo(i,1,k)jc[i]=jc[i-1]*i%mo;
	ny[k]=power(jc[k],mo-2);
	fd(i,0,k-1)ny[i]=ny[i+1]*(i+1)%mo;
	for(scanf("%d",&T);T--;){
		memset(s,0,sizeof s);
		memset(ad,0,sizeof ad);
		scanf("%s",c+1);
		_n=n=strlen(c+1);ts=1;
		int j=1;
		fo(i,1,n){
			if(!s[j][c[i]-'a'])s[j][c[i]-'a']=++ts,len[ts]=i,fa[ts]=j,ch[ts]=c[i]-'a';
			j=s[j][c[i]-'a'];
		}
		scanf("%d",&m);
		fo(o,1,m){
			scanf("\n%s %d",c+1,&w);
			n=strlen(c+1);
			j=1;
			fo(i,1,n){
				if(!s[j][c[i]-'a'])s[j][c[i]-'a']=++ts,len[ts]=i,fa[ts]=j,ch[ts]=c[i]-'a';
				j=s[j][c[i]-'a'];
			}
			ad[j]=(ad[j]+w)%mo;
		}
		fo(i,0,25)s[0][i]=1;
		d[1]=1;
		for(int l=0,r=1,x;x=d[++l],l<=r;)
			fo(i,0,25)if(s[x][i]){
				int y=s[x][i],z=fail[x];
				d[++r]=y;
				for(;!s[z][i];)z=fail[z];
				fail[y]=s[z][i];
				sum[y]=(sum[fail[y]]+ad[y])%mo;
				sum2[y]=(sum[y]+sum2[x])%mo;
			}
		fo(i,2,ts){
			int x=d[i],xx=fail[x],y=fa[x],z=fail[y];
			fo(j,0,k)
				fail_tot[x][j]=fail_tot[y][j];
			
			if(xx==1)
				fail_tot[x][0]=(fail_tot[x][0]+1)%mo;
			
			for(;!s[z][ch[x]];z=fail[z])
				fo(j,0,k)
					fail_tot[x][j]=(fail_tot[x][j]+fail_tot[z][j])%mo;
			
			a[0]=1;
			fo(j,1,k)a[j]=a[j-1]*sum[xx]%mo;
			fo(j,1,k)a[j]=a[j]*ny[j]%mo;
			fo(j,0,k){
				b[j]=0;
				fo(l,0,j)b[j]=(b[j]+a[l]*fail_tot[x][j-l])%mo;
			}
			fo(j,0,k)fail_tot[x][j]=b[j];
			
			ll xs=1,xs2=1;
			fo(j,0,k){
				fail_tot[x][j]=(fail_tot[x][j]+(xs2+mo-xs)*ny[j])%mo;
				xs=xs*(sum2[y]+sum[xx])%mo;
				xs2=xs2*sum2[x]%mo;
			}
			fo(j,0,k)tot[x][j]=(tot[xx][j]+fail_tot[x][j])%mo;
		}
		ans=0;
		fo(i,2,_n+1)ans=(ans+tot[i][k])%mo;
		printf("%lld\n",ans*jc[k]%mo);	
	}
}
