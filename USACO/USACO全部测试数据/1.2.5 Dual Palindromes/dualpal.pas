{
ID:asiapea1
PROG:dualpal
LANG:PASCAL
}
var
  i,s,n:longint;
  f1,f2:text;
  Function king(s:longint):boolean;
    var
      i,j,m:longint;
      time:integer;
      a:array[1..100]of integer;
      f:boolean;
    begin
      king:=true;
      time:=0;
      for i:=2 to 10 do
        begin
          m:=s;j:=0;
          repeat
            inc(J);
            a[j]:=m mod i;
            m:=m div i;
          until m=0;
          f:=true;
          for m:=1 to j div 2 do
            if a[m]<>a[j-m+1] then begin
                                     f:=false;
                                     break;
                                   end;
          if f then time:=time+1;
          if time=2 then exit;
        end;
      king:=false;
    end;
begin
  assign(f1,'dualpal.in');
  reset(f1);
  readln(f1,n,s);
  close(f1);
  assign(f2,'dualpal.out');
  rewrite(f2);
  for i:=1 to n do
    begin
      repeat
        inc(s);
      until king(s);
      writeln(f2,s);
    end;
  close(f2);
  // Insert user code here
end.