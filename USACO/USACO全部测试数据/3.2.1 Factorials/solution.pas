{
ID: starfor1
PROG: fact4
LANG: PASCAL
}
var
  re:byte;
  s,i,n,ad:word;
begin
  assign(input,'fact4.in');
  assign(output,'fact4.out');
  reset(input);
  rewrite(output);
  readln(n);
  re:=1;
  ad:=0;
  for i:=2 to n do
  begin
    s:=i;
    while s mod 2=0 do
    begin
      inc(ad);
      s:=s div 2;
    end;
    while s mod 5=0 do
    begin
      dec(ad);
      s:=s div 5;
    end;
    re:=re*s mod 10;
  end;
  for i:=1 to ad do
    re:=re*2 mod 10;
  writeln(re);
  close(output);
end.