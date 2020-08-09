{
ID: asiapea1
PROG: tour
LANG: PASCAL
}
program tour;
var
  i,j,k,l,m,n,t,v:longint;
  f:array[0..101,0..101]of longint;{看成两个人走，f[i,j]表示一个人在i，另一个在j时走过的最多城市}
  city:array[0..101]of string;
  g:array[0..101,0..101]of boolean;
  s1,s2,s:string;
function max(a,b:longint):longint;
begin
  if a<b then max:=b else max:=a;
end;
begin
  assign(input,'tour.in');
  reset(input);
  assign(output,'tour.out');
  rewrite(output);
  fillchar(g,sizeof(g),false);
  readln(n,v);
  for i:=1 to n do
  begin
    readln(city[i]);
    k:=length(city[i]);
    while city[i,k]=' ' do dec(k);{去除空格，我不知道是否有多余空格，不过maigo就没处理}
    city[i]:=copy(city[i],1,k);
  end;
  for i:=1 to v do
  begin
    readln(s);
    k:=pos(' ',s);
    s1:=copy(s,1,k-1);
    s2:=copy(s,k+1,length(s)-k);
    k:=length(s1);
    while s1[k]=' ' do
    begin
      delete(s1,k,1);
      dec(k);
    end;
    k:=length(s2);
    while s2[k]=' ' do
    begin
      delete(s2,k,1);
      dec(k);
    end;
    for j:=1 to n do if city[j]=s1 then break;
    for k:=1 to n do if city[k]=s2 then break;
    g[j,k]:=true;{用邻接矩阵寸边}
    g[k,j]:=true;
  end;
  f[1,1]:=1;
  for i:=1 to n do
    for j:=i+1 to n do{因为f[i,j]与f[j,i]等价，故强制使j>i}
    begin
      t:=-maxlongint;
      for k:=1 to j-1 do
      if(g[k,j])and(f[i,k]>0) then t:=max(f[i,k]+1,t);
      f[i,j]:=t;
      f[j,i]:=t;
    end;
  t:=1;
  for i:=1 to n-1 do if g[i,n] then t:=max(t,f[i,n]);{取最优值}
  writeln(t);
  close(input);
  close(output);
end.