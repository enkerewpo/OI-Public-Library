{
ID:asiapea1
PROB:telecow
LANG:PASCAL
}
var a,d:array[1..200,0..200]of longint;
    c2,c,cbak:array[1..200,1..200]of longint;
    b,bb:array[1..100]of boolean;
    cut,ans,q,p:array[1..200]of longint;
    maxflow,p1,p2,x,y,n,m,s,t,s2,t1,i:longint;
 
procedure init;
begin
 assign(input,'telecow.in');reset(input);
 read(n,m,s,t);
 s2:=s*2;
 t1:=t*2-1;
 for i:=1 to m do
  begin
   read(x,y);
   inc(d[x,0]);
   d[x,d[x,0]]:=y;
   inc(d[y,0]);
   d[y,d[y,0]]:=x;
 
   inc(a[x*2,0]);
   a[x*2,a[x*2,0]]:=y*2-1;
   c[x*2,y*2-1]:=999999999;
   inc(a[y*2-1,0]);
   a[y*2-1,a[y*2-1,0]]:=x*2;
   c[y*2-1,x*2]:=0;
 
   inc(a[y*2,0]);
   a[y*2,a[y*2,0]]:=x*2-1;
   c[y*2,x*2-1]:=999999999;
   inc(a[x*2-1,0]);
   a[x*2-1,a[x*2-1,0]]:=y*2;
   c[x*2-1,y*2]:=0;
  end;
 
 for i:=1 to n do
  begin
   inc(a[i*2-1,0]);
   a[i*2-1,a[i*2-1,0]]:=i*2;
   c[i*2-1,i*2]:=1;
   inc(a[i*2,0]);
   a[i*2,a[i*2,0]]:=i*2-1;
   c[i*2,i*2-1]:=0;
  end;
 cbak:=c;
end;
 
function find:boolean;
var j:longint;
begin
 fillchar(p,sizeof(p),255);
 p1:=1;p2:=1;
 q[1]:=s2; p[s2]:=0;
 repeat
  for j:=1 to a[q[p1],0] do
   if (p[a[q[p1],j]]<0)and (c[q[p1],a[q[p1],j]]>0)
      then begin
            inc(p2);
            q[p2]:=a[q[p1],j];
            p[q[p2]]:=q[p1];
            if q[p2]=t1 then exit(true);
           end;
  inc(p1);
 until p1>p2;
 exit(false);
end;
 
function flow:longint;
var i,f:longint;
begin
  f:=0;
  repeat
   if find then begin
                  i:=t1;
                  inc(f);
                  while p[i]<>0 do
                   begin
                    dec(c[p[i],i]);
                    inc(c[i,p[i]]);
                    i:=p[i];
                   end;
                end
           else break;
  until false;
 exit(f);
end;
 
procedure docut;
begin
 maxflow:=flow;
 c2:=c;
 x:=0;
 for i:=1 to n do
  if (i<>s) and (i<>t) and (c[i*2-1,i*2]=0)
   then begin
         c:=cbak;
         c[i*2-1,i*2]:=0;
         if maxflow=flow+1 then begin
                                  inc(x);
                                  cut[x]:=i;
                                end;
        end;
end;
 
procedure out;
begin
  assign(output,'telecow.out');rewrite(output);
  writeln(maxflow);
  for i:=1 to maxflow-1 do
    write(ans[i],' ');
  writeln(ans[maxflow]);
  close(output);
  halt;
end;
 
function ok(i:longint):boolean;
var j:longint;
begin
 if i=t then exit(true);
 bb[i]:=false;
 for j:=1 to d[i,0] do
  if b[d[i,j]] and bb[d[i,j]] and ok(d[i,j])
               then exit(true);
 exit(false);
end;
 
procedure dfs(i,last:longint);
var j:longint;
begin
 if i=maxflow+1 then begin
                      fillchar(bb,sizeof(bb),true);
                      if not ok(s) then out;
                      exit;
                     end;
 for j:=last+1 to x do
  begin
   ans[i]:=cut[j];
   b[cut[j]]:=false;
   dfs(i+1,j);
   b[cut[j]]:=true;
  end;
end;
 
begin
 init;
 docut;
 fillchar(b,sizeof(b),true);
 dfs(1,0);
end.