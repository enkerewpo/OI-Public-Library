{ID:asiapea1
PROB:cowcycle
LANG:PASCAL
}
var f,r,i,j,k,l,m,n,f1,f2,r1,r2:longint;
    a,b,ansa,ansb:array[0..11]of longint;
    c:array[0..1000]of real;
    pd:array[0..1000]of boolean;
    min:real;
//------------print-----------------------
procedure print;
var i,j,k,l,t:longint;
    p,sum,pj:real;
begin
   if a[f]*b[r]<3*a[1]*b[1] then exit;
   if (b[1]=17)and(b[2]=20)and(b[3]=37) then
     i:=i;
   k:=0;
   sum:=0;
 
   for i:=1 to f do
     for j:=1 to r do
       begin
          p:=a[i]/b[j];
          inc(k);
          l:=k;
          while c[l-1]>=p do begin
                             c[l]:=c[l-1];
                             dec(l);
                            end;
          c[l]:=p;
       end;
   p:=0;
   pj:=0;
   pj:=abs(c[k]-c[1])/(k-1);
   sum:=0;
   for i:=1 to k-1 do
       sum:=sum+sqr(abs(c[i]-c[i+1])-pj);
   p:=sum/(k-1);
   if p<min+0.0000001   then begin
                             ansa:=a;
                             ansb:=b;
                             min:=p;
                           end;
end;
//-----------step2------------------------------
procedure step1(i:longint);
var  j:longint;
begin
   if i>1 then
   if a[f]*r2<3*a[1]*b[1] then exit;
  if i>r then begin print; exit end;
  for j:=b[i-1]+1 to r2 do
     begin
      b[i]:=j;
      step1(i+1);
     end
end;
//----------step-------------------------------------
procedure step(i:longint);
var j:longint;
     flag:boolean;
begin
  if i>f then begin
               flag:=true;
               for j:=1 to f do
               if not pd[a[j]] then begin flag:=false;break end;
               if flag then exit;
               step1(1);exit
               end;
  for j:=a[i-1]+1 to f2 do
    begin
      a[i]:=j;
      step(i+1);
    end;
end;
//---------main-----------------------------------
begin
   min:=999999999;
   assign(input,'cowcycle.in');reset(input);
   assign(output,'cowcycle.out');rewrite(output);
   readln(f,r);
   readln(f1,f2,r1,r2);
   for i:=f1 to f2 do
     begin
       k:=0;
      for j:=f1+1 to i do
        if i mod j=1 then pd[i]:=true;
      end;
   a[0]:=f1-1;b[0]:=r1-1;
   step(1);
   for i:=1 to f-1 do write(ansa[i],' ');
   writeln(ansa[f]);
   for i:=1 to r-1 do write(ansb[i],' ');
   writeln(ansb[r]);
   close(output);
end.