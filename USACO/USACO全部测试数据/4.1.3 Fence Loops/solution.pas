{
ID:asiapea1
PROB:fence6
LANG:PASCAL
}
var l,r:array[1..100,0..8]of longint;
    lb,rb:array[1..100,0..100]of boolean;
    d,a:array[1..100]of longint;
    ans,n,ln,rn,q,s,i,j:longint;
    b,c:array[1..100]of boolean;
procedure init;
begin
 assign(input,'fence6.in');reset(input);
 read(n);
 for i:=1 to n do
  begin
   read(q,s,ln,rn);
   a[q]:=s;
   l[q,0]:=ln;
   r[q,0]:=rn;
   for j:=1 to ln do
    begin
     read(l[q,j]);
     lb[q,l[q,j]]:=true;
    end;
   for j:=1 to rn do
    begin
     read(r[q,j]);
     rb[q,r[q,j]]:=true;
    end;
  end;
end;
 
procedure dfs(i,f:longint);
var j:longint;
begin
 b[i]:=false;
 c[i]:=false;
 d[i]:=s;
 s:=s+a[i];
 if not lb[i,f]
            then begin
                   for j:=1 to l[i,0] do
                    if b[l[i,j]] then dfs(l[i,j],i)
                                 else if ans>s-d[l[i,j]]
                                           then ans:=s-d[l[i,j]];
                 end
            else begin
                  for j:=1 to r[i,0] do
                    if b[r[i,j]] then dfs(r[i,j],i)
                                 else if ans>s-d[r[i,j]]
                                           then ans:=s-d[r[i,j]];
                 end;
 s:=s-a[i];
 b[i]:=true;
end;
 
begin
 init;
 fillchar(b,sizeof(b),true);
 fillchar(c,sizeof(c),true);
 ans:=999999999;
 for i:=1 to n do
  if c[i] then begin
                 s:=0;
                 dfs(i,0);
               end;
 assign(output,'fence6.out');rewrite(output);
 writeln(ans);
 close(output);
end.