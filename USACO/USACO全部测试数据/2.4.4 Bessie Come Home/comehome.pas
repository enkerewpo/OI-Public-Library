{
ID:asiapea1
PROG:comehome
LANG:PASCAL
}
const ph=['A'..'Z','a'..'z'];
var
  a:array[1..52,1..52]of int64;
  f1,f2:text;
  b:array['A'..'z']of integer;
  i,j,k,n,d:integer;
  t1,t2:char;
  min:int64;
begin
  for i:=1 to 26 do
    b[chr(i+64)]:=i;
  for i:=27 to 52 do
    b[chr(i+70)]:=i;
  assign(f1,'comehome.in');
  reset(f1);
  readln(f1,n);
  for i:=1 to 52 do
    for j:=1 to 52 do a[i,j]:=0;
  for i:=1 to n do
    begin
      read(f1,t1);
      while not(t1 in ph) do
        read(f1,t1);
      read(f1,t2);
      while not(t2 in ph) do
        read(f1,t2);
      readln(f1,d);
      if (a[b[t1],b[t2]]=0) or (a[b[t1],b[t2]]>d)
          then begin
                 a[b[t1],b[t2]]:=d;
                 a[b[t2],b[t1]]:=d;
               end;  
    end;
  close(f1);
  for i:=52 downto 1 do
    for j:=52 downto 1 do
      for k:=52 downto 1 do
        if a[i,k]*a[k,j]<>0 then
        if (a[i,k]+a[k,j]<a[i,j]) or (a[i,j]=0) then a[i,j]:=a[i,k]+a[k,j];
  min:=0;
  for i:=1 to 25 do
    if a[i,26]<>0 then
    if (min=0) or (a[i,26]<a[min,26]) then min:=i;
  assign(f2,'comehome.out');
  rewrite(f2);
  if min<=26 then write(f2,chr(min+64))
             else write(f2,chr(min+96));
  write(f2,' ');
  writeln(f2,a[min,26]);
  close(f2);
  // Insert user code here
end.