const
  maxn=524688;
var
  er:array[0..20]of longint;
  z,n:longint;
  p1:array[1..maxn]of longint;
  q2,q3:array[1..maxn]of longint;
  t:array[1..maxn*2]of longint;
procedure init;
  var
    j,a:longint;
  begin
    er[0]:=1;
    for j:=1 to 20 do
      er[j]:=er[j-1]*2;
    readln(n);
    for j:=1 to 20 do
      if n<=er[j] then
        begin
          z:=j;
          break;
        end;
    for j:=1 to n do
      read(p1[j]);
    for j:=1 to n do
      begin
        read(a);
        q2[a]:=j;
      end;
    for j:=1 to n do
      begin
        read(a);
        q3[a]:=j;
      end;
  end;
procedure main;
  var
    s,i,x,j,k,l,p:longint;
  begin
    fillchar(t,sizeof(t),0);
    s:=n;
    for i:=1 to n do
      begin
        k:=q3[p1[i]];
        l:=q2[p1[i]];
        for j:=z downto 0 do
          begin
            p:=er[j]-1+k;
            if (t[p]=0)or(t[p]>l)
              then t[p]:=l;
            if not odd(k)
              then if (t[p-1]<>0)and(t[p-1]<l)
                then begin
                  dec(s);
                  break;
                end;
            k:=(k+1) div 2;
          end;
      end;
    writeln(s);
  end;
begin
//  assign(input,'team.in');
//  reset(input);
  init;
  main;
//  close(input);
end.
