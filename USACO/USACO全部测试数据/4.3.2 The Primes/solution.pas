{
PROG:prime3
LANG:PASCAL
ID:asiapea1
}
const
  maxn=99999;
var
  p:array[1..maxn] of boolean;
  pp:array[0..9,0..9,0..9,0..9,0..9] of boolean;
  a:array[1..5,1..5] of integer;
  ans:array[1..250,1..5,1..5] of integer;
  np1,np3:array[0..9] of longint;
  np15:array[0..9,0..9] of longint;
  np135,np234:array[0..9,0..9,0..9] of longint;
  np1245:array[0..9,0..9,0..9,0..9] of longint;
  p1,p3:array[0..9,0..4000,1..5] of longint;
  p15:array[0..9,0..9,0..500,1..5] of longint;
  p135,p234:array[0..9,0..9,0..9,0..50,1..5] of longint;
  p1245:array[0..9,0..9,0..9,0..9,0..10,1..5] of longint;
  all,n:longint;
procedure init;
var i,j,num:longint;
begin
  readln(all,a[1,1]);
  fillchar(p,sizeof(p),true);
  for i:=2 to 317 do
   if p[i] then
   begin
   j:=i+i;
   while j<maxn do
    begin
    p[j]:=false;
    inc(j,i);
    end;
   end;
  num:=0;
end;
 
procedure ready;
var i,x,r,j:longint;
    g:array[1..5] of longint;
begin
  for i:=10000 to maxn do
   if p[i] then
    begin
    x:=i; j:=5;
    while x>0 do
     begin
     r:=x mod 10;
     x:=x div 10;
     g[j]:=r;
     dec(j);
     end;
    if g[1]+g[2]+g[3]+g[4]+g[5]<>all then continue;
    pp[g[1],g[2],g[3],g[4],g[5]]:=true;
    inc(np1[g[1]]);
    for j:=1 to 5 do p1[g[1],np1[g[1]],j]:=g[j];
    inc(np3[g[3]]);
    for j:=1 to 5 do p3[g[3],np3[g[3]],j]:=g[j];
    inc(np15[g[1],g[5]]);
    for j:=1 to 5 do p15[g[1],g[5],np15[g[1],g[5]],j]:=g[j];
    inc(np234[g[2],g[3],g[4]]);
    for j:=1 to 5 do p234[g[2],g[3],g[4],np234[g[2],g[3],g[4]],j]:=g[j];
    inc(np135[g[1],g[3],g[5]]);
    for j:=1 to 5 do p135[g[1],g[3],g[5],np135[g[1],g[3],g[5]],j]:=g[j];
    inc(np1245[g[1],g[2],g[4],g[5]]);
    for j:=1 to 5 do p1245[g[1],g[2],g[4],g[5],np1245[g[1],g[2],g[4],g[5]],j]:=g[j];
    end;
end;
 
procedure try;
var k1,k2,i1,i2,i3,i4,i5,j1,j2j,j3,j4,j5,x,s1,s2:longint;
    flag:boolean;
begin
  for k1:=1 to np1[a[1,1]] do
    begin
    for x:=2 to 5 do a[x,x]:=p1[a[1,1],k1,x];
 
    for k2:=1 to np3[a[3,3]] do
      begin
      if not odd(p3[a[3,3],k2,1]) then continue;
      for x:=1 to 5 do a[x,6-x]:=p3[a[3,3],k2,6-x];
      for j3:=1 to np3[a[3,3]] do
        begin
        for x:=1 to 5 do a[x,3]:=p3[a[3,3],j3,x];
        for i1:=1 to np135[a[1,1],a[1,3],a[1,5]] do
          begin
          flag:=false;
          for x:=2 to 4 do
           begin
           a[1,x]:=p135[a[1,1],a[1,3],a[1,5],i1,x];
           if a[1,x]=0 then flag:=true;
           end;
          if flag then continue;
          for i5:=1 to np135[a[5,1],a[5,3],a[5,5]] do
            begin
            flag:=false;
            for x:=2 to 4 do
             begin
             a[5,x]:=p135[a[5,1],a[5,3],a[5,5],i5,x];
             if not odd(a[5,x]) then flag:=true;
             end;
            if flag then continue;
            a[3,2]:=all-a[2,2]-a[1,2]-a[4,2]-a[5,2];
            a[3,4]:=all-a[2,4]-a[1,4]-a[4,4]-a[5,4];
            if (a[3,2]<0) or (a[3,4]<0) or (a[3,2]>9) or (a[3,4]>9) then continue;
            if not pp[a[1,2],a[2,2],a[3,2],a[4,2],a[5,2]] or not pp[a[1,4],a[2,4],a[3,4],a[4,4],a[5,4]] then continue;
            for i4:=1 to np234[a[4,2],a[4,3],a[4,4]] do
             begin
             for x:=1 to 5 do a[4,x]:=p234[a[4,2],a[4,3],a[4,4],i4,x];
             for i2:=1 to np234[a[2,2],a[2,3],a[2,4]] do
              begin
              for x:=1 to 5 do a[2,x]:=p234[a[2,2],a[2,3],a[2,4],i2,x];
              a[3,1]:=all-a[1,1]-a[2,1]-a[4,1]-a[5,1];
              a[3,5]:=all-a[1,5]-a[2,5]-a[4,5]-a[5,5];
              if (a[3,1]<0) or (a[3,5]<0) or (a[3,1]>9) or (a[3,5]>9) then continue;
              if pp[a[1,1],a[2,1],a[3,1],a[4,1],a[5,1]] and pp[a[1,5],a[2,5],a[3,5],a[4,5],a[5,5]] and pp[a[3,1],a[3,2],a[3,3],a[3,4],a[3,5]] then
               begin
               inc(n);
               ans[n]:=a;
               end;
              end;
             end;
            end;
          end;
        end;
      end;
    end;
end;
 
procedure print;
var t,i,j:longint;
    q:array[1..250] of string;
    temp:string;
begin
  for t:=1 to n do
   begin
   q[t]:='';
   for i:=1 to 5 do
   for j:=1 to 5 do
    q[t]:=q[t]+chr(ans[t,i,j]+48);
   end;
  for i:=1 to n-1 do
  for j:=i+1 to n do
   begin
   if q[j]<q[i] then
    begin
    temp:=q[j];
    q[j]:=q[i];
    q[i]:=temp;
    end;
   end;
 
  for t:=1 to n do
   begin
   for i:=1 to 25 do
    if i mod 5=0 then writeln(q[t][i]) else write(q[t][i]);
   if t<>n then writeln;
   end;
end;
 
procedure openf;
begin
  assign(input,'prime3.in');  reset(input);
  assign(output,'prime3.out');rewrite(output);
end;
 
procedure closef;
begin
  close(input);  close(output);
end;
 
begin
  openf;
  init;
  ready;
  try;
  print;
  closef;
end.