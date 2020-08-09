{
ID:asiapea1
PROB:preface
LANG:PASCAL
}
const a:array[0..9,1..2] of integer=((0,0),(1,0),(2,0),(3,0),(1,1),(0,1),(1,1),(2,1),(3,1),(1,0));
      b:array[1..4,1..2] of char=(('I','V'),('X','L'),('C','D'),('M','V'));
var c:array[1..4] of integer;
    d:array[1..4,1..2] of longint;
    i,j,n,k,p:longint;
begin
assign(input,'preface.in');
reset(input);
assign(output,'preface.out');
rewrite(output);
c[1]:=1;
for i:=2 to 4 do c[i]:=c[i-1]*10;
fillchar(d,sizeof(d),0);
read(n);
for i:=1 to n do
  for j:=1 to 4 do
   begin
    p:=i div c[j] mod 10;
    if p=9 then inc(d[j+1,1]);
    for k:=1 to 2 do inc(d[j,k],a[p,k]);
   end;
for i:=1 to 4 do
  for j:=1 to 2 do
   if d[i,j]>0 then
    writeln(b[i,j],' ',d[i,j]);
close(output);
end.
