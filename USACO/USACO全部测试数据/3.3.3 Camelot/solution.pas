{
ID: asiapea1
PROG: camelot
LANG: PASCAL
}
const
  dx:array[1..8]of shortint=(1,2,2,1,-1,-2,-2,-1);
  dy:array[1..8]of shortint=(2,1,-1,-2,-2,-1,1,2);
var
  ii,jj,i,j,fx,ex,fy,ey:shortint;
  k,n,g,d,re,vx,vy:word;
  r,c,kx,ky:byte;
  x,y:array[1..1040]of byte;
  km:array[1..26,1..40]of byte;
  dis:array[1..26,1..40,1..26,1..40]of byte;
  ch,bk:char;
//
procedure fill (sx,sy:byte);
var
  f,e,mx:word;
  i,st:byte;
  tx,ty:shortint;
  slot:array[1..1040,1..2]of byte;
begin
  f:=1;
  e:=2;
  mx:=1;
  st:=1;
  slot[f,1]:=sx;
  slot[f,2]:=sy;
  dis[sx,sy,sx,sy]:=0;
  repeat
    for i:=1 to 8 do
    begin
      tx:=slot[f,1]+dx[i];
      ty:=slot[f,2]+dy[i];
      if (tx>=1) and (tx<=c) and (ty>=1) and (ty<=r) and (dis[sx,sy,tx,ty]=$FF) then
      begin
        slot[e,1]:=tx;
        slot[e,2]:=ty;
        dis[sx,sy,tx,ty]:=st;
        inc(e);
      end;
    end;
    inc(f);
    if f>mx then
    begin
      inc(st);
      mx:=e-1;
    end;
  until f=e;
end;
//
function min (a,b:word):word;
begin
  if a>b then
    exit(b)
  else
    exit(a);
end;
//
begin
  assign(input,'camelot.in');
  assign(output,'camelot.out');
  reset(input);
  rewrite(output);
  readln(r,c);
  readln(ch,bk,ky);
  kx:=ord(ch)-64;
  km[kx,ky]:=0;
  for i:=1 to c do
    for j:=1 to r do
      if abs(i-kx)>abs(j-ky) then
        km[i,j]:=abs(i-kx)
      else
        km[i,j]:=abs(j-ky);
  n:=0;
  while not eof do
  begin
    inc(n);
    read(ch,bk,y[n]);
    x[n]:=ord(ch)-64;
    if eoln then
      readln
    else
      read(bk);
  end;
  fillchar(dis,sizeof(dis),$FF);
  re:=maxsmallint*2+1;
  vx:=kx;
  vy:=ky;
  for k:=1 to n do
  begin
    inc(vx,x[k]);
    inc(vy,y[k]);
  end;
  vx:=vx div (n+1);
  vy:=vy div (n+1);
  if n>1 then
  begin
    fx:=vx-2;
    ex:=vx+2;
    fy:=vy-2;
    ey:=vy+2;
  end
  else
  begin
    fx:=1;
    ex:=c;
    fy:=1;
    ey:=r;
  end;
  for i:=fx to ex do
    for j:=fy to ey do
      if (i>=1) and (i<=c) and (j>=1) and (j<=r) then
        fill(i,j);
  for ii:=kx-1 to kx+1 do
    for jj:=ky-1 to ky+1 do
      if (ii>=1) and (ii<=c) and (jj>=1) and (jj<=r) then
        fill(ii,jj);
  for i:=fx to ex do
    for j:=fy to ey do
      if (i>=1) and (i<=c) and (j>=1) and (j<=r) then
      begin
        g:=0;
        for k:=1 to n do
          inc(g,dis[i,j,x[k],y[k]]);
        if g>re then
          continue;
        d:=km[i,j];
        for ii:=kx-1 to kx+1 do
          for jj:=ky-1 to ky+1 do
            if (ii>=1) and (ii<=c) and (jj>=1) and (jj<=r) then
              for k:=1 to n do
                d:=min(d,dis[ii,jj,x[k],y[k]]+dis[ii,jj,i,j]+km[ii,jj]-dis[i,j,x[k],y[k]]);
        g:=g+d;
        re:=min(re,g);
      end;
  writeln(re);
  close(output);
end.