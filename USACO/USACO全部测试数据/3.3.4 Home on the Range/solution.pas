{
ID: asiapea1
PROG: range
LANG: PASCAL
}
var
  t:char;
  n,i,j,dpx,tt:byte;
  dp:array[0..250]of byte;
  count:array[2..250]of word;
begin
  assign(input,'range.in');
  assign(output,'range.out');
  reset(input);
  rewrite(output);
  readln(n);
  for i:=1 to n do
  begin
    dp[0]:=0;
    for j:=1 to n do
    begin
      read(t);
      if t='0' then
      begin
        dpx:=dp[j];
        dp[j]:=0;
      end
      else
      begin
        tt:=255;
        if dp[j]<tt then
          tt:=dp[j];
        if dpx<tt then
          tt:=dpx;
        if dp[j-1]<tt then
          tt:=dp[j-1];
        dpx:=dp[j];
        dp[j]:=tt+1;
        if dp[j]>=2 then
          inc(count[dp[j]]);
      end;
    end;
    readln;
  end;
  for i:=n-1 downto 2 do
    inc(count[i],count[i+1]);
  for i:=2 to n do
    if count[i]=0 then
      break
    else
      writeln(i,' ',count[i]);
  close(output);
end.