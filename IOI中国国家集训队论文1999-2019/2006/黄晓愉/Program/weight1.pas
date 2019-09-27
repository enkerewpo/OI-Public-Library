program hxy;
Const maxn=1000;
      maxw=1000000;
      infile='weight.in';
      outfile='weight.out';
Var a:array[1..2*maxn]of longint;
    w:array[1..maxw]of integer;
    Ans:array[0..maxn]of longint;
    n,m,Tot,nw:longint;
procedure Qsort(x,y:longint);
var xx,yy,k:longint;
begin
  if x>=y then exit;
  xx:=x; yy:=y; k:=a[x];
  repeat
    while (xx<yy) and (k<=a[yy]) do dec(yy);
    if xx<yy then a[xx]:=a[yy];
    while (xx<yy) and (k>=a[xx]) do inc(xx);
    if xx<yy then a[yy]:=a[xx];
  until xx=yy;
  a[xx]:=k;
  Qsort(x,xx-1);
  Qsort(xx+1,y);
end;
procedure Getnew;
var i,j:longint;
begin
  j:=1;
  for i:=2 to m do
    if a[i]>a[j] then
    begin
      inc(j);
      a[j]:=a[i];
    end;
  m:=j;
end;
procedure DataIn;
var i,j:longint;
begin
  fillchar(w,sizeof(w),0);
  w[0]:=2;
  Tot:=0;
  readln(n,m);
  for i:=1 to m do read(a[i]);
  readln;
  Qsort(1,m);
  GeTnew;
  for i:=1 to 2*n do
  begin
    read(j); inc(w[j]);
    if j>Tot then Tot:=j;
  end;
  readln;
  nw:=0;
end;
procedure OutAns;
var i,j:longint;
begin
  assign(output,outfile);
  rewrite(output);
  for i:=1 to n-1 do write(Ans[i],' ');
  writeln(Ans[n]);
  close(output);
end;
procedure Try(x:longint);
var i,j,k,step:longint;
begin
  if x>n then begin
    OutAns;
    halt;
  end;
  for i:=1 to m do
    if (w[nw+a[i]]>0) and (w[Tot-nw-a[i]]>0) then
    begin
      dec(w[nw+a[i]]);
      dec(w[Tot-nw-a[i]]);
      inc(nw,a[i]);
      Ans[x]:=a[i];
      Try(x+1);
      dec(nw,a[i]);
      inc(w[nw+a[i]]);
      inc(w[Tot-nw-a[i]]);
    end;
end;
begin
  assign(input,infile);
  reset(input);
  DataIn;
  nw:=0;
  Try(1);
  close(input);
end.
