{
ID:asiapea1
PROG:money
LANG:PASCAL
}
program Money_Systems;
var
  v,n,i,j,k,l:longint;
  da:array[1..25]of integer;
  dp:array[0..10000]of int64;
begin
  assign(input,'money.in');
  reset(input);
  read(v,n);
  for i:=1 to v do read(da[i]);
  close(input);
  dp[0]:=1;
  for i:=1 to v do
    for j:=da[i] to n do
      if dp[j-da[i]]>0
        then inc(dp[j],dp[j-da[i]]);
  assign(output,'money.out');
  rewrite(output);
  writeln(dp[n]);
  close(output);
end.
