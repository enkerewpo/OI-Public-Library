{
ID:asiapea1
PROG:milk2
LANG:PASCAL
}
var
  a:array[1..1000000]of 0..1;
  f1,f2:text;
  min,n,t,max,max1,max2,i,j,t1,t2:longint;
begin
  assign(f1,'milk2.in');
  reset(f1);
  readln(f1,n);
  fillchar(a,sizeof(a),0);
  max:=0;
  min:=-1;
  for i:=1 to n do
    begin
      readln(f1,t1,t2);
      for j:=t1 to t2-1 do
        a[j]:=1;
      if t2-1>max then max:=t2-1;
      if (t1<min) or (min=-1) then min:=t1;
    end;
  close(f1);
  max1:=0;max2:=0;
  i:=min-1;
  while i<max do
    begin
      t:=1;
      i:=i+1;
      while (a[i+1]=a[i]) and (i<max) do
        begin
          inc(i);
          inc(t);
        end;
      if a[i]=1 then if max1<t then max1:=t else
                else if max2<t then max2:=t;
    end;
  assign(f2,'milk2.out');
  rewrite(f2);
  writeln(f2,max1,' ',max2);
  close(f2);
end.