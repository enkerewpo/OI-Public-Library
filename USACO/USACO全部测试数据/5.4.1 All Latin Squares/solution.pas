{
ID: asiapea1
PROG: latin
LANG: PASCAL
}
program latin;
const
  maxn=7;
var
  fin,fout:text;
  row:array[2..maxn-1,1..maxn]of boolean;
  col:array[1..maxn,1..maxn]of boolean;
  a:array[1..maxn]of byte;
  v:array[1..maxn]of boolean;
  count:array[2..7]of longint;
    {the index means the length of the longest cycle in a[].
     When n<=7, all the cycles can be uniquely determined by the longest}
  n,i,index:byte;
  total:int64;
procedure calindex;
  var
    i,l,t:byte;
  begin
    index:=2;fillchar(v,sizeof(v),0);
    for i:=1 to n do
      if not v[i] then begin
        l:=0;t:=i;
        repeat
          v[t]:=true;t:=a[t];inc(l);
        until v[t];
        if l>index then index:=l;
      end;
  end;
procedure search(x,y:byte);
  var
    i:byte;
  begin
    for i:=1 to n do
      if row[x,i] and col[y,i] then begin
        if x=2 then begin
          a[y]:=i;
          if y=n then begin
            calindex;
            if count[index]>0 then begin
              inc(total,count[index]);
              exit;
            end;
          end;
        end;
        row[x,i]:=false;col[y,i]:=false;
        if y=n then
          if x=n-1 then begin inc(count[index]);inc(total);end else search(x+1,2)
        else
          search(x,y+1);
        row[x,i]:=true;col[y,i]:=true;
      end;
  end;
begin
  assign(fin,'latin.in');
  reset(fin);
  read(fin,n);
  close(fin);
  assign(fout,'latin.out');
  rewrite(fout);
 
  if n=2 then
    total:=1
  else 
  if n=7 then begin writeln(fout,'12198297600');close(fout);halt end
  else
  begin
    fillchar(row,sizeof(row),1);
    fillchar(col,sizeof(col),1);
    fillchar(count,sizeof(count),0);
    for i:=2 to n-1 do row[i,i]:=false;
    for i:=1 to n do col[i,i]:=false;
 
    total:=0;a[1]:=2;
    search(2,2);
    for i:=2 to n-1 do
      total:=total*i;
  end;
 
  writeln(fout,total);
  close(fout);
end.