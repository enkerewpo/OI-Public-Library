{
ID:asiapeak1
PROG:butter
LANG:PASCAL
}
program butter;
const
  oo=$FFFFFFFF;
type
  link=^node;
  node=
  record
    b:word;
    dis:dword;
    next:link;
  end;
  data=
  record
    pi:word;
    dis:dword;
  end;
var
  cow:array[1..500]of word;
  n,p,c,i,j,a,b,d:word;
  e:array[1..800]of link;
  t:link;
  dis:array[1..500,1..800]of dword;
  tot,re,empt:dword;
  heap:array[1..1500]of data;
  sw:data;
  tick:array[1..800]of boolean;
//
procedure add (pi:word;dis:dword);
var
  i:word;
begin
  heap[empt].dis:=dis;
  heap[empt].pi:=pi;
  i:=empt;
  while (i>1) and (heap[i div 2].dis>heap[i].dis) do
  begin
    sw:=heap[i];
    heap[i]:=heap[i div 2];
    heap[i div 2]:=sw;
    i:=i div 2;
  end;
  while heap[empt].dis<>oo do
    inc(empt);
end;
//
procedure fix (s:word);
var
  a,b:word;
begin
  a:=s*2;
  b:=a+1;
  if (heap[a].dis=oo) and (heap[b].dis=oo) or (a>1500) then
  begin
    if s<empt then
      empt:=s;
    heap[s].dis:=oo;
    exit;
  end;
  if heap[a].dis>heap[b].dis then
  begin
    heap[s]:=heap[b];
    fix(b);
  end
  else
  begin
    heap[s]:=heap[a];
    fix(a);
  end;
end;
//
procedure dijkstra (cowi:word);
var
  i,pi:word;
  pdis:dword;
begin
  fillchar(tick,sizeof(tick),false);
  for i:=1 to 1500 do
    heap[i].dis:=oo;
  empt:=1;
  add(cow[cowi],0);
  for i:=1 to p do
  begin
    repeat
      pi:=heap[1].pi;
      pdis:=heap[1].dis;
      fix(1);
    until not tick[pi];
    dis[cowi,pi]:=pdis;
    tick[pi]:=true;
    t:=e[pi];
    while t<>nil do
    begin
      if not tick[t^.b] then
        add(t^.b,t^.dis+dis[cowi,pi]);
      t:=t^.next;
    end;
  end;
end;
//
begin
  assign(input,'butter.in');
  assign(output,'butter.out');
  reset(input);
  rewrite(output);
  readln(n,p,c);
  for i:=1 to n do
    readln(cow[i]);
  for i:=1 to c do
  begin
    readln(a,b,d);
    new(t);
    t^.b:=b;
    t^.dis:=d;
    t^.next:=e[a];
    e[a]:=t;
    new(t);
    t^.b:=a;
    t^.dis:=d;
    t^.next:=e[b];
    e[b]:=t;
  end;
  for i:=1 to n do
    dijkstra(i);
  re:=oo;
  for i:=1 to p do
  begin
    tot:=0;
    for j:=1 to n do
      inc(tot,dis[j,i]);
    if tot<re then
      re:=tot;
  end;
  writeln(re);
  close(output);
end.