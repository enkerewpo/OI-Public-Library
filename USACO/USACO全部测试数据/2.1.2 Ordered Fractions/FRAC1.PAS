{
ID:asiapea1
PROG:frac1
LANG:PASCAL
}
var
  n:integer;
  fin,fout:text;
  procedure solve(a,b,c,d:integer);
  begin
    if (b+d>n) then exit;
    solve(a,b,a+c,b+d);
    writeln(fout,a+c,'/',b+d);
    solve(a+c,b+d,c,d);
  end;
begin
  assign(fin,'frac1.in');
  reset(fin);
  readln(fin,n);
  close(fin);
  assign(fout,'frac1.out');
  rewrite(fout);
  writeln(fout,'0/1');
  solve(0,1,1,1);
  writeln(fout,'1/1');
  close(fout);
end.