#include<bits/stdc++.h>
#ifdef debug
bool tag;
#endif
typedef long long ll;
typedef long double ld;
const int N=262144,M=998244353;
const ld pi=acosl(-1);

namespace GTI
{
	char gc(void)
	{
		const int S=1<<17;
		static char buf[S],*s=buf,*t=buf;
		if (s==t) t=buf+fread(s=buf,1,S,stdin);
		if (s==t) return EOF;
		return *s++;
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

namespace Poly
{
    const long double pi=acosl(-1);
    struct C
    {
        long double x,y;
        C():x(0),y(0){}
        C(long double a,long double b):x(a),y(b){}
        C operator+(const C &b){return C(x+b.x,y+b.y);}
        C operator-(const C &b){return C(x-b.x,y-b.y);}
        C operator*(const C &b){return C(x*b.x-y*b.y,x*b.y+y*b.x);}
        C operator/(long double b){return C(x/b,y/b);}
    };
    int id[N];
    int init(int n)
    {
        int ret=1;
        for (;1<<ret<n;ret++);
        for (int i=0;i<1<<ret;i++)
            id[i]=id[i>>1]>>1|((i&1)<<(ret-1));
        return 1<<ret;
    }
    C getwl(int x,int tag)
    {
        return C(cosl(2*pi/x),tag*sinl(2*pi/x));
    }
    void fft(C *a,int len,int tag=1)
    {
        for (int i=0;i<len;i++)
            if (id[i]>i)
                std::swap(a[i],a[id[i]]);
        for (int l=1;l<len;l<<=1)
        {
            C wl=getwl(l*2,tag);
            for (int st=0;st<len;st+=l<<1)
            {
                C w(1,0),tmp;
                for (int i=st;i<st+l;i++,w=w*wl)
                    tmp=a[i+l]*w,a[i+l]=a[i]-tmp,a[i]=a[i]+tmp;
            }
        }
        if (tag<0)
            for (int i=0;i<len;i++)
                a[i]=a[i]/len;
    }
    int mul(int *ret,int *a,int alen,int *b,int blen,int M)
    {
        static C c[N],d[N],e[N];
        int s=alen+blen-1,len=init(s);
        for (int i=0;i<alen;i++)
            c[i]=C(a[i]>>15,a[i]&0x7fff);
		std::fill(c+alen,c+len,C());
        for (int i=0;i<blen;i++)
            d[i]=C(b[i]>>15,b[i]&0x7fff);
		std::fill(d+blen,d+len,C());
        fft(c,len),fft(d,len);
        for (int i=0;i<len;i++)
        {
            int j=(len-i)&(len-1);
            e[i]=d[i]*C(0.5*(c[i].x+c[j].x),0.5*(c[i].y-c[j].y));
            d[i]=d[i]*C(0.5*(c[i].y+c[j].y),0.5*(c[j].x-c[i].x));
        }
        fft(e,len,-1),fft(d,len,-1);
        for (int i=0;i<s;i++)
        {
            ll x=roundl(e[i].x),y=roundl(e[i].y),z=roundl(d[i].x),w=roundl(d[i].y);
            ret[i]=(((x%M<<30)%M+((y+z)%M<<15)%M+w%M)%M+M)%M;
        }
        return s;
    }
}

int a[N<<1],tot;
struct P
{
	int *p,len;
	void init(int len)
	{
		p=a+tot;
		this->len=len;
		for (int i=0;i<len;i++)
			p[i]=0;
		++p[0],++p[len-1];
		tot+=len;
	}
	void mul(const P &b,int mod)
	{
#ifdef debug
		if (tag)
		{
			FILE *fp=fopen("e_.err","w");
			fprintf(fp,"%d %d\n",len,b.len);
			for (int i=0;i<len;i++) fprintf(fp,"%d ",p[i]);
			fprintf(fp,"\n");
			for (int i=0;i<b.len;i++) fprintf(fp,"%d ",b.p[i]);
			fprintf(fp,"\n");
			tag=false;
		}
#endif
		len=Poly::mul(p,p,len,b.p,b.len,mod);
	}
};
#define mid ((l+r)>>1)
P solve(int l,int r,int p)
{
	P ret;
	if (l==r)
		ret.init(gti()+1);
	else
	{
		ret=solve(l,mid,p);
		ret.mul(solve(mid+1,r,p),p);
	}
#ifdef debug
	if (l==51&&r==100)
	{
		tag=true;
	}
#endif
	return ret;
}
#undef mid
int main(void)
{
	//freopen("e_data.txt","r",stdin);
	for (int T=gti();T;T--)
	{
		int n=gti(),ans=1;
		tot=0;
		P now=solve(1,n,M-1);
		if (now.p[0]>1) puts("0");
		else
		{
			for (int i=1;i<now.len;i++)
				ans=1ll*ans*fpw(i,now.p[i])%M;
			printf("%d\n",ans);
		}
	}
	return 0;
}

