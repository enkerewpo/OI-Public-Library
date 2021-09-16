#include <bits/stdc++.h>
#define fo(a,b,c) for (a=b; a<=c; a++)
#define fd(a,b,c) for (a=b; a>=c; a--)
#define min(a,b) (a<b?a:b)
#define mod 998244353
#define ll long long
//#define file
using namespace std;

int f[490000],n,m,i,j,k,l;
int ask[1000];
int main() {
	int T = 0;
	for(cin>>T;T;T--){
		scanf("%d",&n);
		ask[n]=1;
	}
	memset(f,127,sizeof(f)),f[0]=0;
	m=700*700/2;
	fo(j,1,n)
	{
		fo(i,0,m-1)
		{
			k=i+j*(j-1)/2;
			if (k<=m)
				f[k]=min(f[k],f[i]+j);
		}

		if(ask[j]) {
			int mm=j*(j-1)/2;
			fo(i,0,mm)
				if (f[mm-i]<=j)
					printf("%d ",i);
		printf("\n");
		}
	}
	
}