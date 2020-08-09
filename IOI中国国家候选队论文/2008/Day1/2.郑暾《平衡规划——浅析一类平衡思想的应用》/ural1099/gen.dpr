program gen;
var n,i,j:longint;
begin
 assign(output,'input.in');rewrite(output);
 randomize;
 n:=222;
 writeln(n);
 for i:=1 to n do
  for j:=i+1 to n do
   if random(100)<2 then
    writeln(i,' ',j);
 close(output);
end.
 