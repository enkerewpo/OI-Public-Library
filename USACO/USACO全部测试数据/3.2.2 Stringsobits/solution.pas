{
ID:asiapea1
PROG:kimbits
LANG:PASCAL
}
program kimbits;
const maxn=31;
var f:array[0..maxn+1,0..maxn+1] of int64;
    i,j,n,l:longint;
    k:int64;
 
procedure opf;
begin
  assign(input,'kimbits.in'); reset(input);
  assign(output,'kimbits.out'); rewrite(output);
end;
 
procedure clf;
begin
  close(input);
  close(output);
end;
 
procedure init;
begin
  readln(n,l,k);
  for i:=0 to n do
    begin
      f[i,0]:=1;
      f[0,i]:=1;
    end;
end;
 
procedure main;
begin
  for i:=1 to n do
    for j:=1 to n do
      if j>i then f[i,j]:=f[i,i] else f[i,j]:=f[i-1,j]+f[i-1,j-1];
  for i:=n-1 downto 0 do
    if f[i,l]<k then
      begin
        write(1);
        dec(k,f[i,l]);
        dec(l);
      end
    else write(0);
  writeln;
end;
 
begin
  opf;
  init;
  main;
  clf;
end.