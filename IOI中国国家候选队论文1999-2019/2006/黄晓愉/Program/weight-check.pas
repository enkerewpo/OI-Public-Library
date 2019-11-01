program hxy;
Const maxn=1000;
      infile1='weight.in';
      infile2='weight.out';
Var a:array[1..maxn]of longint;
    get:array[1..1000000]of integer;
    i,j,k,n,m:longint;
begin
  assign(input,infile1);
  reset(input);
  readln(n,m);  readln;
  fillchar(get,sizeof(get),0);
  for i:=1 to 2*n do
  begin
    read(j);
    inc(get[j]);
  end;
  close(input);
  assign(input,infile2);
  reset(input);
  for i:=1 to n do read(a[i]);
  close(input);

  j:=0;
  for i:=1 to n do
  begin
    inc(j,a[i]);
    dec(get[j]);
    if get[j]<0 then begin
      writeln('Wa');
      exit
    end;
  end;
  j:=0;
  for i:=n downto 1 do
  begin
    inc(j,a[i]);
    dec(get[j]);
    if get[j]<0 then begin
      writeln('Wa');
      exit
    end;
  end;
  writeln('Ac');
end.


