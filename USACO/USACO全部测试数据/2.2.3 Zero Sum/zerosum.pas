{
ID:asiapea1
PROG:zerosum
LANG:PASCAL
}
var
  f1,f2:Text;
  a:array[0..9]of integer;
  n,i,j:integer;
  Function King:boolean;
  var
    i,t,w:longint;
    f:boolean;
    begin
      w:=0;f:=true;i:=0;
      repeat
        inc(i);
        t:=i;
        while (a[i]=0) and (i<=n-1) do
          begin
            inc(i);
            t:=t*10+i;
          end;
        if f then w:=w+t
             else w:=w-t;
        if i<=n-1 then if a[i]=1 then f:=true
                                 else f:=false;
      until i>n-1;
      if w=0 then King:=true
             else King:=false;
    end;
begin
  assign(f1,'zerosum.in');
  reset(f1);
  readln(f1,n);
  close(f1);
  for i:=0 to n-1 do a[i]:=0;
  assign(f2,'zerosum.out');
  rewrite(f2);
  while a[0]=0 do
    begin
      if king then begin
                     for i:=1 to n-1 do
                       begin
                         write(f2,i);
                         case a[i] of
                           0:write(f2,' ');
                           1:write(f2,'+');
                           2:write(f2,'-');
                         end;
                       end;
                     writeln(f2,n);
                   end;
      j:=n-1;
      while a[j]=2 do dec(j);
      inc(a[j]);
      for i:=j+1 to n-1 do a[i]:=0;
    end;
  close(f2);
  // Insert user code here
end.
