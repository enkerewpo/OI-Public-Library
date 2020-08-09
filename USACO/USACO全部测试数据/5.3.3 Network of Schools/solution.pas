{
ID:asiapea1
PROB:schlnet
LANG:PASCAL
}
var a,a3,a4,a1,a2:array[1..100,0..100]of longint;
    b:array[1..100]of longint;
    q,rd,cd:array[1..100]of longint;
    ans,ii,n,p,i,j,k,x,rd0,cd0,dj:longint;
 
procedure init;
begin
 assign(input,'schlnet.in');reset(input);
 read(n);
 for i:=1 to n do
  begin
   read(x);
   while x<>0 do
    begin
     a3[i,x]:=1;
     a4[x,i]:=1;
     read(x);
    end;
  end;
 for i:=1 to n do
  for j:=1 to n do
   if a3[i,j]>0 then begin
                      inc(a1[i,0]);
                      a1[i,a1[i,0]]:=j;
                     end;
 for i:=1 to n do
  for j:=1 to n do
   if a4[i,j]>0 then begin
                      inc(a2[i,0]);
                      a2[i,a2[i,0]]:=j;
                     end;
end;
 
procedure dfs1(i:longint);
var j:longint;
begin
 b[i]:=1;
 for j:=1 to a1[i,0] do
  if b[a1[i,j]]=0 then dfs1(a1[i,j]);
 inc(p);
 q[p]:=i;
end;
 
procedure dfs2(i:longint);
var j:longint;
begin
 b[i]:=ii;
 for j:=1 to a2[i,0] do
  if b[a2[i,j]]=0 then dfs2(a2[i,j]);
end;
 
procedure dfs(i:longint);
var j:longint;
begin
 b[i]:=1;
 for j:=1 to ii do
  if (b[j]=0) and (a[i,j]=1) then dfs(j);
end;
 
procedure worka;
begin
 fillchar(b,sizeof(b),0);
 for i:=1 to ii do
  if rd[i]=0 then begin
                   inc(ans);
                   dfs(i);
                  end;
 for i:=1 to ii do
  if b[i]=0 then begin
                  inc(ans);
                  dfs(i);
                 end;
end;
 
procedure workb;
begin
 for i:=1 to ii do
  begin
   if rd[i]=0 then inc(rd0);
   if cd[i]=0 then inc(cd0);
  end;
end;
 
begin
 init;
 for i:=1 to n do
  if b[i]=0 then dfs1(i);
 fillchar(b,sizeof(b),0);
 for i:=n downto 1 do
  if b[q[i]]=0 then begin
                     inc(ii);
                     dfs2(q[i]);
                    end;
 for i:=1 to n do
  for j:=1 to a1[i,0] do
     a[b[i],b[a1[i,j]]]:=1;
 for i:=1 to ii do
  for j:=1 to ii do
   if (i<>j)and(a[i,j]=1)
               then begin
                     inc(rd[j]);
                     inc(cd[i]);
                    end;
 worka;
 workb;
 assign(output,'schlnet.out');rewrite(output);
 writeln(ans);
 if rd0>cd0 then writeln(rd0)
            else if (rd0=ii)and(ii=1)
                       then writeln(0)
                       else writeln(cd0);
 close(output);
end.