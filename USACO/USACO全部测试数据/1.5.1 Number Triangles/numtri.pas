{
ID:asiapea1
PROG:numtri
LANG:PASCAL
}
prograM numtri;
var
  fin,fout:text;
  w:array [0..1010,0..1010] of byte;
  f:array [1..1010] of longint;
  r,j,k:longint;
procedure mar;
  begin
    assign(fin,'numtri.in');
    reset(fin);
    readln(fin,r);
    for k:=1 to r do
      for j:=1 to k do
        read(fin,w[k,j]);
    close(fin)
  end;
function max(a,b:longint):longint;
  begin
    if a>=b then max:=a
            else max:=b
  end;
procedure work;
  begin
    fillchar(f,sizeof(f),0);
    for k:=1 to r do
      for j:=k downto 1 do
        f[j]:=max(f[j],f[j-1])+w[k,j];
    k:=0;
    for j:=1 to r do k:=max(k,f[j])
  end;
procedure out;
  begin
    assign(fout,'numtri.out');
    rewrite(fout);
    writeln(fout,k);
    close(fout)
  end;
begin
  mar;
  work;
  out
end.