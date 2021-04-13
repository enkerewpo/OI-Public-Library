{$M 64000000}
program pku3237;
const maxn=10001;
      limit=10000000;
var x,y,v,next:array[1..maxn+maxn]of longint;
    ed,whe,list,from,fa,root,fedge,after,fr,RMQ_whe,deep:array[1..maxn]of longint;
    sign:array[1..maxn*4]of boolean;
    lg,tree,lc,rc,tmin:array[1..maxn*4]of longint;
    RMQ:array[0..14,1..maxn*3]of longint;
    n,len,num,treelen,quesnum,ques:longint;
procedure add(a,b,c:longint);
begin
 inc(len);
 x[len]:=a;
 y[len]:=b;
 v[len]:=c;
 next[len]:=from[a];
 from[a]:=len;
end;
procedure swap(var x,y:longint);
var t:longint;
begin
 t:=x;x:=y;y:=t;
end;
procedure inputint;
var i,a,b,c:longint;
begin
 readln(n);
 fillchar(from,sizeof(from),0);
 len:=0;
 for i:=1 to n-1 do
  begin
   readln(a,b,c);
   if a>b then swap(a,b);
   add(a,b,c);
   add(b,a,c);
  end;
end;
function fmax(x,y:longint):longint;
begin
 if x>y then fmax:=x else fmax:=y;
end;
function fmin(x,y:longint):longint;
begin
 if x<y then fmin:=x else fmin:=y;
end;
procedure maketree;
var i,k,len:longint;
begin
 fillchar(fa,sizeof(fa),0);
 tree[1]:=1;k:=1;len:=1;fa[1]:=-1;
 repeat
  i:=from[tree[k]];
  while i>0 do
   begin
    if fa[y[i]]=0 then
     begin
      inc(len);
      tree[len]:=y[i];
      fa[y[i]]:=tree[k];
      fedge[y[i]]:=i;
     end;
    i:=next[i];
   end;
  inc(k);
 until k>len;
end;
procedure RMQ_makelist(x,d:longint);
var i:longint;
begin
 inc(num);
 RMQ[0,num]:=x;
 RMQ_whe[x]:=num;
 deep[x]:=d;
 i:=from[x];
 while i>0 do
  begin
   if fa[y[i]]=x then
    begin
     RMQ_makelist(y[i],d+1);
     inc(num);
     RMQ[0,num]:=x;
    end;
   i:=next[i];
  end;
end;
procedure make_RMQ;
var len,k,i:longint;
begin
 num:=0;
 RMQ_makelist(1,1);
 len:=2;k:=1;
 while len<=num do
  begin
   for i:=1 to num-len+1 do
    if deep[RMQ[k-1,i]]<deep[RMQ[k-1,i+len shr 1]] then
     RMQ[k,i]:=RMQ[k-1,i]
    else RMQ[k,i]:=RMQ[k-1,i+len shr 1];
   inc(k);
   len:=len shl 1;
  end;
 lg[1]:=0;k:=0;
 for i:=2 to num do
  begin
   if 1 shl (k+1)<=i then inc(k);
   lg[i]:=k;
  end;
end;
function getLCA(a,b:longint):longint;
var k:longint;
begin
 a:=RMQ_whe[a];
 b:=RMQ_whe[b];
 if a>b then swap(a,b);
 k:=lg[b-a+1];         
 if deep[RMQ[k,a]]<deep[RMQ[k,b-1 shl k+1]] then getLCA:=RMQ[k,a]
                                            else getLCA:=RMQ[k,b-1 shl k+1];
end;
procedure buildtree(len,l,r:longint);
begin
 if l=r then
  begin
   tree[len]:=v[fedge[list[l+1]]];
   tmin[len]:=v[fedge[list[l+1]]];
   exit;
  end;
 inc(treelen);
 lc[len]:=treelen;
 buildtree(treelen,l,(l+r)shr 1);
 inc(treelen);
 rc[len]:=treelen;
 buildtree(treelen,(l+r)shr 1+1,r);
 tree[len]:=fmax(tree[lc[len]],tree[rc[len]]);
 tmin[len]:=fmin(tmin[lc[len]],tmin[rc[len]]);
end;
procedure makelist(x:longint);
var sta,i,j:longint;
begin
 if after[x]=0 then exit;
 sta:=x;
 repeat
  inc(num);
  fr[x]:=sta;
  whe[x]:=num;
  list[num]:=x;
  x:=after[x];
 until x=0;
 ed[sta]:=num;
 inc(treelen);
 root[sta]:=treelen;
 buildtree(treelen,whe[sta],ed[sta]-1);
 for j:=whe[sta] to ed[sta] do
  begin
   x:=list[j];
   i:=from[x];
   while i>0 do
    begin
     if (y[i]<>after[x])and(y[i]<>fa[x]) then
      makelist(y[i]);
     i:=next[i];
    end;
  end;
end;
procedure makeway;
var i:longint;
begin
 fillchar(list,sizeof(list),0);
 fillchar(after,sizeof(after),0);
 fillchar(fr,sizeof(fr),0);
 for i:=n downto 2 do
  begin
   inc(list[tree[i]]);
   if list[tree[i]]>list[fa[tree[i]]] then
    begin
     list[fa[tree[i]]]:=list[tree[i]];
     after[fa[tree[i]]]:=tree[i];
    end;
  end;
 num:=0;
 makelist(1);
end;
procedure maintain(i:longint);
var t:longint;
begin
 if sign[i] then
  begin
   sign[i]:=false;
   sign[lc[i]]:=not sign[lc[i]];
   sign[rc[i]]:=not sign[rc[i]];
   t:=tree[lc[i]];
   tree[lc[i]]:=-tmin[lc[i]];
   tmin[lc[i]]:=-t;
   t:=tree[rc[i]];
   tree[rc[i]]:=-tmin[rc[i]];
   tmin[rc[i]]:=-t;
   tree[i]:=fmax(tree[lc[i]],tree[rc[i]]);
   tmin[i]:=fmin(tmin[lc[i]],tmin[rc[i]]);
  end;
end;
function check_max(a,b,l,r,i:longint):longint;
var mid:longint;
begin
 if (l=a)and(r=b) then check_max:=tree[i]
 else
  begin
   maintain(i);
   mid:=(l+r)shr 1;
   if b<=mid then check_max:=check_max(a,b,l,mid,lc[i])
   else if a>mid then check_max:=check_max(a,b,mid+1,r,rc[i])
   else check_max:=fmax(check_max(a,mid,l,mid,lc[i]),
                        check_max(mid+1,b,mid+1,r,rc[i]));
  end;
end;
function work_query(a,b:longint):longint;
var t1,t2:longint;
begin
 if a=b then begin work_query:=-limit;exit end;
 if (fr[a]=0)or(fr[a]=a) then
  begin
   t1:=v[fedge[a]];
   t2:=work_query(fa[a],b);
   work_query:=fmax(t1,t2);
  end
 else begin
  if fr[a]<>fr[b] then
   begin
    t1:=check_max(whe[fr[a]],whe[a]-1,whe[fr[a]],ed[fr[a]]-1,root[fr[a]]);
    t2:=work_query(fr[a],b);
    work_query:=fmax(t1,t2);
   end
  else
   work_query:=check_max(whe[b],whe[a]-1,whe[fr[a]],ed[fr[a]]-1,root[fr[a]]);
 end;
end;
procedure tree_change(x,l,r,i,c:longint);
var mid:longint;
begin
 if l=r then begin tree[i]:=c;tmin[i]:=c;sign[i]:=false end
 else begin
  maintain(i);
  mid:=(l+r)shr 1;
  if x<=mid then tree_change(x,l,mid,lc[i],c)
            else tree_change(x,mid+1,r,rc[i],c);
  tree[i]:=fmax(tree[lc[i]],tree[rc[i]]);
  tmin[i]:=fmin(tmin[lc[i]],tmin[rc[i]]);
 end;
end;
procedure work_change(p,c:longint);
var a,b:longint;
begin
 v[p]:=c;v[p+1]:=c;
 if fa[x[p]]=y[p] then begin a:=x[p];b:=y[p] end
                  else begin a:=y[p];b:=x[p] end;
 if (fr[a]<>0)and(fr[a]<>a) then
  tree_change(whe[b],whe[fr[a]],ed[fr[a]]-1,root[fr[a]],c);
end;
procedure tree_negate(a,b,l,r,i:longint);
var t,mid:longint;
begin
 if (a=l)and(b=r) then
  begin
   sign[i]:=not sign[i];
   t:=tree[i];
   tree[i]:=-tmin[i];
   tmin[i]:=-t;
  end
 else
  begin
   maintain(i);
   mid:=(l+r)shr 1;
   if b<=mid then tree_negate(a,b,l,mid,lc[i])
   else if a>mid then tree_negate(a,b,mid+1,r,rc[i])
   else begin
    tree_negate(a,mid,l,mid,lc[i]);
    tree_negate(mid+1,b,mid+1,r,rc[i]);
   end;
   tree[i]:=fmax(tree[lc[i]],tree[rc[i]]);
   tmin[i]:=fmin(tmin[lc[i]],tmin[rc[i]]);
  end;
end;
procedure work_negate(a,b:longint);
begin
 if a=b then exit;
 if (fr[a]=0)or(fr[a]=a) then
  begin
   v[fedge[a]]:=-v[fedge[a]];
   if x[fedge[a]]<y[fedge[a]] then v[fedge[a]+1]:=-v[fedge[a]+1]
                              else v[fedge[a]-1]:=-v[fedge[a]-1];
   work_negate(fa[a],b);
  end
 else
  if fr[a]<>fr[b] then
   begin
    tree_negate(whe[fr[a]],whe[a]-1,whe[fr[a]],ed[fr[a]]-1,root[fr[a]]);
    work_negate(fr[a],b);
   end
  else
   tree_negate(whe[b],whe[a]-1,whe[fr[a]],ed[fr[a]]-1,root[fr[a]]);
end;
procedure work;
var ch:char;
    a,b,ro,t1,t2:longint;
begin
 fillchar(sign,sizeof(sign),0);
 maketree;
 treelen:=0;
 makeway;
 make_RMQ;
 read(ch);
 while ch<>'D' do
  begin
   case ch of
    'Q':begin
         read(ch,ch,ch,ch);
         readln(a,b);
         ro:=getLCA(a,b);
         t1:=work_query(a,ro);
         t2:=work_query(b,ro);
         writeln(fmax(t1,t2));
        end;
    'C':begin
         read(ch,ch,ch,ch,ch);
         readln(a,b);
         work_change(a shl 1-1,b);
        end;
    'N':begin
         read(ch,ch,ch,ch,ch);
         readln(a,b);
         ro:=getLCA(a,b);
         work_negate(a,ro);
         work_negate(b,ro);
        end;
   end;
   read(ch);
  end;
 readln;
end;
begin
 readln(quesnum);
 for ques:=1 to quesnum do
  begin
   readln;
   inputint;
   work;
  end;
end.

