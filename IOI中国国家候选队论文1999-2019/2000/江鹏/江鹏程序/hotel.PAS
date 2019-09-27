{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R-,S+,T-,V+,X+,Y+}
{$M 64000,0,655360}
program Hotel;
const
    fin         =       'hotel.in';
    fon         =       'hotel.out';
    maxN        =       100;
var
    N, M        :       integer;
    C           :       longint;
    a           :       array[1..maxn,1..maxn]of integer;
    f           :       array[1..maxn,1..maxn]of integer;
    f1          :       array[1..maxn]of integer;
    d, p        :       array[1..maxn]of integer;
    i,j,k,l     :       integer;

procedure Input;
  var fi:text;
  begin
  assign(fi,fin); reset(fi);
  readln(fi,n,m);
  fillchar(a,sizeof(a),0);
  for i:=1 to n-1 do
    begin
    for j:=i+1 to n do
      read(fi,a[i,j]);
    readln(fi);
    end;
  close(fi);
  end;
procedure Out;
  var fo:text;
  begin
  assign(fo,fon); rewrite(fo);
  writeln(fo,C);
  for i:=1 to n-1 do
    begin
    for j:=i+1 to n-1 do
      write(fo,f[i,j],' ');
    writeln(fo,f[i,n]);
    end;
  close(fo);
  end;
begin
  input;
  for k:=1 to m do
    begin
    for j:=2 to n do
      begin d[j]:=-1; p[j]:=0; end;
    p[1]:=1; d[1]:=0;
    repeat
      l:=0;
      for i:=1 to n do
        for j:=1 to n do
         if (p[i]>0) and (f[i,j]<a[i,j]) and (d[i]+(j-i)>d[j]) then
          begin
          d[j]:=d[i]+(j-i);
          p[j]:=i; l:=1;
          end;
      for i:=1 to n-1 do
        if (p[i]>0) and (d[i]>d[i+1]) then
          begin
          d[i+1]:=d[i];
          p[i+1]:=i; l:=1;
          end;
      for i:=1 to n-1 do
        if (p[i+1]>0) and (f1[i]>0) and (d[i+1]>d[i]) then
          begin
          d[i]:=d[i+1];
          p[i]:=i+1; l:=1;
          end;
    until (l=0);
    if p[n] > 0 then
      begin
      i:=p[n]; j:=n;
      c:=c+d[n];
      repeat
        if abs(d[i]-d[j])=0 then
          if i<j
          then f1[i]:=f1[i]+1
          else f1[j]:=f1[j]-1
        else
          begin
          f[i,j]:=f[i,j]+1;
          f[j,i]:=-f[i,j];
          end;
        j:=i; i:=p[i];
      until j=1;
      end;
    end;
  out;
end.
