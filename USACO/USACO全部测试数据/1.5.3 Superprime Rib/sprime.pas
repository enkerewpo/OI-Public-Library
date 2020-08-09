{
ID:asiapea1
PROG:sprime
LANG:PASCAL
}
var
  n:byte;
function flag(i:longint):boolean;
var
  j:longint;
begin
  flag:=true;
  if i=1 then begin
    flag:=false;
    exit;
  end;
  for j:=2 to trunc(sqrt(i)) do
    if i mod j=0 then begin
      flag:=false;
      exit;
    end;
end;
procedure sub(a,b:longint);
begin
  if a=n then writeln(b)
         else begin
           if flag(b*10+1) then sub(a+1,b*10+1);
           if flag(b*10+3) then sub(a+1,b*10+3);
           if flag(b*10+7) then sub(a+1,b*10+7);
           if flag(b*10+9) then sub(a+1,b*10+9);
         end;
end;
begin
  assign(input,'sprime.in');  reset(input);
  assign(output,'sprime.out');  rewrite(output);
  readln(n);
  sub(1,2);
  sub(1,3);
  sub(1,5);
  sub(1,7);
  close(input);  close(output);
end.