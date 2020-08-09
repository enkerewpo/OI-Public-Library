{
ID:asiapea1
PROB:job
LANG:PASCAL
}
var a,b,s1,s2:array[1..1000]of longint;
    da,db:array[1..30]of longint;
    n,na,nb,min,k,i,j:longint;
procedure init;
begin
 assign(input,'job.in');reset(input);
 assign(output,'job.out');rewrite(output);
 read(n,na,nb);
 for i:=1 to na do
   read(a[i]);
 for i:=1 to nb do
   read(b[i]);
end;
begin
 init;
 for i:=1 to n do
  begin
   min:=9999999;
   for j:=1 to na do
     if min>da[j]+a[j] then begin
                              min:=da[j]+a[j];
                              k:=j;
                            end;
   da[k]:=min;
   s1[i]:=min;
  end;
 write(min,' ');
 for i:=1 to n do
  begin
   min:=9999999;
   for j:=1 to nb do
     if min>db[j]+b[j] then begin
                              min:=db[j]+b[j];
                              k:=j;
                            end;
   db[k]:=min;
   s2[i]:=min;
  end;
 min:=0;
 for i:=1 to n do
   if min<s1[i]+s2[n-i+1] then min:=s1[i]+s2[n-i+1];
 writeln(min);
 close(output);
end.