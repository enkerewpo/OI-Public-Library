program pku2103;
type Tarr=array[0..20]of longint;
const maxlen=$40000000;
      maxn=16;
      log=30;
var p,pp,g:array[0..32000]of longint;
    cp,sp,w:array[1..maxn,0..32000]of longint;
    u:array[2..32000]of boolean;
    a:array[1..16]of longint;
    ans,ans1,ans2,tmp:Tarr;
    n:longint;
procedure makeprimlist;
var i,j:longint;
begin
 fillchar(p,sizeof(p),0);
 for i:=2 to 32000 do
  if not(u[i]) then
   begin
    inc(p[0]);
    p[p[0]]:=i;
    for j:=2 to 32000 div i do
     u[i*j]:=true;
   end;
end;
procedure inputint;
var i,j,tmp:longint;
begin
 readln(n);
 for i:=1 to n do
  begin
   read(a[i]);
   tmp:=a[i];
   for j:=1 to p[0] do
    if tmp mod p[j]=0 then
     begin
      inc(cp[i,0]);
      cp[i,cp[i,0]]:=j;
      while tmp mod p[j]=0 do
       begin
        tmp:=tmp div p[j];
        inc(sp[i,cp[i,0]]);
       end;
      pp[j]:=pp[j]+sp[i,cp[i,0]];
      if tmp=1 then break;
     end;
   if tmp>1 then
    begin
     inc(p[0]);
     p[p[0]]:=tmp;
     inc(cp[i,0]);
     cp[i,cp[i,0]]:=p[0];
     sp[i,cp[i,0]]:=1;
     pp[p[0]]:=1;
    end;
  end;
end;
procedure plus(var a,b:Tarr);
var i,t,len:longint;
begin
 if a[0]>b[0] then len:=a[0]
              else len:=b[0];
 t:=0;
 for i:=1 to len do
  begin
   t:=a[i]+b[i]+t;
   if t<maxlen then begin a[i]:=t;t:=0 end
               else begin a[i]:=t-maxlen;t:=1 end;
  end;
 if t>0 then
  begin
   inc(len);
   a[len]:=t 
  end;
 a[0]:=len;
end;
procedure minus(var c,a,b:Tarr);
var t,i:longint;
begin
 fillchar(c,sizeof(c),0);
 t:=0;
 for i:=1 to a[0] do
  begin
   c[i]:=a[i]-b[i]-t;
   if c[i]<0 then
    begin c[i]:=c[i]+maxlen;t:=1 end
   else t:=0;
  end;
 c[0]:=a[0];
 while (c[0]>0)and(c[c[0]]=0) do dec(c[0]);
end;
procedure mul(var a:Tarr;b:int64);
var p:int64;
    i:longint;
begin
 if b=1 then exit;
 p:=0;
 for i:=1 to a[0] do
  begin
   p:=a[i]*b+p shr log;
   a[i]:=p and (maxlen-1);
  end;
 p:=p shr log;
 while p>0 do
  begin
   inc(a[0]);
   a[a[0]]:=p and (maxlen-1);
   p:=p shr log;
  end;
end;
procedure divid(var a:Tarr;b:int64);
var t,tmp:int64;
    i:longint;
begin
 if b=1 then exit;
 t:=0;
 for i:=a[0] downto 1 do
  begin
   tmp:=t*maxlen+a[i];
   a[i]:=tmp div b;
   t:=tmp mod b;
  end;
 while (a[0]>0)and(a[a[0]]=0) do dec(a[0]);
end;
function lmod(var a:Tarr;b:int64):int64;
var p:int64;
    i:longint;
begin
 p:=0;
 for i:=a[0] downto 1 do
  p:=(p*maxlen+a[i]) mod b;
 lmod:=p;
end;
procedure dfs(i,d:longint;tmp:Tarr);
var j,fac:longint;
begin
 if i>n then
  begin
   if d=1 then plus(ans1,tmp)
          else plus(ans2,tmp);
   exit;
  end;
 fac:=1;
 for j:=1 to cp[i,0] do
  begin
   w[i,j]:=g[cp[i,j]];
   while sp[i,j]>g[cp[i,j]] do
    begin
     fac:=fac*p[cp[i,j]];
     inc(g[cp[i,j]]);
    end;
  end;
 mul(tmp,a[i] div fac);
 dfs(i+1,-d,tmp);
 for j:=1 to cp[i,0] do
  g[cp[i,j]]:=w[i,j];
 mul(tmp,fac);
 dfs(i+1,d,tmp);
end;
procedure print(var b:Tarr);
var f:boolean;
    i:longint;
    a:array[1..1000] of longint;
begin
 for i:=1 to 1000 do
  begin
   a[i]:=lmod(b, 10);
   divid(b,10);
  end;
 f:=false;
 for i:=1000 downto 2 do
  begin
   f:=f or (a[i]<>0);
   if f then write(a[i]);
  end;
 writeln(a[1]);
end;
procedure work;
var i,j:longint;
begin
 tmp[0]:=1;
 tmp[1]:=1;
 fillchar(g,sizeof(g),0);
 dfs(1,1,tmp);
 for i:=1 to n do
  mul(tmp,a[i]);
 minus(ans,ans1,ans2);
 for i:=1 to p[0] do
  for j:=1 to pp[i] do
   if lmod(ans,p[i])=0 then
    begin
     divid(ans,p[i]);
     divid(tmp,p[i]);
    end
   else break;
 minus(ans1,tmp,ans);
 print(ans1);
 print(tmp);
end;
begin
 makeprimlist;
 inputint;
 work;
end.
