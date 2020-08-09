/*
ID:tcltsh5
LANG:C
TASK:cowtour
*/
#include "stdio.h"
#include "math.h"
#include "stdlib.h"
void csh_nc(char jz[][151],int nc[],int n,int k,int l)
{
int i,j;
nc[k]=l;
for(i=0;i<n;i++)
   if(jz[k][i]=='1'&&nc[i]==i&&l!=i)
    csh_nc(jz,nc,n,i,l);
}
double count(long a,long b,long c,long d)
{
double dis;
dis=sqrt(abs(a-c)*abs(a-c)+abs(b-d)*abs(b-d));
return dis; 
}

void find_dis(double dis[][151],long x[],long y[],int n,char jz[][151])
{
int i,j;
for(i=0;i<n;i++)
   for(j=0;j<n;j++)
    if(jz[i][j]=='1')
     dis[i][j]=count(x[i],y[i],x[j],y[j]);                     
    else
     dis[i][j]=1000000;
}
double dij(double dis[][151],int nc[],int k,int s,long x[],long int y[],int n,double path[])
{
int i,j;
double min=1000000,m1,m2;
for(i=0;i<n;i++)
   if(nc[i]==nc[k])
    for(j=0;j<n;j++)
     if(nc[j]==nc[s])
      {
       if(path[i]+path[j]+count(x[i],y[i],x[j],y[j])<min)
        min=path[i]+path[j]+count(x[i],y[i],x[j],y[j]);            
      }
return min;
}

double dijkstra(double dis[][151],int nc[],int n,char jz[][151],long x[],long y[])
{
int i,j,k,a,b,s=0;
double t,m1,min=1000000000,path[151];
for(k=0;k<n;k++)
{
   for(i=0;i<n;i++)
    for(j=0;j<n;j++)                
     if(dis[i][j]>dis[i][k]+dis[k][j])
      dis[i][j]=dis[i][k]+dis[k][j];
} 
for(i=0;i<n;i++)
   path[i]=0;
for(i=0;i<n;i++)
   for(j=0;j<n;j++)
    if(nc[i]==nc[j]&&i!=j&&path[i]<dis[i][j])
    {     
     path[i]=dis[i][j];
    }
    for(i=0;i<n;i++) 
     for(j=0;j<n;j++)
      if(nc[j]!=nc[i]&&j==nc[j]&&i==nc[i])
       {
        m1=0;
        for(k=0;k<n;k++)
         if(nc[k]==nc[i])
          {
           t=dij(dis,nc,k,j,x,y,n,path);
           if(t>m1)
            m1=t;
          }
        if(min>m1)
         min=m1;
       } 
for(i=0;i<n;i++)
   if(path[i]>min)
    min=path[i];              
return min;   
}

main()
{
char jz[151][151];
int n,i,j,nc[151];
long x[151],y[151];
double min,dis[151][151];
FILE *in,*out;
in=fopen("cowtour.in","r");
out=fopen("cowtour.out","w");
fscanf(in,"%d",&n);
for(i=0;i<n;i++)
   fscanf(in,"%d%d",&x[i],&y[i]);
for(i=0;i<n;i++)
   fscanf(in,"%s",jz[i]);
for(i=0;i<n;i++)
   nc[i]=i;
for(i=0;i<n;i++)
   if(nc[i]==i)
    csh_nc(jz,nc,n,i,i);
find_dis(dis,x,y,n,jz);
min=dijkstra(dis,nc,n,jz,x,y);
fprintf(out,"%.6f\n",min);
fclose(in);
fclose(out);
}

