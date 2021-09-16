#include<bits/stdc++.h>
using namespace std;
int L,R,T,n,a[1000005],r[1000005],seq[1000005],vis[1000005];
multiset<int>st;
multiset<int>::iterator it;
int main()
{
	//freopen("1010t.in","r",stdin);
	//freopen("1010t.out","w",stdout);
	scanf("%d",&T);
	while(T--)
	{
		st.clear();
		scanf("%d",&n);
		for(int i=0;i<=n+2;i++)r[i]=seq[i]=vis[i]=0;
		a[n+1]=n+1;
		for(int i=1;i<=n;i++)scanf("%d",&a[i]),vis[a[i]]|=1;
		for(int i=1;i<=n;i++)if(a[i]<i)goto tag;
		if(a[1]==n+1)goto tag;
		for(int i=1;i<=n;i++)if(a[i]<a[i+1])vis[i]|=2;
		a[0]=a[1];
		for(int i=1;i<=a[0];i++)r[i]=0;
		for(int i=1;i<=n+1;i++)for(int j=a[i-1]+1;j<=a[i];j++)r[j]=i;
		for(int i=1;i<=a[0];i++)st.insert(0);
		L=R=1;
		for(int i=1;i<=n;i++)
		{
			//printf("%d %d %d %d %d %d\n",i,st.size(),seq[L],r[i],L,R);
			if(!(vis[i]&1))
			{
				if(L==R)
				{
					//printf("!%d %d\n",st.empty(),r[i]);
					while(!st.empty()&&*st.begin()<r[i])st.erase(st.begin());
					if(!st.empty())st.erase(st.begin());
					else goto tag;
				}
				else
				{
					//printf("#%d %d\n",seq[L],r[i]);
					if(seq[L]<r[i])goto tag;
					//L++;
					while(!st.empty()&&*st.begin()<r[i])st.erase(st.begin());
					if(st.empty())L++;
					else
					{
						int tmp=*st.begin();
						st.erase(st.begin());
						st.insert(max(tmp,seq[L]));
						//printf("@@%d\n",max(tmp,seq[L]));
						L++;
					}
				}
			}
			if(!(vis[i]&2))seq[R++]=i;
		}
		if(L<R&&seq[L]<r[n+1])goto tag;
		printf("YES\n");
		continue;
		tag:printf("NO\n");
		
	}
	return 0;
}
