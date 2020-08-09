{
ID:asiapea1
PROG:calfflac
LANG:PASCAL
}
const
  ph=['a'..'z','A'..'Z'];
var
  f1,f2:Text;
  a:array[1..20000]of char;
  x1,x2,max,t1,t2,t3,t4,i,j,n:integer;
  Function Right(t1,t2:integer;var t3,t4:integer):boolean;
  var
    i,j:integer;
    ch1,ch2:char;
    begin
      Right:=false;
      i:=t1-1;
      while (not (a[i] in ph)) and (i>0) do
        dec(i);
      if i<=0 then exit;
      j:=t2+1;
      while (not (a[j] in ph)) and (j<=n) do
        inc(j);
      if j>n then exit;
      if ord(a[i])<97 then ch1:=a[i]
                      else ch1:=chr(ord(a[i])-32);
      if ord(a[j])<97 then ch2:=a[j]
                      else ch2:=chr(ord(a[j])-32);
      if ch1<>ch2 then exit;
      right:=true;
      t3:=i;t4:=j;
    end;
begin
  assign(f1,'calfflac.in');
  reset(f1);
  n:=0;
  while not eof(f1) do
    begin
      inc(n);
      read(f1,a[n]);
    end;
  close(f1);
  assign(f2,'calfflac.out');
  rewrite(f2);
  max:=0;
  for i:=1 to n do
    if a[i] in ph then begin
      j:=1;t1:=i;t2:=i;
      while right(t1,t2,t3,t4) do
        begin
          inc(j);
          t1:=t3;t2:=t4;
        end;
      dec(j);
      if j*2+1>max then begin
                      max:=j*2+1;
                      x1:=t1;x2:=t2;
                    end;
   end;
  for i:=1 to n-1 do
    if a[i] in ph then begin
      j:=1;t1:=i+1;t2:=i;
      while right(t1,t2,t3,t4) do
        begin
          inc(j);
          t1:=t3;t2:=t4;
        end;
      dec(j);
      if j*2>max then begin
                        max:=j*2;
                        x1:=t1;x2:=t2;
                      end;
    end;
  writeln(f2,max);
  for i:=x1 to x2 do write(f2,a[i]);
  writeln(f2);
  close(f2);
  // Insert user code here
end.