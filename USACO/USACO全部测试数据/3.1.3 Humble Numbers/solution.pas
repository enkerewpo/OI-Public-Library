{
ID: asiapea1
PROG: humble
LANG: PASCAL
}
var
  hum:array[0..100000]of dword;
  pp,dex:array[1..100]of dword;
  k,i:byte;
  n,j,ob:dword;
begin
  assign(input,'humble.in');
  assign(output,'humble.out');
  reset(input);
  rewrite(output);
  readln(k,n);
  for i:=1 to k do
    read(pp[i]);
  readln;
  hum[0]:=1;
  for j:=1 to n do
  begin
    ob:=maxlongint*2+1;
    for i:=1 to k do
    begin
      while pp[i]*hum[dex[i]]<=hum[j-1] do
        inc(dex[i]);
      if pp[i]*hum[dex[i]]<ob then
        ob:=pp[i]*hum[dex[i]];
    end;
    hum[j]:=ob;
  end;
  writeln(ob);
  close(output);
end.