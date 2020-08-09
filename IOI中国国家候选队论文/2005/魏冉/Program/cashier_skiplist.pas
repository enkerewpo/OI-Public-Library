program cashier_skiplist;
uses Sysutils;
const
  infile='cashier.in';
  outfile='cashier.out';
  logfile='cashier_sk.log';
  p=0.5;
  Maxlevel=50;
  inf=1000000000;

type
  snode=^node;
  arr=array[1..Maxlevel] of snode;
  arr2=array[1..MaxLevel] of longint;
  node=record
         key,pnum:longint;
         level:byte;
         link:arr;
         sum:arr2;
       end;
  slisttype=record
              level:byte;
              header,tail:snode;
            end;

var
  StartTime:double;
  totnum:array[1..Maxlevel] of longint;
  update:array[1..Maxlevel] of snode;
  emptylink:arr;
  emptysum:arr2;
  f,fo:Text;
  totp,left,bottom,test,n,k,min:longint;
  order:char;
  slist:slisttype;

procedure initialize;
var
  c1:integer;
begin
  randomize;
  bottom:=0; left:=0; totp:=0;
  fillchar(emptylink,sizeof(emptylink),0);
  fillchar(emptysum,sizeof(emptysum),0);
  slist.level:=1;
  new(slist.header);
  slist.header^.key:=-inf;
  slist.header^.pnum:=0;
  slist.header^.level:=1;
  slist.header^.sum:=emptysum;
  new(slist.tail);
  slist.tail^.key:=inf;
  slist.tail^.pnum:=0;
  slist.tail^.level:=1;
  slist.tail^.sum:=emptysum;
  slist.header^.level:=1;
  slist.header^.link:=emptylink;
  for c1:=1 to Maxlevel do slist.header^.link[c1]:=slist.tail;
end;

function Random_Num : integer;
var
  tot:integer;
begin
  tot:=1;
  while random<p do inc(tot);
  Random_Num:=tot;
end;

function Find(SearchKey:longint) : snode;
var
  x:snode;
  c1:integer;
begin
  x:=slist.header;
  for c1:=slist.level downto 1 do begin
    totnum[c1]:=0;
    while x^.link[c1]^.key<SearchKey do begin
      totnum[c1]:=totnum[c1]+x^.sum[c1];
      x:=x^.link[c1];
    end;
    update[c1]:=x;
  end;
  Find:=x;
end;

procedure Ins;
var
  x:snode;
  c1:integer;
  tot:longint;
  t:snode;
begin
  k:=k+bottom;
  if k<min+bottom then exit;
  x:=Find(k);
  if x^.link[1]^.key=k then begin
    x:=x^.link[1];
    inc(x^.pnum);
    for c1:=slist.level downto 1 do
      inc(update[c1]^.sum[c1]);
  end else begin
    new(t);
    t^.key:=k;
    t^.pnum:=1;
    t^.level:=Random_Num;
    if t^.level>Slist.level+1 then t^.level:=Slist.level+1;
    if t^.level>=slist.level then begin
      for c1:=slist.level+1 to t^.level+1 do begin
        update[c1]:=slist.header;
        update[c1]^.sum[c1]:=totp;
        slist.header^.link[c1]:=slist.tail;
        totnum[c1]:=0;
      end;
      slist.level:=t^.level+1;
      slist.header^.level:=slist.level;
      slist.tail^.level:=slist.level;
    end;
    t^.link:=emptylink;
    tot:=0;
    for c1:=1 to slist.level do begin
      if c1<=t^.level then begin
        t^.sum[c1]:=update[c1]^.sum[c1]-tot;
        t^.link[c1]:=update[c1]^.link[c1];
        update[c1]^.link[c1]:=t;
        update[c1]^.sum[c1]:=tot+t^.pnum;
        tot:=tot+totnum[c1];
      end else
        inc(update[c1]^.sum[c1],t^.pnum);
    end;
  end;
  inc(totp);
end;

procedure Add;
begin
  dec(bottom,k);
end;

procedure Substract;
var
  c1:integer;
  tot:longint;
begin
  inc(bottom,k);
  Find(bottom+min);
  tot:=0;
  for c1:=1 to slist.level do begin
    slist.header^.link[c1]:=update[c1]^.link[c1];
    slist.header^.sum[c1]:=update[c1]^.sum[c1];
    dec(slist.header^.sum[c1],tot);
    inc(tot,totnum[c1]);
  end;
  while (slist.level>1)and(slist.header^.link[slist.header^.level-1]=slist.tail) do begin
    slist.header^.sum[slist.level]:=0;
    dec(slist.level);
    dec(slist.header^.level);
    dec(slist.tail^.level);
  end;
  inc(left,tot);
  dec(totp,tot);
end;

procedure Findnum;
var
  x:snode;
  c1:integer;
begin
  k:=totp-k+1;
  if k<=0 then writeln(fo,-1) else begin
    x:=slist.header;
    for c1:=slist.level downto 1 do begin
      while (x<>slist.tail)and(x^.sum[c1]<k)and(k>0)do begin
        dec(k,x^.sum[c1]);
        x:=x^.link[c1];
      end;
    end;
    x:=x^.link[1];
    writeln(fo,x^.key-bottom);
  end;
end;

begin
  Starttime:=time;
  initialize;
  assign(f,infile);  reset(f);
  assign(fo,outfile); rewrite(fo);
  readln(f,n,min);
  for test:=1 to n do begin
    readln(f,order,k);
    case order of
      'I':Ins;
      'A':Add;
      'S':Substract;
      'F':FindNum;
    end;
  end;
  writeln(fo,left);
  close(fo);
  close(f);
  assign(f,logfile);
  rewrite(f);
  write(f,'Total Time : ');
  write(f,(time-starttime)*24*60*60:0:3);
  writeln(f,' s');
  close(f);
end.
