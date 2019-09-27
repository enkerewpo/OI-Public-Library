{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R-,S+,T-,V+,X+,Y+}
{$M 64000,0,655360}
program Sequence;
const
    fin         =       'sequence.in';
    fon         =       'sequence.out';
    maxN        =       1000;
var
    N           :       integer;
    A           :       array[1..2,0..2]of integer;
    D           :       array[0..maxN] of integer;
    V           :       array[0..maxN]of integer;
    E           :       array[0..maxN,1..6,0..1]of integer;
    i,j,k,l     :       integer;

procedure Input;
  var f:text;
  begin
  assign(f,fin); reset(f);
  read(f,n);
  for i:=1 to 2 do
    read(f,a[i,1],a[i,2],a[i,0]);
  j:=a[1,1];
  a[1,1]:=a[1,0]-a[1,2];
  a[1,2]:=a[1,0]-j;
  close(f);
  end;
procedure Construct;
  begin
  fillchar(v,sizeof(v),0);
  for i:=1 to n do
    begin
    inc(v[i-1]); inc(v[i]);
    e[i-1,v[i-1],0]:=i;
    e[i-1,v[i-1],1]:=0;
    e[i,v[i],0]:=i-1;
    e[i,v[i],1]:=-1;
    end;
  for i:=1 to 2 do
    for j:=0 to n-a[i,0] do
      begin
      k:=j+a[i,0];
      inc(v[j]); inc(v[k]);
      e[j,v[j],0]:=k;
      e[j,v[j],1]:=a[i,1];
      e[k,v[k],0]:=j;
      e[k,v[k],1]:=-a[i,2];
      end;
  end;
procedure Done;
  var f:text;
  begin
  assign(f,fon); rewrite(f);
  if l > n
  then write(f,-1) else
    for i:=1 to n do
      write(f,d[i]-d[i-1]);
  writeln(f); close(f);
  end;
begin
  Input;
  Construct;
  fillchar(d,sizeof(d),0);
  l:=0;
  repeat
    inc(l); k:=0;
    for i:=0 to n do
      for j:=1 to v[i] do
        if d[i]+e[i,j,1] > d[e[i,j,0]] then
          begin
          d[e[i,j,0]]:=d[i]+e[i,j,1];
          k:=1;
          end;
  until (k=0) or (l>n);
  Done;
end.
