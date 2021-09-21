#include<bits/stdc++.h>
using namespace std;
map<int,int>pos;
vector<map<int,int> >f;
int T,n,q;
const int inf=2e9;
void init()
{
	pos.clear();
	vector<map<int,int> >().swap(f);
}
int ins(int x,int y,int z)
{
	map<int,int>::iterator it;
	it=pos.find(x+y);
	if(it==pos.end())
	{
		f.push_back(map<int,int>());
		pos[x+y]=f.size()-1;	
	}
	int idx=pos[x+y];
	it=f[idx].find(x);
	int ok=0;
	if(it==f[idx].end())f[idx][x]=z,ok=1;
	else if(it->second==-1)it->second=z;
	else return it->second;
	if(ok)return -1;
	else return -2;
}
int ask(int x,int y)
{
	int res=ins(x,y,-1);
	if(res>=0)return res;
	if(y-x+1<=2)res=-2;
	map<int,int>::iterator it;
	int ans;
	if(res==-1)
	{	
		int bk=(x+y)/2,pre=inf;	
		int idx=pos[x+y];
		it=f[idx].upper_bound(x);
		if(it!=f[idx].end())pre=it->first;
		bk=min(bk,pre);
		ans=ask(bk,y-(bk-x));
	}
	else
	{
		if(x==y)ans=0;
		else ans=!(ask(x+1,y)&ask(x,y-1));
	}
	ins(x,y,ans);
	return ans;
}
int main()
{
	scanf("%d",&T);
	while(T--)
	{
		int cnt0=0,cnt1=0;
		scanf("%d%d",&n,&q);
		init();
		for(int i=1;i<=n;i++)
		{
			int x,y,z;
			scanf("%d%d%d",&x,&y,&z);
			ins(x,y,z);
			for(int j=0;j<3;j++)for(int k=0;k<3;k++)
			{
				if(j==k&&j!=1)continue;
				if(x-j<1)continue;
				ins(x-j,y+k,-1);
			}
		}
		for(int i=1;i<=q;i++)
		{
			int x,y,tmp;
			scanf("%d%d",&x,&y);
			//tmp=ask(x,y);
			if(tmp==0)cnt0++;
			else cnt1++;
			printf("%d",ask(x,y));
		}
		printf("\n");
	//	int sum=0;
	//for(int i=0;i<f.size();i++)sum+=f[i].size();
		//printf("%d %d %d\n",cnt0,cnt1,sum);
		
	}	
	return 0;
}
