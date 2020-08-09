{
ID: asiapea1
PROG: game1
LANG: PASCAL
}
var
  n,i,j,k:byte;
  tot:word;
  op:array[0..101,0..101]of word;
  game:array[1..100]of byte;
//
function max (a,b:word):word;
begin
  if a>b then
    exit(a)
  else
    exit(b);
end;
//
function min (a,b:word):word;
begin
  if a>b then
    exit(b)
  else
    exit(a);
end;
//
begin
  assign(input,'game1.in');
  assign(output,'game1.out');
  reset(input);
  rewrite(output);
  readln(n);
  tot:=0;
  for i:=1 to n do
  begin
    read(game[i]);
    inc(tot,game[i]);
  end;
  for k:=1 to n do
    if not odd(n-k) then
      for i:=1 to n-k+1 do
      begin
        j:=i+k-1;
        op[i,j]:=max(op[i+1,j]+game[i],op[i,j-1]+game[j]);
      end
    else
      for i:=1 to n-k+1 do
      begin
        j:=i+k-1;
        op[i,j]:=min(op[i+1,j],op[i,j-1]);
      end;
  writeln(op[1,n],' ',tot-op[1,n]);
  close(output);
end.