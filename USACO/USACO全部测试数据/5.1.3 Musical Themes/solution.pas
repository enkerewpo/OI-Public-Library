{
PROG: theme
LANG: PASCAL
ID: asiapea1
}
 
var
  max,i,a1,a2,n,j:integer;
  a:array[0..5000] of integer;
begin
  assign(input,'theme.in');
  reset(input);
  assign(output,'theme.out');
  rewrite(output);
  readln(n);
  fillchar(a,sizeof(a),0);
  for i:=1 to n do
    read(a[i]);
  max:=0;
  for i:=2 to n do begin
    a1:=1;
    for j:=1 to n-i do
      if a[j]-a[j+1]=a[i+j]-a[i+j+1] then begin
        if a1<i then inc(a1);
        if a1>max then max:=a1;
      end
      else
        a1:=1;
  end;
  if max<5 then writeln(0) else writeln(max);
  close(input);
  close(output);
end.