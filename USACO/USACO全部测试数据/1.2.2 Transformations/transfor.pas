{
ID:asiapea1
PROG:transform
LANG:PASCAL
}
type
  ttp=array[1..10,1..10]of char;
var
  f1,f2:Text;
  i,j,n:integer;
  d,a,b,c:ttp;
  Procedure Print(a,b:ttp;k:integer);
  var
    i,j:integer;
    begin
      if k=7 then begin
      writeln(f2,7);
      close(f2);
      halt;
      end;
      for i:=1 to n do
        for j:=1 to n do
          if a[i,j]<>b[i,j] then exit;
      writeln(f2,k);
      close(f2);
      halt;
    end;
begin
  assign(f1,'transform.in');
  reset(f1);
  readln(f1,n);
  for i:=1 to n do
    begin
      for j:=1 to n do
        read(f1,a[i,j]);
      readln(f1);
    end;
  for i:=1 to n do
    begin
      for j:=1 to n do
        read(f1,b[i,j]);
      readln(f1);
    end;
  close(f1);
  d:=a;
  assign(f2,'transform.out');
  rewrite(f2);
  for i:=1 to n do
    for j:=1 to n do
       c[j,n-i+1]:=a[i,j];
  Print(c,b,1);
  a:=c;
  for i:=1 to n do
    for j:=1 to n do
      c[j,n-i+1]:=a[i,j];
  Print(c,b,2);
  a:=c;
  for i:=1 to n do
    for j:=1 to n do
      c[j,n-i+1]:=a[i,j];
  Print(c,b,3);
  a:=c;
  for i:=1 to n do
    for j:=1 to n do
      c[j,n-i+1]:=a[i,j];
  a:=c;
  for i:=1 to n do
    for j:=1 to n do
      c[i,j]:=a[i,n-j+1];
  Print(c,b,4);
  a:=c;
  for i:=1 to n do
    for j:=1 to n do
      c[j,n-i+1]:=a[i,j];
  Print(c,b,5);
  a:=c;
  for i:=1 to n do
    for j:=1 to n do
      c[j,n-i+1]:=a[i,j];
  Print(c,b,5);
  a:=c;
  for i:=1 to n do
    for j:=1 to n do
      c[j,n-i+1]:=a[i,j];
  Print(c,b,5);
  Print(d,b,6);
  Print(c,b,7);
  // Insert user code here
end.