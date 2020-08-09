{
ID: asiapea1
PROG: stamps
LANG: PASCAL
}
program stamps;
var
   mon:array[0..2000000] of longint;
   stm:array[1..50] of longint;
   l1,l2,n,m:longint;
begin
   assign(input,'stamps.in');
   assign(output,'stamps.out');
   reset(input);
   rewrite(output);
   readln(n,m);
   for l1:=1 to m do
      read(stm[l1]);
   mon[0]:=0;
   l1:=0;
   repeat
      inc(l1);
      mon[l1]:=n+1;
      for l2:=1 to m do
         if (stm[l2]<=l1) and (mon[l1-stm[l2]]+1<mon[l1]) then
            mon[l1]:=mon[l1-stm[l2]]+1;
      if mon[l1]=n+1 then
         break;
   until false;
   for l1:=1 to 2000000 do
      if mon[l1]=n+1 then
         break;
   writeln(l1-1);
   close(input);
   close(output);
end.