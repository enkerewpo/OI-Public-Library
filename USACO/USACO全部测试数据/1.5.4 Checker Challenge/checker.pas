{
ID:asiapea1
PROG:checker
LANG:PASCAL
}
prograM checker;
const
  maxn=13;
var
  fff:text;
  x:array [1..maxn] of byte;
  a,b,c,cnt,n,temp,t1:longint;  //same type. more speed.
  even:boolean;
procedure mar;
  begin
    assign(fff,'checker.in');
    reset(fff);
    readln(fff,n);
    close(fff);
    assign(fff,'checker.out');
    rewrite(fff);
    a:=-1 xor 0;
    b:=a;
    c:=a;
    even:=not odd(n);
    if even then temp:=n div 2 else temp:=n div 2 +1;
    t1:=0;
  end;
procedure print;
  var
    i:integer;
  begin
    if cnt<=3 then
      begin
        for i:=1 to n-1 do write(fff,x[i],' ');
        writeln(fff,x[n])
      end;
    if (even) and (x[1]>temp) then begin writeln(fff,cnt+cnt-2); close(fff); halt(0) end;
    if (even=false) and (x[n]=temp) then inc(t1);
    if (even=false) and (x[1]=temp) then begin writeln(fff,t1+t1+cnt+cnt-2); close(fff); halt(0) end
  end;
procedure work(dep:integer);
  var
    r:integer;
  begin
    for r:=1 to n do
      if ((a and (1<<r))<>0)and((b and (1<<(r+dep)))<>0)and((c and (1<<(dep-r+12)))<>0) then
        begin
          x[dep]:=r;
          a:=a and not(1<<r);
          b:=b and not(1<<(r+dep));
          c:=c and not(1<<(dep-r+12));
          if dep=n then
                     begin
                       inc(cnt);
                       print
                     end
                   else
                     work(dep+1);
          a:=a or (1<<r);
          b:=b or (1<<(r+dep));
          c:=c or (1<<(dep-r+12))
        end;
  end;
begin
  mar;
  cnt:=0;
  work(1);
  writeln(fff,cnt);
  close(fff)
end.
