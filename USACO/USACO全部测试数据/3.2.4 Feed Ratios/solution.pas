{
ID:asiapea1
PROG:ratios
LANG:PASCAL
}
program ratios;
const
  zero=1e-5;
  epsilon=1e-2;
var
  lim,i,j:word;
  x:array[1..4]of word;
  b,t:array[1..3]of extended;
  a:array[1..3,1..3]of extended;
//
function can (x4:word):boolean;
var
  x1,x2,x3:extended;
begin
  x[4]:=x4;
  x3:=((a[1,3]*a[2,2]-a[1,2]*a[2,3])*(a[1,2]*b[1]-a[1,1]*b[2])-(a[1,2]*a[2,1]-a[1,1]*a[2,2])*(a[1,3]*b[2]-a[1,2]*b[3]))*x[4]/((a[1,3]*a[2,2]-a[1,2]*a[2,3])*(a[1,2]*a[3,1]-a[1,1]*a[3,2])-(a[1,2]*a[2,1]-a[1,1]*a[2,2])*(a[1,3]*a[3,2]-a[1,2]*a[3,3]));
  if abs(x3-round(x3))>epsilon then
    exit(false);
  x[3]:=round(x3);
  x2:=((a[1,3]*b[2]-a[1,2]*b[3])*x[4]-(a[1,3]*a[3,2]-a[1,2]*a[3,3])*x[3])/(a[1,3]*a[2,2]-a[1,2]*a[2,3]);
  if abs(x2-round(x2))>epsilon then
    exit(false);
  x[2]:=round(x2);
  x1:=(b[1]*x[4]-a[3,1]*x[3]-a[2,1]*x[2])/a[1,1];
  if abs(x1-round(x1))>epsilon then
    exit(false);
  x[1]:=round(x1);
  exit(true);
end;
//
begin
  assign(input,'ratios.in');
  assign(output,'ratios.out');
  reset(input);
  rewrite(output);
  for i:=1 to 3 do
  begin
    read(b[i]);
    if b[i]=0 then
      b[i]:=zero;
  end;
  readln;
  for i:=1 to 3 do
  begin
    for j:=1 to 3 do
    begin
      read(a[i,j]);
      if a[i,j]=0 then
        a[i,j]:=zero;
    end;
    readln;
  end;
  t[1]:=(a[1,1]*100+a[2,1]*100+a[3,1]*100)/b[1];
  t[2]:=(a[1,2]*100+a[2,2]*100+a[3,2]*100)/b[2];
  t[3]:=(a[1,3]*100+a[2,3]*100+a[3,3]*100)/b[3];
  lim:=maxsmallint*2+1;
  for i:=1 to 3 do
    if trunc(t[i])<lim then
      lim:=trunc(t[i]);
  i:=1;
  while (i<=lim) and not can(i) do
    inc(i);
  if i>lim then
    writeln('NONE')
  else
    writeln(x[1],' ',x[2],' ',x[3],' ',x[4]);
  close(output);
end.