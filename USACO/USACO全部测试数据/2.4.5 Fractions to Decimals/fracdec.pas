{
ID:asiapea1
PROG:fracdec
LANG:PASCAL
}
var
  a:array[0..100000]of longint;
  b:array[1..100000]of integer;
  f1,f2:text;
  time,t1,t2,f,t,i:longint;
begin
  assign(f1,'fracdec.in');
  reset(f1);
  readln(f1,t1,t2);
  close(f1);
  assign(f2,'fracdec.out');
  rewrite(f2);
  time:=0;
  i:=t1 div t2;
  write(f2,t1 div t2);
  repeat
    inc(time);
    i:=i div 10;
  until i=0;
  write(f2,'.');
  inc(time);
  t1:=t1 mod t2;fillchar(a,sizeof(a),0);
  t:=1;a[t1]:=t;
  b[t]:=(t1*10) div t2;
  repeat
    t1:=(t1*10) mod t2;
    inc(t);
    b[t]:=(t1*10) div t2;
    f:=0;if a[t1]<>0 then f:=a[t1] else a[t1]:=t;
  until (f<>0) or (t1=0);
  if t1=0 then begin
                 for i:=1 to t-1 do
                   begin
                     if time mod 76=0 then begin
                                             writeln(f2);
                                             time:=0;
                                           end;
                     inc(time);
                     write(f2,b[i]);
                   end;
                 writeln(f2);
                 close(f2);
                 exit;
               end;
  for i:=1 to f-1 do
    begin
      if time mod 76=0 then begin
       writeln(f2);
       time:=0;
       end;
       inc(time);
      write(f2,b[i]);
    end;
  write(f2,'(');
  inc(time);
  if time=76 then begin
  writeln(f2);
  time:=1;
  end;
  for i:=f to t-1 do
    begin
      if time mod 76=0 then begin
      writeln(f2);
      time:=0;
      end;
      inc(time);
      write(f2,b[i]);
    end;
  writeln(f2,')');
  close(f2);
  // Insert user code here
end.