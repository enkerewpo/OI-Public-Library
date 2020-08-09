{
ID: asiapea1
PROG: inflate
LANG: PASCAL
}
type
  link=^node;
  node=
  record
    p,m:word;
    next:link;
  end;
var
  m,n,i,j,pi,mi:word;
  re:dword;
  dp:array[0..10000] of dword;
  h,p,t:link;
  add:boolean;
//
function max (a,b:dword):dword;
begin
  if a>b then
    exit(a)
  else
    exit(b);
end;
//
begin
  assign(input,'inflate.in');
  assign(output,'inflate.out');
  reset(input);
  rewrite(output);
  readln(m,n);
  new(h);
  h^.next:=nil;
  for i:=1 to n do
  begin
    readln(pi,mi);
    t:=h;
    p:=t^.next;
    add:=true;
    while p<>nil do
    begin
      if (pi<=p^.p) and (mi>=p^.m) then
      begin
        add:=false;
        break;
      end;
      if (pi>p^.p) and (mi<p^.m) then
      begin
        t^.next:=p^.next;
        dispose(p);
        p:=t^.next;
      end
      else
      begin
        t:=p;
        p:=p^.next;
      end;
    end;
    if add then
    begin
      new(p);
      p^.p:=pi;
      p^.m:=mi;
      p^.next:=nil;
      t^.next:=p;
    end;
  end;
  t:=h;
  p:=t^.next;
  while p<>nil do
  begin
    pi:=p^.p;
    mi:=p^.m;
    for j:=mi to m do
      dp[j]:=max(dp[j],dp[j-mi]+pi);
    t:=p;
    p:=p^.next;
  end;
  re:=0;
  for i:=0 to m do
    re:=max(dp[i],re);
  writeln(re);
  close(output);
end.