{
PROG: fence3
LANG: PASCAL
ID: asiapea1
}
 
program fence3;
const
  maxf=150;
  zero=1e-5;
var
  fin,fout:text;
  x1,y1,x2,y2:array[1..maxf]of byte;
  f,i:byte;
  x,y,best:real;
function min(a,b:real):real;
  begin
    if a<b then min:=a else min:=b;
  end;
function dist(x,y:real;fence:byte):real;
  begin
    if x1[fence]=x2[fence] then
      if (y-y1[fence])*(y-y2[fence])<=zero then
        dist:=abs(x-x1[fence])
      else
        dist:=min(sqrt(sqr(x-x1[fence])+sqr(y-y1[fence])),
                  sqrt(sqr(x-x2[fence])+sqr(y-y2[fence])))
    else
      if (x-x1[fence])*(x-x2[fence])<=zero then
        dist:=abs(y-y1[fence])
      else
        dist:=min(sqrt(sqr(x-x1[fence])+sqr(y-y1[fence])),
                  sqrt(sqr(x-x2[fence])+sqr(y-y2[fence])));
  end;
procedure try(cx,cy,range,step:real);
  var
    i,j,l:real;
    k:byte;
  begin
    i:=cx-range;
    repeat
      j:=cy-range;
      repeat
        l:=0;
        for k:=1 to f do
          l:=l+dist(i,j,k);
        if l<best then begin
          x:=i;y:=j;best:=l;
        end;
        j:=j+step;
      until j>cy+range+zero;
      i:=i+step;
    until i>cx+range+zero;
  end;
begin
  assign(fin,'fence3.in');
  reset(fin);
  readln(fin,f);
  for i:=1 to f do
    readln(fin,x1[i],y1[i],x2[i],y2[i]);
  close(fin);
 
  x:=50;y:=50;best:=maxint;
  try(x,y,50,10);
  try(x,y,10,1);
  try(x,y,1,0.1);
 
  assign(fout,'fence3.out');
  rewrite(fout);
  writeln(fout,x:0:1,' ',y:0:1,' ',best:0:1);
  close(fout);
end.