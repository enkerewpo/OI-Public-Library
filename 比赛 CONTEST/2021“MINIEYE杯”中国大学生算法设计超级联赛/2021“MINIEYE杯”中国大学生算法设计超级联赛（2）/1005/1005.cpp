#include<bits/stdc++.h>
#define N 1000009
using namespace std;
typedef long long ll;
const int mod=1e9+7;
int n;
char s[N];
inline ll rd(){
	ll x=0;char c=getchar();bool f=0;
	while(!isdigit(c)){if(c=='-')f=1;c=getchar();}
	while(isdigit(c)){x=(x<<1)+(x<<3)+(c^48);c=getchar();}
	return f?-x:x;
}
int main(){
	int T=rd();
	while(T--){
		n=rd();
		scanf("%s",s+1);int ans=1;
		for(int i=2;i<=n;++i)if(s[i]==s[i-1])ans=ans*2%mod;else break;
		cout<<ans<<endl; 
	}
	return 0;
}

