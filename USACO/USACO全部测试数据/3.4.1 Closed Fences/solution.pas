{
ID: asiapea1
PROG: fence4
LANG: PASCAL
}
var
  ox,oy:smallint;
  n,i,j,cc:byte;
  x,y:array[0..202]of smallint;
  seen:array[1..200]of boolean;
const
  e=1e-5;
//
function cross1 (x1,y1,x2,y2,x3,y3,x4,y4:real):boolean;
var
  s1,s2,s3:real;
begin
  s1:=(x4-x3)*(y1-y3)-(x1-x3)*(y4-y3);
  s2:=(x3-x1)*(y2-y1)-(x2-x1)*(y3-y1);
  s3:=(x2-x1)*(y4-y3)-(x4-x3)*(y2-y1);
  if s3<0 then
  begin
    s1:=-s1;
    s2:=-s2;
    s3:=-s3;
  end;
  if (s1>0) and (s2>0) and (s1<s3) and (s2<s3) then
    exit(true)
  else
    exit(false);
end;
//
function side (x1,y1,x2,y2,x3,y3:real):shortint;
var
  t:real;
begin
  t:=(x3-x2)*(y1-y2)-(x1-x2)*(y3-y2);
  if t>e then
    exit(1);
  if t<-e then
    exit(-1);
  exit(0);
end;
//
procedure cross2 (x1,y1,x2,y2:real);
var
  s1,s2,s3,fx,fy,s,ts,ml,mr,mm:real;
  i,oi,l,r:byte;
  t1,t2:shortint;
begin
  ml:=1e100;
  mr:=1e100;
  mm:=1e100;
  oi:=0;
  for i:=1 to n do
  begin
    s1:=(x[i+1]-x[i])*(y1-y[i])-(x1-x[i])*(y[i+1]-y[i]);
    s2:=(x[i]-x1)*(y2-y1)-(x2-x1)*(y[i]-y1);
    s3:=(x2-x1)*(y[i+1]-y[i])-(x[i+1]-x[i])*(y2-y1);
    if s3<-e then
    begin
      s1:=-s1;
      s2:=-s2;
      s3:=-s3;
    end;
    if (s1>e) and (s2>=0) and (s2<=s3) then
    begin
      if abs(s3)>e then
      begin
        fx:=x1+(x2-x1)*s1/s3;
        fy:=y1+(y2-y1)*s1/s3;
        s:=sqr(fx-ox)+sqr(fy-oy);
      end
      else
      begin
        fx:=x[i];
        fy:=y[i];
        s:=sqr(fx-ox)+sqr(fy-oy);
        fx:=x[i+1];
        fy:=y[i+1];
        ts:=sqr(fx-ox)+sqr(fy-oy);
        if ts<s then
          s:=ts;
      end;
      if (s2>e) and (s2<s3-e) then
      begin
        if s<mm then
        begin
          mm:=s;
          oi:=i;
        end;
        continue;
      end;
      if s2<e then
      begin
        l:=i-1;
        r:=i+1;
      end
      else
      begin
        l:=i;
        r:=i+2;
      end;
      t1:=side(x[l],y[l],x1,y1,x2,y2);
      t2:=side(x[r],y[r],x1,y1,x2,y2);
      if (t1>0) and (t2<0) then
        if s<mm then
        begin
          mm:=s;
          oi:=i;
        end;
      if (t1>=0) and (t2>=0) then
        if s<mr then
          mr:=s;
      if (t1<=0) and (t2<=0) then
        if s<ml then
          ml:=s;
    end;
  end;
  if (mm<mr) or (mm<ml) then
    seen[oi]:=true;
end;
//
begin
  assign(input,'fence4.in');
  assign(output,'fence4.out');
  reset(input);
  rewrite(output);
  readln(n);
  readln(ox,oy);
  for i:=1 to n do
    readln(x[i],y[i]);
  x[n+1]:=x[1];
  y[n+1]:=y[1];
  x[n+2]:=x[2];
  y[n+2]:=y[2];
  x[0]:=x[n];
  y[0]:=y[n];
  for i:=1 to n-1 do
    for j:=i+1 to n do
      if cross1(x[i],y[i],x[i+1],y[i+1],x[j],y[j],x[j+1],y[j+1]) then
      begin
        writeln('NOFENCE');
        close(output);
        halt;
      end;
  for i:=1 to n do
  begin
    cross2(ox,oy,x[i],y[i]);
    cross2(ox,oy,(x[i]+x[i+1])/2,(y[i]+y[i+1])/2);
  end;
  cc:=0;
  for i:=1 to n do
    if seen[i] then
      inc(cc);
  writeln(cc);
  for i:=1 to n-2 do
    if seen[i] then
      writeln(x[i],' ',y[i],' ',x[i+1],' ',y[i+1]);
  if seen[n] then
    writeln(x[1],' ',y[1],' ',x[n],' ',y[n]);
  if seen[n-1] then
    writeln(x[n-1],' ',y[n-1],' ',x[n],' ',y[n]);
  close(output);
end.