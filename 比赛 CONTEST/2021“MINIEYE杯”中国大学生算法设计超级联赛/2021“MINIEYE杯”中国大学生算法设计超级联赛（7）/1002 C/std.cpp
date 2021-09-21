#include<bits/stdc++.h>
const int M=1e9+7,N=2e5+500;

namespace GTI
{
	char gc(void)
	{
		return getchar();
	}
	int gti(void)
	{
		int a=0,b=1,c=gc();
		for (;!isdigit(c);c=gc()) b^=(c=='-');
		for (;isdigit(c);c=gc()) a=a*10+c-'0';
		return b?a:-a;
	}
};
using GTI::gti;

int fpw(int a,int b)
{
	a%=M,b%=M-1;
	if (b<0) b+=M-1;
	int c=1;
	for (;b;b>>=1,a=1ll*a*a%M)
		if (b&1)
			c=1ll*c*a%M;
	return c;
}
const int inv2=fpw(2,-1);

int ml2[N],n,inv[N];
void totinit(int n)
{
	ml2[0]=1,inv[0]=1;
	for (int i=1;i<=n;i++)
	{
		ml2[i]=2ll*ml2[i-1]%M;
		inv[i]=1ll*inv[i-1]*inv2%M;
	}
}

struct S
{
	int mid1,midc,ltot,rtot;
	std::set<int,std::greater<int>> l1;
	std::set<int,std::less<int>> r1;
	struct Segt
	{
		struct T
		{
			int val,cnt,tag,usd;
			void cleartag(void){tag=0;}
			void init(int x=0,bool usd=true)
			{
				cleartag();
				if (x<0) val=inv[-x];
				else val=ml2[x];
				cnt=x,this->usd=usd;
				if (!usd) val=0;
			}
			void init(bool usd)
			{
				cleartag();
				if (cnt<0) val=inv[-cnt];
				else val=ml2[cnt];
				this->usd=usd;
				if (!usd) val=0;
			}
			void work(int tag)
			{
				cnt+=tag;
				if (tag<0) val=1ll*val*inv[-tag]%M;
				else val=1ll*val*ml2[tag]%M;
				this->tag+=tag;
			}
		}t[N<<2];
		void pushup(T &v,const T &l,const T &r)
		{
			v.val=(l.val+r.val)%M;
			v.cnt=std::max(l.cnt,r.cnt);
			v.cleartag();
		}
		void pushdown(int v)
		{
			t[v<<1].work(t[v].tag);
			t[v<<1|1].work(t[v].tag);
			t[v].cleartag();
		}
#define mid ((l+r)>>1)
		void init(int *arr,bool *usd,int v=1,int l=1,int r=n)
		{
			if (l==r) t[v].init(arr[l],usd[l]);
			else
			{
				init(arr,usd,v<<1,l,mid);
				init(arr,usd,v<<1|1,mid+1,r);
				pushup(t[v],t[v<<1],t[v<<1|1]);
			}
		}
		void addc(int ml,int mr,int k,int v=1,int l=1,int r=n)
		{
			if (mr<l||ml>r) return;
			if (ml<=l&&mr>=r) t[v].work(k);
			else
			{
				pushdown(v);
				if (ml<=mid) addc(ml,mr,k,v<<1,l,mid);
				if (mr>mid) addc(ml,mr,k,v<<1|1,mid+1,r);
				pushup(t[v],t[v<<1],t[v<<1|1]);
			}
		}
		void set(int loc,bool usd,int v=1,int l=1,int r=n)
		{
			if (l==r)
			{
				if (loc==l) t[v].init(usd);
				return;
			}
			pushdown(v);
			if (loc<=mid) set(loc,usd,v<<1,l,mid);
			else set(loc,usd,v<<1|1,mid+1,r);
			pushup(t[v],t[v<<1],t[v<<1|1]);
		}
		int query(int ql,int qr,int v=1,int l=1,int r=n)
		{
			if (qr<l||ql>r) return 0;
			if (ql<=l&&qr>=r) return t[v].val;
			int ans=0;
			pushdown(v);
			if (ql<=mid) ans=(ans+query(ql,qr,v<<1,l,mid))%M;
			if (qr>mid) ans=(ans+query(ql,qr,v<<1|1,mid+1,r))%M;
			return ans;
		}
		int queryc(int ql,int qr,int v=1,int l=1,int r=n)
		{
			if (qr<l||ql>r) return 0;
			if (ql<=l&&qr>=r) return t[v].cnt;
			int ans=-1e9;
			pushdown(v);
			if (ql<=mid) ans=std::max(ans,queryc(ql,qr,v<<1,l,mid));
			if (qr>mid) ans=std::max(ans,queryc(ql,qr,v<<1|1,mid+1,r));
			return ans;
		}
#undef mid
	}t[2];
	int cnt[N],arr[N];
	bool usd[N];
	char s[N];
	void init(int len)
	{
		scanf("%s",s+1);
		l1.clear(),l1.insert(-1);
		r1.clear(),r1.insert(len+1);
		midc=mid1=ltot=rtot=0;
		n=len>>1;
		for (int i=1;i<=len;i++)
		{
			if (i<=n)
			{
				cnt[i]=cnt[i-1];
				if (s[i]=='?')
					++cnt[i],++ltot;
				else if (s[i]=='1')
					l1.insert(i);
			}
			else if (i==n+1)
			{
				cnt[i]=0;
				if (s[i]=='?') midc=1;
				else if (s[i]=='1') mid1=1;
			}
			else
			{
				cnt[i]=cnt[i-1];
				if (s[i]=='?')
					++cnt[i],++rtot;
				else if (s[i]=='1')
					r1.insert(i);
			}
		}
		for (int i=1;i<=n;i++)
		{
			arr[i]=cnt[i]-1+rtot;
			usd[i]=(s[i]=='?');
		}
		t[0].init(arr,usd);
		for (int i=1;i<=n;i++)
		{
			if (i==1) arr[i]=cnt[i]-1+rtot;
			else arr[i]=cnt[i]-1+rtot-cnt[i+n];
			usd[i]=(s[i]=='?');
		}
		t[1].init(arr,usd);
	}
	void changech(int x,char c)
	{
		if (s[x]==c) return;
		if (s[x]=='?')
		{
			if (x==n+1)
				midc=0;
			else if (x<=n)
			{
				--ltot;
				if (x>1)
				{
					t[0].set(x,false);
					t[1].set(x,false);
				}
				t[0].addc(x,n,-1);
				t[1].addc(x,n,-1);
			}
			else
			{
				--rtot;
				t[0].addc(1,n,-1);
				t[1].addc(1,n,-1);
				t[1].addc(x-n,n,1);
			}
		}
		else if (s[x]=='1')
		{
			if (x==n+1) mid1=0;
			else if (x<=n) l1.erase(x);
			else r1.erase(x);
		}
		s[x]=c;
		if (s[x]=='?')
		{
			if (x==n+1)
				midc=1;
			else if (x<=n)
			{
				++ltot;
				if (x>1)
				{
					t[0].set(x,true);
					t[1].set(x,true);
				}
				t[0].addc(x,n,1);
				t[1].addc(x,n,1);
			}
			else
			{
				++rtot;
				t[0].addc(1,n,1);
				t[1].addc(1,n,1);
				t[1].addc(x-n,n,-1);
			}
		}
		else if (s[x]=='1')
		{
			if (x==n+1) mid1=1;
			else if (x<=n) l1.insert(x);
			else r1.insert(x);
		}
	}
	int query(void)
	{
		int ans=0;
		if (mid1) return ml2[ltot+rtot];
		if (midc) ans=ml2[ltot+rtot];

		int lx=*l1.begin(),rx=*r1.begin();
		if (lx+n>=rx) return ml2[ltot+rtot+midc];

		int llc=t[0].queryc(1,lx),lrc=llc-t[1].queryc(lx,lx);
		llc=llc+1-rtot;
		if (lx<1) llc=-1;
		if (llc>=0) ans=(ans+1ll*(ml2[llc+rtot]-ml2[llc+rtot-lrc]))%M;
		ans=(ans+1ll*(t[0].query(lx+1,rx-n-1)-t[1].query(lx+1,rx-n-1)))%M;
		ans=(ans+1ll*(t[0].query(rx-n,n)))%M;

		return (ans%M+M)%M;
	}
}tr;

char op[10];
int main(void)
{
	totinit(2e5);
	for (int TT=gti();TT;TT--)
	{
		int n=gti(),q=gti();
		tr.init(n);
		printf("%d\n",tr.query());
		for (int Q=1;Q<=q;Q++)
		{
			int x=gti();
			scanf("%s",op);
			tr.changech(x,op[0]);
			printf("%d\n",tr.query());
		}
	}
	return 0;
}

