const
  maxn=100;
  maxm=10;
  maxr=60;
var
  s:array[-2..9]of char;
  p:array[0..maxn,-2..maxm-1]of char;
  w:array[0..maxn,1..maxr]of byte;
  t:array[0..maxn,1..maxr]of word;
  ct:array[0..maxn]of longint;
  n,m,ni,tj:longint;
  f:array[0..maxn,1..maxr,1..maxr]of longint;
procedure tried(i:longint);
  begin
    if i=m
      then begin
        inc(ct[ni]);
        for tj:=0 to m-1 do
          if s[tj]='*'
            then begin
              t[ni][ct[ni]]:=t[ni][ct[ni]] or (1 shl tj);
              inc(w[ni][ct[ni]]);
            end;
        exit;
      end;
    if not((s[i-2]='*')or(s[i-1]='*')or(p[ni,i]='H'))
      then begin
        s[i]:='*';
        tried(i+1);
      end;
    s[i]:='.';
    tried(i+1);
  end;
procedure init;
  var
    i,j:longint;
  begin
    fillchar(p,sizeof(p),'P');
    readln(n,m);
    for i:=1 to n do
      begin
        for j:=0 to m-1 do
          read(p[i,j]);
        readln;
      end;
    fillchar(ct,sizeof(ct),0);
    fillchar(t,sizeof(t),0);
    ct[0]:=1;t[0,1]:=0;
    for ni:=1 to n do
      begin
        fillchar(s,sizeof(s),'.');
        tried(0);
      end;
  end;
procedure main;
  var
    i,j,k,l,
    max:longint;
  begin
    for j:=1 to ct[1] do
      f[0,1,j]:=w[1,j];
    for i:=1 to n-1 do
      begin
        for j:=1 to ct[i] do
          for k:=1 to ct[i+1] do
            begin
              if (t[i,j]and t[i+1,k])=0
                then begin
                  max:=0;
                  for l:=1 to ct[i-1] do
                    if (t[i+1,k] and t[i-1,l])=0 then
                      if f[i-1,l,j]>max
                        then max:=f[i-1,l,j];
                  f[i,j,k]:=max+w[i+1,k];
                end
                else f[i,j,k]:=0;
            end;
      end;
  end;
procedure out;
  var
    best,i,j:longint;
  begin
    best:=0;
    for i:=1 to ct[n-1] do
      for j:=1 to ct[n] do
        if f[n-1,i,j]>best
          then best:=f[n-1,i,j];
    writeln(best);
  end;
begin
  init;
  main;
  out;
end.
