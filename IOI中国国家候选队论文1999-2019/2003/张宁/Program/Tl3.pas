{$N+}
const maxn=100;
      maxm=9997;
      zero=1e-6;
type t1=^t2;
     t2=record
        id:extended;
        f:integer;
        nt:t1;
        end;
type t=array[1..maxn] of integer;
var a:t;
    i,f,n,m:integer;
    w:array[0..maxm] of t1;
    j,pp:longint;
function fmod(aa:extended;bb:longint):longint;
var cc:extended;
begin
  cc:=int(aa/bb);
  fmod:=trunc(aa-bb*cc);
end;
function find(ww:extended):integer;
var tt:t1;
    u:longint;
begin
  u:=fmod(ww,maxm);
  tt:=w[u];
  if tt=nil then
    begin
      find:=-1;exit;
    end;
  while (abs(tt^.id-ww)>zero) and (tt^.nt<>nil) do
    tt:=tt^.nt;
  if abs(tt^.id-ww)<=zero then
    find:=tt^.f
  else
    find:=-1;
end;
procedure add(ww:extended;f:integer);
var tt:t1;
    u:longint;
begin
  u:=fmod(ww,maxm);
  tt:=w[u];
  if w[u]=nil then
    begin
      new(w[u]);
      w[u]^.id:=ww;
      w[u]^.f:=f;
      w[u]^.nt:=tt;
      exit;
    end;
end;
function solve(a:t):integer;
var b,c:t;
    f,tmp,p,q,i,j,k,ss,s,s1,max:integer;
    ww:extended;
begin
  ww:=0;
  for i:=1 to n do
    ww:=ww*pp+a[i]-1;
  f:=find(ww);
  if f>=0 then
    begin
      solve:=f;exit;
    end;
  f:=0;max:=0;q:=0;s:=0;
  for i:=1 to n do
    begin
      inc(s,a[i]);
      if a[i]>max then
        begin
          max:=a[i];q:=i;
        end;
    end;
  p:=0;
  for i:=1 to n do
    if a[i]=max then
      inc(p);
  if p>=2 then
    begin
      if p=n then
        begin
          add(ww,1);solve:=1;exit;
        end;
      if (p>2) or (m>n/2) then
        begin
          add(ww,0);solve:=0;exit;
        end;
      k:=0;p:=0;
      for i:=1 to n do
        if a[i]<max then
          begin
            if p=0 then
              p:=a[i]
            else
              if a[i]<>p then begin
                add(ww,0);solve:=0;exit;
              end;
          end
        else
          begin
            inc(k);b[k]:=i;
          end;
      if 2*p<=max then
        begin
          add(ww,q);solve:=q;exit;
        end;
      if n>4 then
        begin
          add(ww,0);solve:=0;exit;
        end;
      for i:=1 to n do c[i]:=a[i];
      c[b[1]]:=s-3*max;
      f:=solve(c);
      if b[2]<b[1] then
        inc(f,b[1]-b[2])
      else
        inc(f,n+b[1]-b[2]);
      c[b[1]]:=max;
      c[b[2]]:=s-3*max;
      tmp:=solve(c);
      if b[1]<b[2] then
        inc(tmp,b[2]-b[1])
      else
        inc(tmp,n+b[2]-b[1]);
      if tmp<f then f:=tmp;
      add(ww,f);solve:=f;exit;
    end;
  for i:=1 to n do
    if i<q then
      b[i]:=a[i]
    else
      if i>q then
        b[i-1]:=a[i];
  for i:=1 to n-2 do
    for j:=i+1 to n-1 do
      if b[i]<b[j] then
        begin
          tmp:=b[i];b[i]:=b[j];b[j]:=tmp;
        end;
  ss:=0;
  for i:=1 to m do inc(ss,b[i]);
  for i:=m+1 to n-1 do dec(ss,b[i]);
  if a[q]<>ss then
    begin
      add(ww,0);solve:=0;exit;
    end;
  max:=b[1];dec(s,a[q]);
  for i:=1 to m do b[i]:=i;
  for i:=1 to n do c[i]:=a[i];
  while true do
    begin
      j:=2;s1:=0;
      for i:=1 to m do
        begin
          inc(s1,a[b[i]]);
          if b[i]=q then j:=1;
        end;
      if j=1 then s1:=s-s1+a[q];
      if (2*s1>s) and (2*s1-s<a[q]) then
        begin
          c[q]:=2*s1-s;
          if c[q]>=max then begin
            add(ww,0);solve:=0;exit;
          end;
          p:=solve(c);
          if p=0 then
            begin
              add(ww,0);solve:=0;exit;
            end;
          i:=p mod n;
          if i=0 then i:=n;
          if i<q then
            inc(p,q-i)
          else
            inc(p,n+q-i);
          if p>f then f:=p;
        end;
      i:=m;
      while (i>0) and (b[i]+m-i+1>n) do dec(i);
      if i=0 then break;
      inc(b[i]);
      for j:=i+1 to m do b[j]:=b[j-1]+1;
    end;
  if f=0 then f:=q;
  add(ww,f);solve:=f;
end;
begin
  for j:=0 to maxm do w[j]:=nil;
  read(n,m);pp:=0;
  for i:=1 to n do
    begin
      read(a[i]);
      if a[i]>pp then pp:=a[i];
    end;
  f:=solve(a);
  if f=0 then
    writeln('No one can guess his number.')
  else
    begin
      i:=f mod n;
      if i=0 then i:=n;
      writeln('The student ',i,' can guess his number at round ',f);
    end;
end.