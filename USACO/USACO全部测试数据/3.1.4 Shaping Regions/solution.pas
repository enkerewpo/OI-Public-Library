{
ID: asiapea1
PROG: rect1
LANG: PASCAL
}
program rect1;
var
  rectx,recty:array[-1..2001] of longint;
  insertedx,insertedy:array[0..10000] of boolean;
  region:array[0..1000,1..5] of longint;  //1-x1,2-y1,3-x2,4-y2,5-color
  color,next:array[0..2001,-1..2001] of integer;
  area:array[1..2500] of longint;
  i,j,k,t,n,zx,zy:longint;
 
procedure sortx;
var
  i,j,t:longint;
  f:boolean;
begin
  for i:=1 to zx do begin
    f:=true;
    for j:=1 to zx-i do if rectx[j]>rectx[j+1] then begin
      t:=rectx[j]; rectx[j]:=rectx[j+1]; rectx[j+1]:=t; f:=false;
    end;
    if f then break;
  end;
end;
 
procedure sorty;
var
  i,j,t:longint;
  f:boolean;
begin
  for i:=1 to zy do begin
    f:=true;
    for j:=1 to zy-i do if recty[j]>recty[j+1] then begin
      t:=recty[j]; recty[j]:=recty[j+1]; recty[j+1]:=t; f:=false;
    end;
    if f then break;
  end;
end;
 
begin
  assign(input,'rect1.in'); reset(input);
  assign(output,'rect1.out'); rewrite(output);
  rectx[0]:=0; recty[0]:=0; zx:=1; zy:=1;
  readln(rectx[1],recty[1],n);
  region[0,1]:=0; region[0,2]:=0; region[0,3]:=rectx[1]; region[0,4]:=recty[1]; region[0,5]:=1;
  insertedx[0]:=true; insertedx[rectx[1]]:=true; insertedy[0]:=true; insertedy[recty[1]]:=true;
  for i:=1 to n do begin
    readln(region[i,1],region[i,2],region[i,3],region[i,4],region[i,5]);
    if not insertedx[region[i,1]] then begin insertedx[region[i,1]]:=true; inc(zx); rectx[zx]:=region[i,1]; end;  //以下4行全是打格子
    if not insertedy[region[i,2]] then begin insertedy[region[i,2]]:=true; inc(zy); recty[zy]:=region[i,2]; end;
    if not insertedx[region[i,3]] then begin insertedx[region[i,3]]:=true; inc(zx); rectx[zx]:=region[i,3]; end;
    if not insertedy[region[i,4]] then begin insertedy[region[i,4]]:=true; inc(zy); recty[zy]:=region[i,4]; end;
  end;
  sortx;
  sorty;
  rectx[-1]:=-1;
  for i:=0 to zy do
    for j:=-1 to zx do next[i,j]:=j+1;  //链表初始化
  for k:=n downto 0 do begin
    i:=0;
    while recty[i]<region[k,2] do inc(i);  //找到矩形所在的第一行
    while recty[i]<region[k,4] do begin
      j:=-1;   //我建立坐标时有第0列，所以要用next[-1]来表示这一行开放的第一列
      while rectx[j]<region[k,1] do begin  //找到矩形所在的第一列（开放的第一列）
        t:=j; j:=next[i,j];
      end;
      while rectx[j]<region[k,3] do begin
        color[i,j]:=region[k,5]; j:=next[i,j];
      end;
      next[i,t]:=j;  //将刚刚染过色的格子封闭，以后的染色不会再访问到
      inc(i);
    end;
  end;
  for i:=0 to zy-1 do
    for j:=0 to zx-1 do
      inc(area[color[i,j]],(recty[i+1]-recty[i])*(rectx[j+1]-rectx[j]));
  for i:=1 to 2500 do
    if area[i]>0 then writeln(i,' ',area[i]);
  close(input); close(output);
end.