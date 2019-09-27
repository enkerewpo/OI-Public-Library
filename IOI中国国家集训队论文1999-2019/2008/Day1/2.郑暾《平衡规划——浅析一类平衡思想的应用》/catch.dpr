program catch;
const maxn=1000;
var y,next:array[1..maxn shl 1]of longint;
    from,fa,tree,tot,tod:array[1..maxn]of longint;
    tottime:array[0..10]of longint;
    time:longint;
    n,ans,len:longint;
procedure add(a,b:longint);
begin
 inc(len);
 y[len]:=b;
 next[len]:=from[a];
 from[a]:=len;
end;
procedure inputint;
var i,a,b:longint;
begin
 readln(n);
 fillchar(from,sizeof(from),0);
 len:=0;
 for i:=1 to n-1 do
  begin
   readln(a,b);
   add(a,b);
   add(b,a);
  end;
end;
procedure maketree(root:longint);
var i,x:longint;
begin
 fillchar(tree,sizeof(tree),0);
 tree[1]:=root;
 len:=1;
 fillchar(fa,sizeof(fa),$FF);
 for x:=1 to n do
  begin
   i:=from[tree[x]];
   while i<>0 do
    begin
     if y[i]<>fa[tree[x]] then
      begin
       inc(len);
       tree[len]:=y[i];
       fa[y[i]]:=tree[x];
      end;
     i:=next[i];
    end;
  end;
end;
function fmax(x,y:longint):longint;
begin
 if x>y then fmax:=x
        else fmax:=y;
end;
procedure workans(root:longint);
var i,x:longint;
begin
 fillchar(tot,sizeof(tot),0);
 fillchar(tod,sizeof(tod),0);
 for i:=n downto 2 do
  begin
   x:=tree[i];
   tot[x]:=fmax(tot[x],tod[x]+1);
   if tot[x]>tot[fa[x]] then
    begin
     tod[fa[x]]:=tot[fa[x]];
     tot[fa[x]]:=tot[x];
    end
   else if tot[x]>tod[fa[x]] then
    tod[fa[x]]:=tot[x];
  end;
 tot[root]:=fmax(tot[root],tod[root]+1);
 if tot[root]<ans then ans:=tot[root];
end;
procedure work;
var root:longint;
begin
 ans:=maxlongint;
 for root:=1 to n do
  begin
   maketree(root);
   workans(root);
  end;
end;
procedure outputint;
begin
 inc(tottime[ans]);
end;
procedure gen;
var i:longint;
begin
 assign(output,'input.in');rewrite(output);
 writeln(1000);
 for i:=2 to 1000 do
  writeln(i,' ',random(i-1)+1);
 close(output);
end;
begin
 randomize;
 fillchar(tottime,sizeof(tottime),0);
 for time:=1 to 1000 do
  begin
   gen;
   assign(input,'input.in');reset(input);
   inputint;
   work;
   outputint;
   close(input);
  end;
 assign(output,'output.out');rewrite(output);
 for time:=1 to 10 do
  writeln(time,' ',tottime[time]);
 close(output);
end.
