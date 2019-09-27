{$M 6400000}
program ural1099;
const maxn=300;
      randtime=50;
var n,ans:longint;
    p,q,my,ansy:array[1..maxn]of longint;
    map:array[1..maxn,1..maxn]of boolean;
    u:array[1..maxn]of boolean;
procedure swap(var x,y:longint);
var t:longint;
begin
 t:=x;x:=y;y:=t;
end;
procedure inputint;
var a,b:longint;
begin
 readln(n);
 while not(eof) do
  begin
   readln(a,b);
   map[a,b]:=true;
   map[b,a]:=true;
  end;
end;
function aug(x:longint):boolean;
var i:longint;
begin
 u[x]:=true;
 for i:=1 to n do
  if not(u[q[i]]) then
   if map[x,q[i]] then
    begin
     u[q[i]]:=true;
     if (my[q[i]]=0)or(aug(my[q[i]])) then
      begin
       my[q[i]]:=x;
       my[x]:=q[i];
       aug:=true;
       exit;
      end;
    end;
 aug:=false;
end;
procedure updata(tmp:longint);
var i:longint;
begin
 ans:=tmp;
 for i:=1 to n do ansy[i]:=my[i];
end;
procedure workans;
var i,tmp:longint;
begin
 fillchar(my,sizeof(my),0);
 tmp:=0;
 for i:=1 to n do
  if my[p[i]]=0 then
   begin
    fillchar(u,sizeof(u),0);
    if aug(p[i]) then inc(tmp);
   end;
 if tmp>ans then updata(tmp);
end;
procedure work;
var i,j,time:longint;
begin
 for i:=1 to n do
  begin
   p[i]:=i;
   q[i]:=i;
  end;
 for time:=1 to randtime do
  begin
   for i:=1 to n do
    begin
     j:=i+random(n-i+1);
     swap(q[i],q[j]);
     j:=i+random(n-i+1);
     swap(p[i],p[j]);
    end;
   workans;
  end;
end;
procedure outputint;
var i:longint;
begin
 writeln(ans*2);
 for i:=1 to n do
  if ansy[i]>i then writeln(i,' ',ansy[i]);
end;
begin
 assign(input,'input.in');reset(input);
 assign(output,'output.out');rewrite(output);
 randomize;
 inputint;
 work;
 outputint;
 close(input);
 close(output);
end.
