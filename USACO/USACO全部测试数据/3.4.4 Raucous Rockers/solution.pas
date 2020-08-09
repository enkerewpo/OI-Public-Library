{
ID:asiapea1
PROG:rockers
LANG:PASCAL
}
program rockers;
var
  n,t,m,i,j:shortint;
  dp:array[1..20,1..20,0..20]of shortint;
  len:array[1..20]of shortint;
//
function gdp (a,b,c:shortint):shortint;
begin
  if b>m then
    exit(-1);
  if a>n then
    exit(0);
  if dp[a,b,c]<>127 then
    exit(dp[a,b,c]);
  dp[a,b,c]:=gdp(a+1,b,c);
  if c+len[a]<=t then
    if gdp(a+1,b,c+len[a])+1>dp[a,b,c] then
      dp[a,b,c]:=gdp(a+1,b,c+len[a])+1
    else
  else
    if gdp(a+1,b+1,len[a])+1>dp[a,b,c] then
      dp[a,b,c]:=gdp(a+1,b+1,len[a])+1;
  exit(dp[a,b,c]);
end;
//
begin
  assign(input,'rockers.in');
  assign(output,'rockers.out');
  reset(input);
  rewrite(output);
  readln(n,t,m);
  j:=0;
  for i:=1 to n do
  begin
    inc(j);
    read(len[j]);
    if len[j]>t then
      dec(j);
  end;
  n:=j;
  fillchar(dp,sizeof(dp),127);
  writeln(gdp(1,1,0));
  close(output);
end.