{
ID:asiapea1
PROB:ditch
LANG:PASCAL
}
program ditch;
var
 n,m,i,j,x,y,maxl:longint;
 max,total,path:longint;
 ca:array[1..200,1..200] of longint;
 flow:array[1..200] of longint;
 pre:array[1..200] of longint;
 visited:array[1..200] of boolean;
 
function min(var x,y:longint):longint;
begin
 if x<y then min:=x else min:=y;
end;
 
begin
 assign(input,'ditch.in');reset(input);
 readln(n,m);
 fillchar(ca,sizeof(ca),0);
 for i:=1 to n do
 begin
  readln(x,y,j);
  inc(ca[x,y],j);
 end;
 close(input);
 
 total:=0;
 
 repeat
  fillchar(pre,sizeof(pre),0);
  fillchar(flow,sizeof(flow),0);
  fillchar(visited,sizeof(visited),0);
  flow[1]:=maxlongint;
 
  while true do
  begin
   max:=0;
   maxl:=0;
   for i:=1 to m do
    if (not visited[i]) and (flow[i]>max) then
    begin
     max:=flow[i];
     maxl:=i;
    end;
   if (maxl=0) or (maxl=m) then break;
   visited[maxl]:=true;
   for i:=1 to m do
    if flow[i]<min(max,ca[maxl,i]) then
    begin
     pre[i]:=maxl;
     flow[i]:=min(max,ca[maxl,i]);
    end;
  end;
 
  if maxl=0 then break;
 
  path:=flow[m];
  inc(total,path);
  i:=m;
  while i<>1 do
  begin
   j:=pre[i];
   dec(ca[j,i],path);
   inc(ca[i,j],path);
   i:=j;
  end;
 until false;
 
 assign(output,'ditch.out');rewrite(output);
 writeln(total);
 close(output);
end.