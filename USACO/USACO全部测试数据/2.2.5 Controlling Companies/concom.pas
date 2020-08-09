{
ID: asiapea1
PROG: concom
LANG: PASCAL
}
var
  n,i:word;
  a,b,c,m:byte;
  vis,own:array[1..100]of boolean;
  cx:array[1..100]of byte;
  con:array[1..100,1..100]of byte;
//
procedure DFS (s:byte);
var
  i:byte;
begin
  if vis[s] then
    exit;
  vis[s]:=true;
  for i:=1 to m do
  begin
    inc(cx[i],con[s,i]);
    if cx[i]>50 then
    begin
      own[i]:=true;
      DFS(i);
    end;
  end;
end;
//
begin
  assign(input,'concom.in');
  assign(output,'concom.out');
  reset(input);
  rewrite(output);
  readln(n);
  for i:=1 to n do
  begin
    readln(a,b,c);
    if a>m then
      m:=a;
    if b>m then
      m:=b;
    inc(con[a,b],c);
  end;
  for a:=1 to m do
  begin
    fillchar(cx,sizeof(cx),0);
    fillchar(vis,sizeof(vis),false);
    fillchar(own,sizeof(own),false);
    own[a]:=true;
    DFS(a);
    for b:=1 to m do
      if own[b] and (b<>a) then
        writeln(a,' ',b);
  end;
  close(output);
end.