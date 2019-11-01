const Len=181;     {181 ~=    Sqrt(32767)}
      Block=32767 div Len;
type Ppp=array[0..Len-1] of longint;
var LL,A,B:array[0..Block] of ^Ppp;
    L:Array[1..33000] of boolean;
    V:array[1..Block+1] of boolean;
    C:array[1..Block+1,1..2] of longint;
    ga,gb,q,i,j,k,n,t:longint;
    E,S,P:longint;
procedure Merge(p,q:longint);
var i,d,c,i1,i2:longint;
begin
  if p>=q then exit;
  c:=(p+q) div 2;
  Merge(p,c);
  Merge(c+1,q);
  i1:=p;
  i2:=c+1;
  d:=p;
  while (i1<=c)and(i2<=q) do
       if B[i1 div Len]^[i1 mod Len]<B[i2 div Len]^[i2 mod Len] then begin
          LL[d div Len]^[d mod Len]:=B[i1 div Len]^[i1 mod Len];
          inc(i1);inc(d);
                           end
                      else begin
          LL[d div Len]^[d mod Len]:=B[i2 div Len]^[i2 mod Len];
          inc(i2);inc(d);
                           end;
  while (i1<=c) do begin
          LL[d div Len]^[d mod Len]:=B[i1 div Len]^[i1 mod Len];
          inc(i1);inc(d);
                   end;
  while (i2<=q) do begin
          LL[d div Len]^[d mod Len]:=B[i2 div Len]^[i2 mod Len];
          inc(i2);inc(d);
                   end;
  for i:=p to q do B[i div Len]^[i mod Len]:=LL[i div Len]^[i mod Len];
end;
function Search(c:longint):word;
var p,q:longint;
    g:word;
begin
  p:=1;q:=n;
  g:=(p+q) div 2;
  while c<>B[g div Len]^[g mod Len] do begin
        if c>B[g div Len]^[g mod Len] then p:=g+1
                                      else q:=g-1;
         g:=(p+q) div 2;
                                       end;
  Search:=g;
end;
begin
  assign(input,'turnover.in');reset(input);
  assign(output,'turnover.out');rewrite(output);
  read(n);
  for i:=0 to Block do begin
       new(A[i]);
       fillchar(A[i]^,sizeof(A[i]^),0);
                    end;
  for i:=0 to Block do new(B[i]);
  for i:=0 to Block do new(LL[i]);
  for i:=1 to n do  read(A[i div Len]^[i mod Len]);
  for i:=0 to Block do B[i]^:=A[i]^;
  Merge(1,n);
  fillchar(l,sizeof(l),false);
  fillchar(v,sizeof(v),false);
  for i:=1 to Block+1 do begin
     C[i,1]:=i*Len;
     C[i,2]:=(i-1)*Len+1;
     if C[i,1]>n then C[i,1]:=n;
     if C[i,2]>n then C[i,2]:=n;
                     end;
  s:=0;
  for i:=1 to n do begin
      P:=A[i div Len]^[i mod Len];
      q:=Search(P);
      k:=(q-1) div Len+1;
      ga:=0;gb:=0;
      if V[k] then begin
         j:=q;
         while j>=C[k,1] do begin
             if L[j] then break;
             dec(j);
                              end;
         if j>=C[k,1] then gb:=j;
         j:=q;
         while j<=C[k,2] do begin
             if L[j] then break;
             inc(j);
                           end;
         if j<=C[k,2] then ga:=j;
                   end;
      if ga=0 then begin
         t:=k+1;
         while t<=(n-1) div Len+1 do begin
             if V[t] then break;
             inc(t);
                                     end;
         if t<=(n-1) div Len+1 then begin
              j:=C[t,1];
              ga:=j;
                                   end;
                   end;
      if gb=0 then begin
         t:=k-1;
         while t>0 do begin
             if V[t] then break;
             dec(t);
                      end;
         if t>0 then begin
              j:=C[t,2];
              gb:=j;
                     end;
                   end;
      E:=maxlongint;
      if (ga=0)and(gb=0) then E:=abs(p);
      if ga<>0 then if abs(p-B[ga div Len]^[ga mod Len])<E then
                       E:=abs(p-B[ga div Len]^[ga mod Len]);
      if gb<>0 then if abs(p-B[gb div Len]^[gb mod Len])<E then
                       E:=abs(p-B[gb div Len]^[gb mod Len]);
      V[k]:=true;
      L[q]:=true;
      if q<C[k,1] then C[k,1]:=q;
      if q>C[k,2] then C[k,2]:=q;
      S:=S+E;
                   end;
  writeln(S);
  close(input);close(output);
end.