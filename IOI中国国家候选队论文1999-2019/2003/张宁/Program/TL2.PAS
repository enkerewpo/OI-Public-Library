const maxn=1000;
var a:array[1..maxn] of longint;
    b:array[1..maxn] of integer;
    i,n,t,m,k:integer;
    tmp,f,ss,s:longint;
procedure insert(i:integer);
var j,tmp:integer;
begin
  inc(t);b[t]:=i;j:=t;
  while (j>1) and (a[b[j]]>a[b[j div 2]]) do
    begin
      tmp:=b[j];b[j]:=b[j div 2];b[j div 2]:=tmp;j:=j div 2;
    end;
end;
function max:integer;
var i,j,v,tmp:integer;
begin
  v:=b[1];b[1]:=b[t];dec(t);i:=1;
  while i<=t div 2 do
    begin
      if (i*2=t) or (a[b[2*i]]>a[b[2*i+1]]) then
        j:=i*2
      else
        j:=i*2+1;
      if a[b[j]]>a[b[i]] then
        begin
          tmp:=b[i];b[i]:=b[j];b[j]:=tmp;i:=j;
        end
      else
        break;
    end;
  max:=v;
end;
begin
  read(n);ss:=0;
  for i:=1 to n do
    begin
      read(a[i]);
      ss:=ss+a[i];
    end;
  t:=0;f:=0;
  for i:=1 to n do insert(i);
  while true do
    begin
      m:=max;s:=ss-a[m];k:=b[1];
      if a[k]*2<=s then
        begin
          inc(f,m);break;
        end
      else
        begin
          a[m]:=2*a[k]-s;
          dec(ss,s-a[m]);
          insert(m);
          if k<m then
            inc(f,m-k)
          else
            inc(f,n-k+m);
        end;
    end;
  i:=f mod n;
  if i=0 then i:=n;
  writeln('The student ',i,' can guess his number at round ',f);
end.