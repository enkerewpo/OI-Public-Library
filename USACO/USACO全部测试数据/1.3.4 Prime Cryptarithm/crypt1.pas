{
ID:asiapea1
PROG:crypt1
LANG:PASCAL
}
var
  i,j,n,time,x:longint;
  s:set of 1..9;
  f1,f2:text;
  f:boolean;
  Function RIght(k:longint):boolean;
  var
    w:longint;
    begin
      right:=false;
      repeat
        w:=k mod 10;
        k:=k div 10;
        if not(w in s) then exit;
      until k=0;
      right:=true;
    end;
begin
  assign(f1,'crypt1.in');
  reset(f1);
  readln(f1,n);
  s:=[];
  for i:=1 to n do
    begin
      read(f1,x);
      s:=s+[x];
    end;
  close(f1);
  time:=0;
  for i:=111 to 999 do
    if right(i) then
      for j:=11 to 99 do
        if right(j) then
            begin
              f:=true;
              x:=(j mod 10)*i;
              if (x>=1000) or (not right(x)) then f:=false;
              x:=(j div 10)*i;
              if (x>=1000) or (not right(x)) then f:=false;
              x:=j*i;
              if (x>=10000) or (not right(x)) then f:=false;
              if f then inc(time);
            end;
  assign(f2,'crypt1.out');
  rewrite(f2);
  writeln(f2,time);
  close(f2);
  // Insert user code here
end.