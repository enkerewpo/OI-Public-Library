#include<cstdio>
#include<map>
using namespace std;
typedef long long ll;
int Case;ll n,k;map<ll,ll>T;
ll build(ll n){
  if(T.find(n)!=T.end())return T[n];
  if(n<=k)return T[n]=1;
  return T[n]=build(n/2)+build(n-n/2)+1;
}
int main(){
  scanf("%d",&Case);
  while(Case--){
    scanf("%lld%lld",&n,&k);
    T.clear();
    printf("%lld\n",build(n));
  }
}