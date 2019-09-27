uses crt;
const
    ch          :       array[0..1]of char = ('.','*');
var
    a           :       array[0..100,0..100]of byte;
    n,i,j,k,k1,num  :   integer;
procedure print;
  var ii,jj : integer;
  begin
  clrscr;
  inc(num); writeln('No.',num);
  for ii:=0 to n+1 do
    begin
    for jj:=0 to n+1 do
      write(ch[a[ii,jj]],' ');
    writeln;
    end;
  write('Press <ENTER>...');
  readln;
  end;
procedure l(t1,t2:integer);
  begin
  a[t1,t2-1]:=1; a[t1,t2]:=0; a[t1,t2+1]:=0;
  print;
  a[t1+1,t2]:=0; a[t1+2,t2]:=0; a[t1,t2]:=1;
  print;
  a[t1,t2-1]:=0; a[t1,t2]:=0; a[t1,t2+1]:=1;
  print;
  end;
procedure h(t1,t2:integer);
  begin
  a[t1,t2]:=0;a[t1+1,t2]:=0;a[t1-1,t2]:=1;
  print;
  a[t1,t2+1]:=0;a[t1,t2+2]:=0;a[t1,t2]:=1;
  print;
  a[t1-1,t2]:=0;a[t1,t2]:=0;a[t1+1,t2]:=1;
  print;
  end;
procedure Mo2(t1,t2:integer);
  begin
  a[t1,t2]:=0;a[t1+1,t2]:=0;a[t1+2,t2]:=1;print;
  a[t1,t2+1]:=0;a[t1+1,t2+1]:=0;a[t1+2,t2+1]:=1;print;
  a[t1+2,t2]:=0;a[t1+2,t2+1]:=0;a[t1+2,t2+2]:=1;print;
  a[t1,t2+2]:=0;a[t1,t2+3]:=0;a[t1,t2+1]:=1;print;
  a[t1+2,t2+2]:=0;a[t1+1,t2+2]:=0;a[t1,t2+2]:=1;print;
  a[t1,t2+1]:=0;a[t1,t2+2]:=0;a[t1,t2+3]:=1;print;
  end;
begin
  clrscr;
  write('N='); readln(n);
  if n mod 3 = 0 then begin write('No Way!');readln;halt;end;
  num:=0;
  fillchar(a,sizeof(a),0);
  for i:=1 to n do
    for j:=1 to n do
      a[i,j]:=1;
  print;
  k1:=n div 3;
  if n mod 3 = 1 then dec(k1);
  for i:=1 to k1 do
    for j:=1 to n-3 do
      l((i-1)*3+1,j);
  for i:=1 to k1*3 do h(i,n-2);
  case n mod 3 of
    1:begin
      for i:=1 to k1+1 do h(3*k1+1,(i-1)*3+1);
      for i:=1 to n-2 do l(3*k1+2,i);
      a[n,n]:=0; a[n,n-1]:=0; a[n,n-2]:=1; print;
      a[n-1,n]:=0; a[n-1,n-1]:=0; a[n-1,n-2]:=1; print;
      a[n,n-2]:=0; a[n-1,n-2]:=0; a[n-2,n-2]:=1; print;
      a[n-3,n]:=0; a[n-2,n]:=0; a[n-1,n]:=1; print;
      a[n-2,n-2]:=0; a[n-2,n-1]:=0; a[n-2,n]:=1; print;
      a[n-1,n]:=0; a[n-2,n]:=0; a[n,n]:=1; print;
      end;
    2:begin
      for i:=1 to k1 do
        mo2(3*k1+1,(i-1)*3+1);
      a[3*k1+1,3*k1+1]:=0;a[3*k1+2,3*k1+1]:=0;a[3*k1,3*k1+1]:=1;print;
      a[3*k1+1,3*k1+2]:=0;a[3*k1+2,3*k1+2]:=0;a[3*k1,3*k1+2]:=1;print;
      a[3*k1,3*k1+2]:=0;a[3*k1,3*k1+2]:=0;a[3*k1,3*k1]:=1;print;
      end;
  end;
end.
