{
ID: asiapea1
PROG: bigbrn
LANG: PASCAL
}
program bigbrn;
var
  i,j,k,l,m,n,t:longint;
  f,left,up,map:array[0..1001,0..1001]of integer;{f[i,j]记录以(i,j)为右下角的最大正方形的边长；
                                                  left[i,j]记录(i,j)左边，包括(i,j)的最大连续长度；
                                                  up[i,j]记录(i,j)上边，包括(i,j)的最大连续长度；}
 
function min(a,b:longint):longint;
begin
  if a<b then min:=a else min:=b;
end;
 
begin
  assign(input,'bigbrn.in');
  reset(input);
  assign(output,'bigbrn.out');
  rewrite(output);
  readln(n,t);
  fillchar(map,sizeof(map),0);
  for i:=1 to t do
  begin
    readln(j,k);
    map[j,k]:=1;
  end;
  fillchar(left,sizeof(left),0);
  for i:=1 to n do left[i,1]:=1-map[i,1];
  for i:=1 to n do
    for j:=2 to n do
    begin
      if map[i,j]=1 then left[i,j]:=0 else left[i,j]:=left[i,j-1]+1;
    end;
  fillchar(up,sizeof(up),0);
  for i:=1 to n do up[1,i]:=1-map[1,i];
  for i:=2 to n do
    for j:=1 to n do
    begin
      if map[i,j]=1 then up[i,j]:=0 else up[i,j]:=up[i-1,j]+1;
    end;
  fillchar(f,sizeof(f),0);
  for i:=1 to n do
    for j:=1 to n do
      f[i,j]:=min(f[i-1,j-1]+1,min(left[i,j],up[i,j]));
  m:=0;
  for i:=1 to n do
    for j:=1 to n do if f[i,j]>m then m:=f[i,j];
  writeln(m);
  close(input);
  close(output);
end.