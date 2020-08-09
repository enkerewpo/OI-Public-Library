{
ID:asiapea1
PROG:palsquare
LANG:PASCAL
}
var
  a:array[1..40]of integer;
  f1,f2:text;
  i,t,n,b,j:longint;
  f:boolean;
begin
  assign(f1,'palsquare.in');
  reset(f1);
  readln(f1,b);
  close(f1);
  assign(f2,'palsquare.out');
  rewrite(f2);
  for i:=1 to 300 do
    begin
      t:=sqr(i);
      n:=0;
      repeat
        inc(n);
        a[n]:=t mod b;
        t:=t div b;
      until t=0;
      f:=true;
      for j:=1 to n div 2 do
        if a[j]<>a[n-j+1] then f:=false;
      if f then begin
                  n:=0;t:=i;
                  repeat
                    inc(n);
                    a[n]:=t mod b;
                    t:=t div b;
                  until t=0;
                  for j:=n downto 1 do
                    if a[j]<10 then
                    write(f2,a[j]) else write(f2,chr(a[j]+55));
                  write(f2,' ');
                  t:=sqr(i);
                  n:=0;
                  repeat
                    inc(n);
                    a[n]:=t mod b;
                    t:=t div b;
                  until t=0;
                  for j:=1 to n do
                    if a[j]<10 then
                      write(f2,a[j]) else write(f2,chr(a[j]+55));
                  writeln(f2);
                end;
    end;
  close(f2);
  // Insert user code here
end.