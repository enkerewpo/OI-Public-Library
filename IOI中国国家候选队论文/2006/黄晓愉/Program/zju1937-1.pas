program zju1937;
var num,ans :array[0..500] of integer;
    n,min,ok:integer;
procedure out(t:integer);
var i:integer;
begin
  for i:=0 to t do
  begin
    write(ans[i]);
    if i<>t then write(' ');
  end;
  writeln;
end;
procedure dfs(i:integer);
var k1,k2 :integer;
begin
  for k1:=0 to i-1 do
    for k2:=0 to k1 do
    begin
      if num[k1]+num[k2]<=num[i-1] then continue;
      if num[k1]+num[k2]<=n then
      begin
        num[i]:=num[k1]+num[k2];
        if (num[i]<n) and ((i<min) or (min=0)) then dfs(i+1);
        if (num[i]=n) and ((i<min) or (min=0)) then begin
                                                      ans:=num;
                                                      min:=i;
                                                    end;
      end;
    end;
end;
begin
  assign(input,'in.txt');
  assign(output,'out.txt');
  reset(input);
  rewrite(output);
  readln(n);
  num[0]:=1;
  min:=0;
  ans:=num;
  if n>1 then dfs(1);
  out(min);
  close(input);
  close(output);
end.
