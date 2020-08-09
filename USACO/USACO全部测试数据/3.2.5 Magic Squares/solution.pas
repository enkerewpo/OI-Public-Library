{
ID:asiapea1
PROG:msquare
LANG:PASCAL
}
program msquare;
const
  sn=40320;
  hn=40320;
  dx:array[1..3,1..8]of word=((8,7,6,5,4,3,2,1),(4,1,2,3,6,7,8,5),(1,7,2,4,5,3,6,8));
type
  state=array[1..8]of byte;
var
  i,j,tt,step,wd,f,e,m,rn,oj:word;
  ss:array[1..sn]of state;
  tmp:state;
  hash:array[1..hn]of boolean;
  path:array[1..sn]of byte;
  pre:array[1..sn]of word;
  re:array[1..hn]of byte;
//
function hh(var s:state):word;
var
  i,j,tt:word;
  n:array[1..8]of byte;
begin
  fillchar(n,sizeof(n),0);
  for i:=1 to 7 do
    for j:=i+1 to 8 do
      if s[j]<s[i] then
        inc(n[i]);
  tt:=0;
  for i:=1 to 7 do
    tt:=(tt+n[i])*(8-i);
  inc(tt);
  hh:=tt;
end;
//
procedure print (s:byte);
begin
  if s=1 then
    write('A');
  if s=2 then
    write('B');
  if s=3 then
    write('C');
  inc(wd);
  if wd=60 then
  begin
    writeln;
    wd:=0;
  end;
end;
//
begin
  assign(input,'msquare.in');
  assign(output,'msquare.out');
  reset(input);
  rewrite(output);
  for i:=1 to 8 do
    read(tmp[i]);
  readln;
  oj:=hh(tmp);
  if oj=1 then
  begin
    writeln(0);
    writeln;
    close(output);
    halt;
  end;
  for i:=1 to 8 do
    ss[1,i]:=i;
  hash[1]:=true;
  f:=1;
  e:=2;
  m:=2;
  step:=1;
  while true do
  begin
    for i:=1 to 3 do
    begin
      for j:=1 to 8 do
        tmp[j]:=ss[f,dx[i,j]];
      tt:=hh(tmp);
      if tt=oj then
      begin
        writeln(step);
        j:=f;
        rn:=0;
        while j<>1 do
        begin
          inc(rn);
          re[rn]:=path[j];
          j:=pre[j];
        end;
        for j:=rn downto 1 do
          print(re[j]);
        print(i);
        writeln;
        close(output);
        halt;
      end;
      if not hash[tt] then
      begin
        hash[tt]:=true;
        ss[e]:=tmp;
        path[e]:=i;
        pre[e]:=f;
        inc(e);
      end;
    end;
    inc(f);
    if f=m then
    begin
      inc(step);
      m:=e;
    end;
  end;
end.