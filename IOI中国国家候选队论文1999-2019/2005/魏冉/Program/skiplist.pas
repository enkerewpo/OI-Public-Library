Program skiplist;
const
  infile='skiplist.in';
  outfile='skiplist.out';
  MaxLevel=100;
  inf=2000000000;

type
  Valuetype = longint;
  Snode=^Skiptype;
  Skiptype=record
             key:longint;
             value:Valuetype;
             next:array[1..MaxLevel] of Snode;
           end;
  Listtype=record
             level:integer;
             header,tail:Snode;
           end;

var
  Emptynode:Skiptype;
  result,newvalue:Valuetype;
  t,n,key:longint;
  f,fo:text;
  order:char;
  List:Listtype;
  update:array[1..MaxLevel] of Snode;

Procedure Initialize;
var
  i:integer;
begin
  fillchar(Emptynode,sizeof(Emptynode),0);
  List.level:=1; new(List.header);
  List.header^:=Emptynode; List.header^.key:=-inf;
  new(List.tail); List.tail^:=Emptynode;
  for i:=1 to MaxLevel do List.header^.next[i]:=List.tail;
  List.tail^.key:=inf;
  for i:=1 to MaxLevel do update[i]:=List.header;
end;

Function Random_Level : integer;    {p=0.5}
var
  lev:integer;
begin
  lev:=1;
  while random<0.5 do lev:=lev+1;
  Random_Level:=lev;
end;

Function Find_Element(var List:Listtype; SearchKey:longint; var res:Valuetype) : boolean;
var
  x:Snode;
  i:integer;
begin
  x:=List.header;
  for i:=List.level downto 1 do
    while x^.next[i]^.key<SearchKey do x:=x^.next[i];
  x:=x^.next[1];
  if x^.key=Searchkey then begin res:=x^.value; Find_Element:=true end
                      else Find_Element:=false;
end;

Procedure Insert_Element(var List:Listtype; SearchKey:longint; Newvalue:Valuetype);
var
  x:Snode;
  lvl,i:integer;
  update:array[1..MaxLevel] of Snode;
begin
  x:=List.header;
  for i:=List.level downto 1 do begin
    while x^.next[i]^.key<SearchKey do x:=x^.next[i];
    update[i]:=x;
  end;
  if x^.next[1]^.key=SearchKey then begin
    x:=x^.next[1];
    x^.value:=Newvalue;
  end else begin
    lvl:=Random_level;
    if lvl>List.level then begin
      for i:=List.level+1 to lvl do update[i]:=List.header;
      List.level:=lvl+1;
    end;
    new(x);
    x^:=Emptynode;
    x^.key:=SearchKey;
    x^.value:=Newvalue;
    for i:=1 to lvl do begin
      x^.next[i]:=update[i]^.next[i];
      update[i]^.next[i]:=x;
    end;
  end;
end;

Procedure Delete_Element(var List:Listtype; SearchKey:longint);
var
  x:Snode;
  i:integer;
  update:array[1..MaxLevel] of Snode;
begin
  x:=List.header;
  for i:=List.level downto 1 do begin
    while x^.next[i]^.key<SearchKey do x:=x^.next[i];
    update[i]:=x;
  end;
  if x^.next[1]^.key=SearchKey then begin
    x:=x^.next[1];
    for i:=1 to List.level do begin
      if update[i]^.next[i]^.key<>SearchKey then break;
      update[i]^.next[i]:=x^.next[i];
    end;
    dispose(x);
    while (List.level>1)and(List.header^.next[List.level-1]^.key=key-inf) do
      dec(List.level);
  end;
end;

Function Find_Element_with_Finger(var List:Listtype; SearchKey:longint; var res:Valuetype) : boolean;
var
  x:Snode;
  lvl,i:integer;
begin
  lvl:=2;
  if update[1].key<SearchKey then begin
    while (lvl<=List.level)and(update[lvl].next[lvl].key<SearchKey) do inc(lvl);
    dec(lvl);
    x:=update[lvl];
  end else begin
    while (lvl<=List.level)and(update[lvl].key>=SearchKey) do inc(lvl);
    x:=update[lvl];
  end;
  for i:=lvl downto 1 do
    while x^.next[i]^.key<SearchKey do x:=x^.next[i];
  x:=x^.next[1];
  if x^.key=Searchkey then begin res:=x^.value; Find_Element_with_Finger:=true end
                      else Find_Element_with_Finger:=false;
end;

procedure Insert_Element_with_Finger(var List:Listtype; SearchKey:longint; Newvalue:Valuetype);
var
  x:Snode;
  lvl,i:integer;
begin
  lvl:=2;
  if update[1].key<SearchKey then begin
    while (lvl<=List.level)and(update[lvl].next[lvl].key<SearchKey) do inc(lvl);
    dec(lvl);
    x:=update[lvl];
  end else begin
    while (lvl<=List.level)and(update[lvl].key>=SearchKey) do begin
      inc(lvl);
    end;
    x:=update[lvl];
  end;
  for i:=lvl downto 1 do begin
    while x^.next[i]^.key<SearchKey do x:=x^.next[i];
    update[i]:=x;
  end;
  if x^.next[1]^.key=SearchKey then begin
    x:=x^.next[1];
    x^.value:=Newvalue;
  end else begin
    lvl:=Random_level;
    if lvl>List.level then begin
      for i:=List.level+1 to lvl do update[i]:=List.header;
      List.level:=lvl+1;
    end;
    new(x);
    x^:=Emptynode;
    x^.key:=SearchKey;
    x^.value:=Newvalue;
    for i:=1 to lvl do begin
      x^.next[i]:=update[i]^.next[i];
      update[i]^.next[i]:=x;
    end;
  end;
end;


Procedure Delete_Element_with_Finger(var List:Listtype; SearchKey:longint);
var
  x:Snode;
  i,lvl:integer;
begin
  lvl:=2;
  if update[1].key<SearchKey then begin
    while (lvl<=List.level)and(update[lvl].next[lvl].key<SearchKey) do inc(lvl);
    dec(lvl);
    x:=update[lvl];
  end else begin
    while (lvl<=List.level)and(update[lvl].key>=SearchKey) do inc(lvl);
    x:=update[lvl];
  end;
  for i:=lvl downto 1 do begin
    while x^.next[i]^.key<SearchKey do x:=x^.next[i];
    update[i]:=x;
  end;
  if x^.next[1]^.key=SearchKey then begin
    x:=x^.next[1];
    for i:=1 to List.level do begin
      if update[i]^.next[i]^.key<>SearchKey then break;
      update[i]^.next[i]:=x^.next[i];
    end;
    dispose(x);
    while (List.level>1)and(List.header^.next[List.level-1]^.key=key-inf) do
      dec(List.level);
  end;
end;

begin
  Randomize;
  Initialize;
  assign(f,infile);   reset(f);
  assign(fo,outfile); rewrite(fo);
  readln(f,n);
  for t:=1 to n do begin
    read(f,order);
    read(f,key);
    case order of
      '*':begin
            Find_Element_with_Finger(List,key,result);
          end;
      '+':begin
            read(f,newvalue);
            Insert_Element_with_Finger(List,key,newvalue);
          end;
      '-':begin
            Delete_Element_with_Finger(List,key);
          end;
    end;
    readln(f);
  end;
  close(fo);
  close(f);
end.
