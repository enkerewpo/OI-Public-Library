{
PROG: snail
LANG: PASCAL
ID: asiapea1
}
program snail_sd;
type
  direction=(up,down,left,right);
const
  maxn=120;
  dx:array[direction]of shortint=(-1,1,0,0);
  dy:array[direction]of shortint=(0,0,-1,1);
var
  fin,fout:text;
  map:array[0..maxn+1,0..maxn+1]of char;
  n,b,i,j:byte;
  now,best:integer;
  c:char;
procedure search(x0,y0:byte;d:direction);
  var
    x,y:byte;
  begin
    x:=x0;y:=y0;
    if map[x+dx[d],y+dy[d]]<>'.' then exit;
    repeat
    inc(x,dx[d]);inc(y,dy[d]);
      map[x,y]:='x';
      inc(now);
    until map[x+dx[d],y+dy[d]]<>'.';
    if now>best then best:=now;
    if map[x+dx[d],y+dy[d]]<>'x' then begin
      search(x,y,up);
      search(x,y,down);
      search(x,y,left);
      search(x,y,right);
    end;
    while (x<>x0) or (y<>y0) do begin
      dec(now);
      map[x,y]:='.';
      dec(x,dx[d]);dec(y,dy[d]);
    end;
  end;
begin
  assign(fin,'snail.in');
  reset(fin);
  readln(fin,n,b);
  for i:=1 to n do begin
    map[0,i]:='#';
    map[n+1,i]:='#';
    map[i,0]:='#';
    map[i,n+1]:='#';
  end;
  for i:=1 to n do
    for j:=1 to n do
      map[i,j]:='.';
  for i:=1 to b do begin
    read(fin,c);
    readln(fin,j);
    map[j,ord(c)-64]:='#';
  end;
  close(fin);
 
  best:=1;now:=1;
  map[1,1]:='x';
  search(1,1,down);
  search(1,1,right);
 
  assign(fout,'snail.out');
  rewrite(fout);
  writeln(fout,best);
  close(fout);
end.