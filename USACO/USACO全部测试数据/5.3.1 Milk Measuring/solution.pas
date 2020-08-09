{
ID: asiapea1
PROG: milk4
LANG: PASCAL
}
program milk4;
type
  arr=array[0..20000]of integer;
var
  p,q,maxd,i,j,k,l,m,n:longint;
  v:array[0..100]of longint;
  f:arr;
  t:array[0..100]of longint;
  flag:boolean;
 
procedure dfs(nowd:longint);
var
  newmax,i,j:longint;
  tmp:arr;
 
procedure make(x:longint);
var
  i:longint;
begin
  for i:=0 to q-x do if (f[i]<>-1)and(i+x<=q) then inc(f[i+x]);
end;
 
begin
  if nowd>maxd then
  begin
    if f[q]>=0 then flag:=true;
    exit;
  end;
  tmp:=f;
  for i:=t[nowd-1]+1 to p do
  begin
    t[nowd]:=i;
    make(v[i]);       //DP
    dfs(nowd+1);
    if flag then exit;
    f:=tmp;       //偷懒了~
  end;
end;
 
function check:boolean;
begin
  flag:=false;
  dfs(1);
  check:=flag;
end;
 
 
begin
  assign(input,'milk4.in');
  reset(input);
  assign(output,'milk4.out');
  rewrite(output);
 
  readln(q);
  readln(p);
  for i:=1 to p do readln(v[i]);
 
  for i:=1 to p-1 do             //将桶按容积大小排序
    for j:=i+1 to p do if v[i]>v[j] then
    begin
      k:=v[i];
      v[i]:=v[j];
      v[j]:=k;
    end;
 
 
  for maxd:=1 to 10 do
  begin
    fillchar(f,sizeof(f),255);
    f[0]:=0;
    if check then        //DFS-ID枚举使用哪些桶
    begin
      write(maxd);
      for i:=1 to maxd do write(' ',v[t[i]]);
      writeln;
      break;
    end;
  end;
  close(input);
  close(Output);
end.