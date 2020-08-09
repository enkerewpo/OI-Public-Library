{
ID:asiapea1
PROG:ttwo
LANG:PASCAL
}
program ttwo;
type
  ttp=record
        x,y:integer;
      end;
var
  visit:array[1..10,1..10,1..4,1..10,1..10,1..4]of 0..1;
  a:array[0..11,0..11]of char;
  f1,f2:text;
  x1,y1,d1,x2,y2,d2,x3,y3,i,j:integer;
  time:longint;
  d:array[1..4]of ttp;
begin
  assign(f1,'ttwo.in');
  reset(f1);
  for i:=1 to 10 do
    begin
      for j:=1 to 10 do
        begin
          read(f1,a[i,j]);
          if a[i,j]='C' then begin
                               x1:=i;y1:=j;d1:=1;
                             end;
          if a[i,j]='F' then begin
                               x2:=i;y2:=j;d2:=1;
                             end;
        end;
      readln(f1);
    end;
  close(f1);
  assign(f2,'ttwo.out');
  rewrite(f2);
  for i:=1 to 10 do
    for j:=1 to 10 do
      for d1:=1 to 4 do
        for x3:=1 to 10 do
          for y3:=1 to 10 do
            for d2:=1 to 4 do
              visit[i,j,d1,x3,y3,d2]:=0;
  d1:=1;d2:=1;
  time:=0;
  d[1].x:=-1;d[1].y:=0;
  d[2].x:=0;d[2].y:=1;
  d[3].x:=1;d[3].y:=0;
  d[4].x:=0;d[4].y:=-1;
  repeat
    visit[x1,y1,d1,x2,y2,d2]:=1;
    inc(time);
    x3:=x1+d[d1].x;y3:=y1+d[d1].y;
    if (x3<=0) or (x3>10) or (y3<=0) or (y3>10) or (a[x3,y3]='*')
        then begin
               if d1=4 then d1:=1
                     else inc(d1);

             end
        else begin
               x1:=x3;y1:=y3;
             end;
    x3:=x2+d[d2].x;y3:=y2+d[d2].y;
    if (x3<=0) or (x3>10) or (y3<=0) or (y3>10) or (a[x3,y3]='*')
        then begin
               if d2=4 then d2:=1
                     else inc(d2);

             end
        else begin
               x2:=x3;y2:=y3;
             end;
  until (visit[x1,y1,d1,x2,y2,d2]=1) or ((x1=x2) and (y1=y2));
  if (x1=x2) and (y1=y2) then writeln(f2,time)
                         else writeln(f2,0);
  close(f2);
end.