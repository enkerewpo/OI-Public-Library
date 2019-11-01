program hxy;
Const maxn=1000;
      maxw=1000000;
      infile='weight.in';
      outfile='weight.out';
Var a:array[1..2*maxn]of longint;
    used:array[1..2*maxn]of boolean;
    bool:array[0..maxn]of boolean;
    Ans:array[0..maxn]of longint;
    n,m,Tot,wHead,wNil:longint;
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
procedure DataIn;
var i,j:longint;
begin
  fillchar(bool,sizeof(bool),0);
  fillchar(used,sizeof(used),0);
  Tot:=0;
  readln(n,m);
  for i:=1 to m do
  begin
    read(j);
    bool[j]:=true;
  end;
  readln;
  for i:=1 to 2*n do
  begin
    read(a[i]);
    if a[i]>Tot then Tot:=a[i];
  end;
  readln;
  Qsort(1,2*n);
  wHead:=0;  wNil:=0;
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
procedure Try(x,y:longint);
var i,j,k,step:longint;
begin
  if x+2=y then
  begin
    Ans[x+1]:=Tot-wHead-wNil;
    OutAns;
    halt
  end;
  step:=x+(n-y+1)+1;
  if (bool[a[step]-wHead]) then
  begin
    Ans[x+1]:=a[step]-wHead;
    wHead:=a[step];
    Try(x+1,y);
    dec(wHead,Ans[x+1]);
  end;
  if bool[a[step]-wNil] then
  begin
    Ans[y-1]:=a[step]-wNil;
    wNil:=a[step];
    Try(x,y-1);
    dec(wNil,Ans[y-1]);
  end;
end;
begin
  assign(input,infile);
  reset(input);
  DataIn;
  Try(0,n+1);
  close(input);
end.
