{
ID: asiapea1
PROG: fence
LANG: PASCAL
}
var
  n,i,j,s,t,m:word;
  con:array[1..500,1..500]of word;
  d:array[1..500]of word;
  cir:boolean;
  path:array[1..1025]of word;
//
procedure search (s:word);
var
  i:word;
begin
  for i:=1 to m do
    if con[s,i]>0 then
    begin
      dec(con[s,i]);
      dec(con[i,s]);
      search(i);
    end;
  inc(j);
  path[j]:=s;
end;
//
begin
  assign(input,'fence.in');
  assign(output,'fence.out');
  reset(input);
  rewrite(output);
  readln(n);
  for i:=1 to n do
  begin
    readln(s,t);
    inc(con[s,t]);
    inc(con[t,s]);
    inc(d[s]);
    inc(d[t]);
    if s>m then
      m:=s;
    if t>m then
      m:=t;
  end;
  cir:=true;
  for i:=1 to m do
    if odd(d[i]) then
    begin
      s:=i;
      cir:=false;
      break;
    end;
  j:=0;
  if cir then
    search(1)
  else
    search(s);
  for i:=n+1 downto 1 do
    writeln(path[i]);
  close(output);
end.