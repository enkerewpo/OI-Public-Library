{
ID: asiapea1
PROG: agrinet
LANG: PASCAL
}
var
  n,i,j,oj:byte;
  map:array[1..100,1..100]of dword;
  dis:array[1..100]of dword;
  vis:array[1..100]of boolean;
  fiber,min:dword;
begin
  assign(input,'agrinet.in');
  assign(output,'agrinet.out');
  reset(input);
  rewrite(output);
  readln(n);
  for i:=1 to n do
  begin
    for j:=1 to n do
      read(map[i,j]);
    readln;
  end;
  vis[1]:=true;
  for i:=2 to n do
    dis[i]:=map[1,i];
  fiber:=0;
  for i:=1 to n-1 do
  begin
    min:=maxlongint;
    for j:=1 to n do
      if not vis[j] and (dis[j]<min) then
      begin
        min:=dis[j];
        oj:=j;
      end;
    inc(fiber,dis[oj]);
    vis[oj]:=true;
    for j:=1 to n do
      if not vis[j] and (map[oj,j]<dis[j]) then
        dis[j]:=map[oj,j];
  end;
  writeln(fiber);
  close(output);
end.