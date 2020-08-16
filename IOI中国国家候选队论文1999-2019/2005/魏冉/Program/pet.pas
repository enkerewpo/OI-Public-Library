program pet;
const
  infile='pet.in';
  outfile='pet.out';
  maxlevel=50;
  inf=2000000000;

type
  snode=^node;
  arr=array[1..maxlevel] of snode;
  node=record
         lvl:integer;
         num:longint;
         link:arr;
       end;
  Listtype=record
             lvl:integer;
             head,tail:snode;
           end;

var
  f,fo:text;
  ans,tot,state,currentstate,test,n,num:longint;
  empty:node;
  Slist:Listtype;
  update:array[1..maxlevel] of snode;

procedure Initialize;
begin
  ans:=0;
  fillchar(empty,sizeof(empty),0);
  Randomize;
  tot:=0;
  fillchar(slist,sizeof(slist),0);
  new(slist.head); new(slist.tail);
  slist.lvl:=1;
  slist.head^:=empty; slist.tail^:=empty;
  slist.head^.num:=-inf; slist.tail^.num:=inf;
  slist.head^.link[1]:=slist.tail;
  state:=0;
end;

function Random_Level : integer;
var
  lvl:integer;
begin
  lvl:=1;
  while random<0.5 do inc(lvl);
  Random_Level:=lvl;
end;

procedure find(o:longint);
var
  c1:integer;
  x:snode;
begin
  x:=slist.head;
  for c1:=slist.lvl downto 1 do begin
    while x^.link[c1]^.num<o do x:=x^.link[c1];
    update[c1]:=x;
  end;  
end;

procedure ins(o:longint);
var
  t:snode;
  c1:integer;
begin
  inc(tot);
  find(o);
  new(t);
  t^:=empty;
  t^.num:=o;
  t^.lvl:=Random_Level;
  if t^.lvl>=slist.lvl then begin
    t^.lvl:=slist.lvl;
    inc(slist.lvl);
    slist.head^.link[slist.lvl]:=slist.tail;
  end;
  for c1:=1 to t^.lvl do begin
    t^.link[c1]:=update[c1]^.link[c1];
    update[c1]^.link[c1]:=t;
  end;
end;

procedure del(o:longint);
var
  c1:integer;
  x:snode;
begin
  dec(tot);
  find(o);
  if abs(update[1]^.num-o)<=abs(update[1]^.link[1]^.num-o) then begin
    x:=update[1];
    ans:=(ans+abs(update[1]^.num-o)) mod 1000000;
  end else begin
    x:=update[1]^.link[1];
    ans:=(ans+abs(update[1]^.link[1]^.num-o)) mod 1000000;
  end;
  find(x^.num);
  for c1:=1 to x^.lvl do
    update[c1]^.link[c1]:=x^.link[c1];
  while (slist.lvl>1)and(slist.head^.link[slist.lvl-1]=slist.tail) do dec(slist.lvl);
end;

begin
  Initialize;
  assign(f,infile);  reset(f);
  assign(fo,outfile); rewrite(fo);
  readln(f,n);
  for test:=1 to n do begin
    readln(f,currentstate,num);
    if tot=0 then state:=currentstate;
    if currentstate=state then ins(num)
                          else del(num);
  end;
  writeln(fo,ans);
  close(fo);
  close(f);
end.
