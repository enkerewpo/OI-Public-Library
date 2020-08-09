{
ID:asiapea1
PROG:sort3
LANG:PASCAL
}
var
  a:array[1..1000]of 1..3;
  t1,t2,i,j,n,time:longint;
  f1,f2:text;
  f:boolean;
  Function Order:boolean;
    begin
      Order:=false;
      for i:=1 to n-1 do
        if a[i]>a[i+1] then exit;
      Order:=true;
    end;
  Procedure Change(p1,p2:longint);
  var
    t:longint;
    begin
      inc(time);
      f:=true;
      t:=a[p1];a[p1]:=a[p2];a[p2]:=t;
    end;
begin
  assign(f1,'sort3.in');
  reset(f1);
  readln(f1,n);
  t1:=0;
  t2:=0;
  for i:=1 to n do
    begin
      readln(f1,a[i]);
      if a[i]=1 then inc(t1);
      if a[i]=2 then inc(t2);
    end;
  close(f1);
  time:=0;
  while not Order do
    begin
      f:=false;
      for i:=1 to t1 do
        for j:=t1+1 to t2+t1 do
          if (a[i]=2) and (a[j]=1) then change(i,j);
      for i:=t1+1 to t1+t2 do
        for j:=t1+t2+1 to n do
          if (a[i]=3) and (a[j]=2) then change(i,j);
      for i:=1 to t1 do
        for j:=t1+t2+1 to n do
          if (a[i]=3) and (a[j]=1) then change(i,j);
      if not f then begin
                      i:=1;
                      while (a[i]=1) and (i<=t1) do
                        inc(i);
                      if i<=t1 then begin
                                      j:=t1+1;
                                      while a[j]<>1 do inc(j);
                                      change(i,j);
                                    end;
                    end;
      if not f then begin
                      i:=t1+1;
                      while (a[i]=1) and (i<=t1+t2) do
                        inc(i);
                      if i<=t1+t2 then begin
                                      j:=1;
                                      while a[j]<>1 do
                                        if j=t1 then j:=t1+t2+1
                                                else inc(j);
                                      change(i,j);
                                    end;
                    end;
      if not f then begin
                      i:=t1+t2+1;
                      while (a[i]=1) and (i<=n) do
                        inc(i);
                      if i<=n then begin
                                      j:=1;
                                      while a[j]<>1 do inc(j);
                                      change(i,j);
                                    end;
                    end;
    end;
  assign(f2,'sort3.out');
  rewrite(f2);
  writeln(f2,time);
  close(f2);
  // Insert user code here
end.