{
ID: asiapea1
PROG: contact
LANG: PASCAL
}
const
  sn=8190;
type
  data=
  record
    bina:string[12];
    count:dword;
  end;
var
  a,b,n,l,i,wd:byte;
  ch:char;
  s,d,u,v:word;
  curr:dword;
  slot:array[1..sn]of data;
  x2:array[1..13]of word;
  bi:string[12];
  swap,mid:data;
  stop:boolean;
//
function more (a,b:data):boolean;
begin
  if a.count>b.count then
    exit(true);
  if a.count<b.count then
    exit(false);
  if a.bina[0]<b.bina[0] then
    exit(true);
  if a.bina[0]>b.bina[0] then
    exit(false);
  if a.bina<b.bina then
    exit(true);
  if a.bina>b.bina then
    exit(false);
  exit(false);
end;
//
function less (a,b:data):boolean;
begin
  if a.count<b.count then
    exit(true);
  if a.count>b.count then
    exit(false);
  if a.bina[0]>b.bina[0] then
    exit(true);
  if a.bina[0]<b.bina[0] then
    exit(false);
  if a.bina>b.bina then
    exit(true);
  if a.bina<b.bina then
    exit(false);
  exit(false);
end;
//
procedure qsort (f,e:word);
var
  i,j:word;
begin
  mid:=slot[random(e-f+1)+f];
  i:=f;
  j:=e;
  repeat
    while more(slot[i],mid) do
      inc(i);
    while less(slot[j],mid) do
      dec(j);
    if i<=j then
    begin
      swap:=slot[i];
      slot[i]:=slot[j];
      slot[j]:=swap;
      inc(i);
      dec(j);
    end;
  until i>j;
  if i<e then
    qsort(i,e);
  if f<j then
    qsort(f,j);
end;
//
begin
  assign(input,'contact.in');
  assign(output,'contact.out');
  reset(input);
  rewrite(output);
  readln(a,b,n);
  x2[1]:=2;
  for i:=2 to 13 do
    x2[i]:=x2[i-1]*2;
  for l:=a to b do
  begin
    reset(input);
    readln;
    s:=0;
    d:=x2[l]-2;
    bi:='';
    stop:=false;
    for i:=1 to l do
    begin
      read(ch);
      bi:=bi+ch;
      s:=s*2;
      if ch='1' then
        s:=s+1;
      if eoln and (i<l) then
        stop:=true;
    end;
    if stop then
    begin
      b:=l-1;
      break;
    end;
    if slot[s+d+1].bina='' then
      slot[s+d+1].bina:=bi;
    inc(slot[s+d+1].count);
    if eoln then
      readln;
    while not eof do
    begin
      read(ch);
      delete(bi,1,1);
      bi:=bi+ch;
      s:=s*2 mod x2[l];
      if ch='1' then
        s:=s+1;
      if slot[s+d+1].bina='' then
        slot[s+d+1].bina:=bi;
      inc(slot[s+d+1].count);
      if eoln then
        readln;
    end;
  end;
  randomize;
  qsort(x2[a]-1,x2[b+1]-2);
  curr:=maxlongint;
  i:=0;
  u:=x2[a]-1;
  while u<=x2[b+1]-2 do
  begin
    if slot[u].count<curr then
    begin
      inc(i);
      if (i>n) or (slot[u].count=0) then
        break;
      curr:=slot[u].count;
      writeln(curr);
    end;
    write(slot[u].bina);
    v:=u+1;
    wd:=1;
    while (v<=x2[b+1]-2) and (slot[v].count=curr) do
    begin
      inc(wd);
      if wd>6 then
      begin
        wd:=1;
        writeln;
      end;
      if wd<>1 then
        write(' ');
      write(slot[v].bina);
      inc(v);
    end;
    writeln;
    u:=v;
  end;
  close(output);
end.