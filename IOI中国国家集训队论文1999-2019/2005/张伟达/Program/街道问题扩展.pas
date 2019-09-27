const
  maxn=90;
type
  tt=array[1..maxn,1..maxn]of longint;
var
  row,col:byte;
  best,b:tt;
  map:array[0..1]of tt;
  k,m:longint;
procedure init;
  var
    i,j:longint;
  begin
    readln(row,col);
    for i:=1 to row do
      begin
        for j:=1 to col-1 do
          read(map[0,i,j]);
        readln
      end;
    for j:=1 to col do
      begin
        for i:=1 to row-1 do
          read(map[1,i,j]);
        readln;
      end;
  end;
function getET(s,u:longint;var e:longint;var t:longint):boolean;
  begin
    if ((k>=row)and(s=1)and(u=1))or
      (k>=col)and(s=m)and(u=0)
      then begin
        getET:=false;
        exit;
      end;
    if k<row
      then begin
        e:=map[u,k+1-s,s];
        t:=s+1-u;
      end
      else begin
        e:=map[u,row+1-s,k-row+1];
        t:=s-u;
      end;
    getET:=true;
  end;
procedure main;
  var
    s1,s2,
    u1,u2,
    t1,t2,
    m1,m2,
    e1,e2:longint;
  begin
    if row<col
      then begin
        m1:=row;
        m2:=col;
      end
      else begin
        m1:=col;
        m2:=row;
      end;
    best[1,1]:=0;
    for k:=row+col-2 downto 1 do
      begin
        if k<m1
          then m:=k
          else if k>m2
            then m:=row+col-k
            else m:=m1;
        b:=best;
        for s1:=1 to m do
          for s2:=1 to m do
            begin
              best[s1,s2]:=maxlongint;
              for u1:=0 to 1 do
                if getET(s1,u1,e1,t1)
                  then for u2:=0to 1 do
                    begin
                      if ((s1<>s2)or(u1<>u2))and (b[t1,t2]+e1+e2<best[s1,s2])
                        then if getET(s2,u2,e2,t2)
                          then best[s1,s2]:=b[t1,t2]+e1+e2;
                    end;
            end;
      end;
  end;
begin
  init;
  main;
  writeln(best[1,1]);
end.
