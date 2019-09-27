program hxy;
Const maxn=1000;
Var a,need:array[1..maxn]of longint;
    n,m,s,i:longint;
begin
  randomize;
  assign(output,'weight.in');
  rewrite(output);
  n:=1000; m:=1000;
  for i:=1 to m do need[i]:=random(1000)+1;
  for i:=1 to n do a[i]:=need[random(m)+1];
  writeln(n,' ',m);
  for i:=1 to m-1 do write(need[i],' ');
  writeln(need[m]);
  s:=0;
  for i:=1 to n do
  begin
    inc(s,a[i]);
    write(s,' ');
  end;
  s:=a[n];
  write(s);
  for i:=n-1 downto 1 do
  begin
    inc(s,a[i]);
    write(' ',s);
  end;
  writeln;
  {writeln;
  writeln;
  for i:=1 to n do write(a[i],' ');
  writeln;}
  close(output);
end.

