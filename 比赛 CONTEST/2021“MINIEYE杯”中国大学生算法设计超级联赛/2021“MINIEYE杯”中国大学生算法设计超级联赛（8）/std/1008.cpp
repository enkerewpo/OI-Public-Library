#include<bits/stdc++.h>
using namespace std;
int t; 
int r1,r2,xa,ya,xb,yb,a;
const double pi=acos(-1.0);
int main()
{
    scanf("%d",&t);
    while(t--)
    {
        scanf("%d%d%d%d%d%d%d",&r1,&xa,&ya,&r2,&xb,&yb,&a);
        if(sqrt(2.0)*r2<a)
        {
            puts("0.000000");
            continue;
        }
        double ra=sqrt(r1*r1-a*a/4.0)-a/2.0,rb=sqrt(r2*r2-a*a/4.0)-a/2.0;
        double d=sqrt((double)(xa-xb)*(xa-xb)+(ya-yb)*(ya-yb));
        if(ra+rb<=d)
        {
            puts("0.000000");
            continue;
        }
        if(ra>=rb+d)
        {
            printf("%.6f\n",rb*rb/ra/ra);
            continue;
        }
        if(rb>=ra+d)
        {
            puts("1.000000");
            continue;
        }
        double ca=(ra*ra+d*d-rb*rb)/ra/d/2.0,cb=(rb*rb+d*d-ra*ra)/rb/d/2.0;
        double s=acos(ca)*ra*ra+acos(cb)*rb*rb-ra*ra*ca*sqrt(1.0-ca*ca)-rb*rb*cb*sqrt(1.0-cb*cb);
        printf("%.6f\n",s/pi/ra/ra);
    }
    return 0;
}
