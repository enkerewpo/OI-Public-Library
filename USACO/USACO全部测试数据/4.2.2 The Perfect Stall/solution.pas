{
ID:asiapea1
PROB:stall4
LANG:PASCAL
}
program stall4;
var
 like:array[1..200,1..200] of boolean;
 yes:array[1..200] of boolean;
 l:array[1..200] of integer;
 n,m,i,j,x,y,sum:integer;
 
function check(x:integer):boolean;
var
 i:integer;
begin
 for i:=1 to m do
  if (like[x,i]) and (not yes[i]) then
  begin
   yes[i]:=true;
   if (l[i]=0) or (check(l[i])) then
   begin
    l[i]:=x;
    check:=true;
    exit;
   end;
  end;
 check:=false;
end;
 
begin
 assign(input,'stall4.in');reset(input);
 readln(n,m);
 fillchar(like,sizeof(like),0);
 for i:=1 to n do
 begin
  read(x);
  for j:=1 to x do
  begin
   read(y);
   like[i,y]:=true;
  end;
  readln;
 end;
 close(input);
 
 fillchar(l,sizeof(l),0);
 sum:=0;
 for i:=1 to n do
 begin
  fillchar(yes,sizeof(yes),0);
  if check(i) then inc(sum);
 end;
 
 assign(output,'stall4.out');rewrite(output);
 writeln(sum);
 close(output);
end.