{
ID:asiapea1
PROG:fence8
LANG:PASCAL
}
program fence8;
const maxn=50;
      maxr=1023;
var a:array[0..maxn+1] of longint;
    b,sum:array[0..maxr+1] of longint;
    n,i,r,ans,tot,waste:longint;
 
procedure opf;
begin
  assign(input,'fence8.in'); reset(input);
  assign(output,'fence8.out'); rewrite(output);
end;
 
procedure clf;
begin
  close(input);
  close(output);
end;
 
function qpass(s,t:integer; var x:array of longint):integer;
var i,j,r:integer;
begin
  i:=s;
  j:=t;
  r:=x[s];
  while i<j do
    begin
      while (i<j) and (x[j]>=r) do dec(j);
      x[i]:=x[j];
      while (i<j) and (x[i]<=r) do inc(i);
      x[j]:=x[i];
    end;
  x[i]:=r;
  qpass:=i;
end;
 
procedure qsort(s,t:integer; var x:array of longint);
var k,r:longint;
begin
  if s<t then
    begin
      k:=random(t-s)+s;
      r:=x[s];
      x[s]:=x[k];
      x[k]:=r;
      k:=qpass(s,t,x);
      qsort(s,k-1,x);
      qsort(k+1,t,x);
    end;
end;
 
procedure init;
begin
  randomize;
  tot:=0;
  readln(n);
  for i:=1 to n do
    begin
      readln(a[i]);
      inc(tot,a[i]);
    end;
  readln(r);
  sum[0]:=0;
  for i:=1 to r do readln(b[i]);
  qsort(1,n,a);
  qsort(1,r,b);
  for i:=1 to r do sum[i]:=sum[i-1]+b[i];
end;
 
function can(x:integer):boolean;
var p:array[0..maxn+1] of longint;
 
function dfs(now,lp,x:integer):boolean;
var i,j:integer;
    change:boolean;
begin
  if now=0 then exit(true);
  if waste+sum[x]>tot then exit(false);
  if (now<>x) and (b[now]=b[now+1]) then j:=lp else j:=1;
  for i:=j to n do
    if p[i]>=b[now] then
      begin
        dec(p[i],b[now]);
        change:=false;
        if p[i]<b[1] then
          begin
            change:=true;
            inc(waste,p[i]);
          end;
        if dfs(now-1,i,x) then exit(true);
        if change then dec(waste,p[i]);
        inc(p[i],b[now]);
      end;
  exit(false);
end;
 
begin
  waste:=0;
  p:=a;
  if dfs(x,0,x) then exit(true) else exit(false);
end;
 
procedure main;
var s,t,m:integer;
begin
  s:=1;
  t:=r;
  ans:=0;
  while s<=t do
    begin
      m:=(s+t+1) div 2;
      if can(m) then
        begin
          ans:=m;
          s:=m+1;
        end
      else t:=m-1;
    end;
end;
 
procedure outit;
begin
  writeln(ans);
end;
 
begin
  opf;
  init;
  main;
  outit;
  clf;
end.