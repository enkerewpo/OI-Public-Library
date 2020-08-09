{
ID:asiapea1
PROB:lamps
LANG:PASCAL
}
var
  f1,f2:text;
  a,b:array[1..100]of -1..1;
  c:array[1..8,1..100]of 0..1;
  i,j,x,y,n,t,cc,time:longint;
Procedure King;
  var
    i,j:integer;
    f:boolean;
    begin
      for i:=1 to n do
        if (a[i]<>-1) and (a[i]<>b[i]) then exit;
      for i:=1 to time do
        begin
          f:=true;
          for j:=1 to n do
            if c[i,j]<>b[j] then f:=false;
          if f then exit;
        end;
      inc(time);
      for i:=1 to n do c[time,i]:=b[i];
    end;
  Function Large(t1,t2:integer):boolean;
  var
    i:integer;
    begin
      i:=1;
      while c[t1,i]=c[t2,i] do inc(i);
      if c[t1,i]>c[t2,i] then Large:=true
                         else Large:=false;
    end;
begin
  assign(f1,'lamps.in');
  reset(f1);
  readln(f1,n);
  readln(f1,cc);
  read(f1,t);
  for i:=1 to n do a[i]:=-1;
  while t<>-1 do
    begin
      a[t]:=1;
      read(f1,t);
    end;
  readln(f1);
  read(f1,t);
  while t<>-1 do
    begin
      a[t]:=0;
      read(f1,t);
    end;
  close(f1);
  assign(f2,'lamps.out');
  rewrite(f2);
  time:=0;
  for i:=0 to 1 do
    for j:=0 to 1 do
      for x:=0 to 1 do
        for y:=0 to 1 do
          if (odd(i+j+x+y)=odd(cc)) and (i+j+x+y<=cc) then begin
            fillchar(b,sizeof(b),1);
            if i=1 then for t:=1 to n do
                          b[t]:=(b[t]+1) mod 2;
            if j=1 then for t:=1 to (n+(n mod 2)) div 2 do
                          b[t*2-1]:=(b[t*2-1]+1) mod 2;
            if x=1 then for t:=1 to (n+(n mod 2)) div 2 do
                          b[t*2]:=(b[t*2]+1) mod 2;
            if y=1 then for t:=1 to (n+3-(n mod 3)) div 3 do
                          b[t*3-2]:=(b[t*3-2]+1) mod 2;
            king;
          end;
  for i:=1 to time-1 do
    for j:=i+1 to time do
      if large(i,j) then begin
                           for x:=1 to n do
                             begin
                               y:=c[i,x];c[i,x]:=c[j,x];c[j,x]:=y;
                             end;
                         end;
  for i:=1 to time do
    begin
      for j:=1 to n do write(f2,c[i,j]);
      writeln(f2);
    end;
  if time=0 then writeln(f2,'IMPOSSIBLE');
  close(f2);
  // Insert user code here
end.