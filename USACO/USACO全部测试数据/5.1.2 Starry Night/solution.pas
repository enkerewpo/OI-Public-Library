{
ID: asiapea1
PROG: starry
LANG: PASCAL
}
program starry;
type
  cluster=array[0..101,0..101]of integer;
const
  d:array[1..8,1..2]of integer=((0,1),(1,1),(1,0),(1,-1),
                                (0,-1),(-1,-1),(-1,0),(-1,1));
var
  i,j,k,m,n,width,height,ans:longint;
  p:array[1..300]of cluster;
  map:array[0..101,0..101]of char;
  q:array[1..500000,1..2]of integer;
  h,w:array[1..300]of integer;
  v:array[0..101,0..101]of boolean;
 
function same(a,b:cluster;ha,wa:longint):boolean;
var
  i,j:longint;
begin
  for i:=1 to ha do
    for j:=1 to wa do if a[i,j]<>b[i,j] then exit(false);
  exit(true);
end;
 
procedure swap(var a,b:longint);
var
  k:longint;
begin
  k:=a;
  a:=b;
  b:=k;
end;
 
function max(a,b:longint):longint;
begin
  if a>b then max:=a else max:=b;
end;
 
function min(a,b:longint):longint;
begin
  if a<b then min:=a else min:=b;
end;
 
procedure turnright(var a:cluster;var ha,wa:longint);
var
  i,j:longint;
  b:cluster;
begin
  fillchar(b,sizeof(b),0);
  for i:=1 to ha do
    for j:=1 to wa do
    b[j,ha-i+1]:=a[i,j];
  a:=b;
  swap(ha,wa);
end;
 
procedure turnopposite(var a:cluster;var ha,wa:longint);
var
  i,j:longint;
  b:cluster;
begin
  fillchar(b,sizeof(b),0);
  for i:=1 to ha do
    for j:=1 to wa do
    b[i,wa-j+1]:=a[i,j];
  a:=b;
end;
 
procedure printmap;
var
  i,j:longint;
begin
  for i:=1 to height do
  begin
    for j:=1 to width do write(map[i,j]);
    writeln;
  end;
end;
 
procedure bfs(a,b:longint);
var
  i,j,l,r,x,y,x1,y1,minh,minw,maxh,maxw,nh,nw:longint;
  nc:cluster;
 
  procedure color(x:char);
  var
    i:longint;
  begin
    for i:=1 to r do map[q[i,1],q[i,2]]:=x;
  end;
 
begin
  l:=1;
  r:=1;
  q[l,1]:=a;
  q[l,2]:=b;
  v[a,b]:=true;
  while l<=r do
  begin
    x:=q[l,1];
    y:=q[l,2];
    for i:=1 to 8 do
    begin
      x1:=x+d[i,1];
      y1:=y+d[i,2];
      if (map[x1,y1]='1')and(not v[x1,y1]) then
      begin
        inc(r);
        q[r,1]:=x1;
        q[r,2]:=y1;
        v[x1,y1]:=true;
      end;
    end;
    inc(l);
  end;
  minh:=maxlongint;
  for i:=1 to r do minh:=min(minh,q[i,1]);
  minw:=maxlongint;
  for i:=1 to r do minw:=min(minw,q[i,2]);
  maxh:=-maxlongint;
  for i:=1 to r do maxh:=max(maxh,q[i,1]);
  maxw:=-maxlongint;
  for i:=1 to r do maxw:=max(maxw,q[i,2]);
  nh:=maxh-minh+1;//当前连通块的高
  nw:=maxw-minw+1;//当前连通块的宽
 
  fillchar(nc,sizeof(nc),0);//当前的连通块
  for i:=1 to r do
  begin
    x:=q[i,1]-minh+1;
    y:=q[i,2]-minw+1;
    nc[x,y]:=1;
  end;
 
  for i:=1 to 4 do
  begin
    for j:=1 to ans do if (nh=h[j])and(nw=w[j])and(same(p[j],nc,nh,nw)) then
    begin
      color(chr(j+96));
      exit;
    end;
    turnright(nc,nh,nw);//顺时针转90度
  end;
  turnopposite(nc,nh,nw);//对称反转
  for i:=1 to 4 do
  begin
    for j:=1 to ans do if (nh=h[j])and(nw=w[j])and(same(p[j],nc,nh,nw)) then
    begin
      color(chr(j+96));
      exit;
    end;
    if i<>4 then turnright(nc,nh,nw);
  end;
 
  inc(ans);
  p[ans]:=nc;//新的cluster
  h[ans]:=nh;//新的cluster的高
  w[ans]:=nw;//新的cluster的宽
  color(chr(ans+96));
end;
 
begin
  assign(input,'starry.in');
  reset(input);
  assign(output,'starry.out');
  rewrite(output);
 
  //prepare
  for i:=0 to 101 do
    for j:=0 to 101 do map[i,j]:='0';
  fillchar(v,sizeof(v),false);
  ans:=0;
  //input
  readln(width);
  readln(height);
  for i:=1 to height do
  begin
    for j:=1 to width do read(map[i,j]);
    readln;
  end;
 
  //floodfill
  for i:=1 to height do
    for j:=1 to width do if map[i,j]='1' then
      bfs(i,j);
 
  //print
  printmap;
  close(input);
  close(output);
end.