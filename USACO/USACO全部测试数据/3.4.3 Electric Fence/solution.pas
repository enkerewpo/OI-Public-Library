{
ID:asiapea1
PROG:fence9
LANG:PASCAL
}
program fence9;
const
  epsilon=1e-5;
var
  n,m,p,y,x1,x2:word;
  tot:dword;
begin
  assign(input,'fence9.in');
  assign(output,'fence9.out');
  reset(input);
  rewrite(output);
  readln(n,m,p);
  tot:=0;
  for y:=1 to m-1 do
  begin
    x1:=trunc(y*n/m)+1;
    x2:=trunc(y*(n-p)/m+p-epsilon);
    inc(tot,x2-x1+1);
  end;
  writeln(tot);
  close(output);
end.