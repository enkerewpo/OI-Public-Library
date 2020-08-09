{
ID:asiapea1
PROB:picture
LANG:PASCAL
}
program picture;
const maxn=10000;
type tree=record
                s,t,l,r,c,m:longint;
          end;
     line=record x,y,f:longint; r:boolean; end;
var p:array[1..maxn shl 2] of tree;
    n,i,x1,x2,y1,y2:longint;
    row,cro:array[1..maxn] of line;
    tot,ans,now,mynew,maxx,miny,maxy,minx:longint;
procedure qsort1(l,r:longint);
var i,j,p:longint;
    t:line;
begin
     i:=l; j:=r; p:=row[(l+r) shr 1].f;
     repeat
           while (row[i].f<p) or (((not row[i].r) and (row[(l+r) shr 1].r)) and (row[i].f=p)) do inc(i);
           while (p<row[j].f) or (((row[j].r) and (not row[(l+r) shr 1].r)) and (row[j].f=p)) do dec(j);
           if i<=j then
           begin
                t:=row[i]; row[i]:=row[j]; row[j]:=t;
                inc(i); dec(j);
           end;
     until i>j;
     if l<j then qsort1(l,j);
     if i<r then qsort1(i,r);
end;
procedure qsort2(l,r:longint);
var i,j,p:longint;
    t:line;
begin
     i:=l; j:=r; p:=cro[(l+r) shr 1].f;
     repeat
           while (cro[i].f<p) or (((not cro[i].r) and (cro[(l+r) shr 1].r)) and (cro[i].f=p)) do inc(i);
           while (p<cro[j].f) or (((cro[j].r) and (not cro[(l+r) shr 1].r)) and (cro[j].f=p)) do dec(j);
           if i<=j then
           begin
                t:=cro[i]; cro[i]:=cro[j]; cro[j]:=t;
                inc(i); dec(j);
           end;
     until i>j;
     if l<j then qsort2(l,j);
     if i<r then qsort2(i,r);
end;
procedure maketree(a,b:longint);
var m,k:longint;
begin
     m:=tot;
     k:=(a+b) div 2;
     p[tot].s:=a; p[tot].t:=b; p[tot].c:=0;
     p[tot].l:=0; p[tot].r:=0; p[tot].m:=0;
     if b-a>1 then
     begin
          inc(tot); p[m].l:=tot; maketree(a,k);
          inc(tot); p[m].r:=tot; maketree(k,b);
     end;
end;
procedure change(k,op,ed,d:longint);
begin
     if p[k].c>0 then p[k].m:=p[k].t-p[k].s else p[k].m:=0;
     if (op<=p[k].s) and (p[k].t<=ed) then
     begin
          p[k].c:=p[k].c+d;
          if p[k].c>0 then p[k].m:=p[k].t-p[k].s else p[k].m:=0;
     end else
     begin
          if (op<=((p[k].s+p[k].t) div 2)) and (p[k].l<>0) then
          begin
               change(p[k].l,op,ed,d);
          end;
          if (ed>=((p[k].s+p[k].t) div 2)) and (p[k].r<>0) then
          begin
               change(p[k].r,op,ed,d);
          end;
     end;
     if p[k].m=0 then
          begin
               if p[k].l<>0 then inc(p[k].m,p[p[k].l].m);
               if p[k].r<>0 then inc(p[k].m,p[p[k].r].m);
          end;
end;
begin
     assign(input,'picture.in'); assign(output,'picture.out');
     reset(input); rewrite(output);
     readln(n); tot:=0;
     minx:=maxn; maxx:=-maxn;
     miny:=maxn; maxy:=-maxn;
     for i:=1 to n do
     begin
          readln(x1,y1,x2,y2);
          if x1<minx then minx:=x1; if x2>maxx then maxx:=x2;
          if y1<miny then miny:=y1; if y2>maxy then maxy:=y2;
          inc(tot);
          row[tot].x:=y1; row[tot].y:=y2; row[tot].f:=x1; row[tot].r:=false;
          cro[tot].x:=x1; cro[tot].y:=x2; cro[tot].f:=y1; cro[tot].r:=false;
          inc(tot);
          row[tot].x:=y1; row[tot].y:=y2; row[tot].f:=x2; row[tot].r:=true;
          cro[tot].x:=x1; cro[tot].y:=x2; cro[tot].f:=y2; cro[tot].r:=true;
     end;
     qsort1(1,2*n);
     tot:=1;
     maketree(miny,maxy);
     change(1,row[1].x,row[1].y,1);
     ans:=row[1].y-row[1].x;
     now:=ans;
     for i:=2 to 2*n do
     begin
          if row[i].r then change(1,row[i].x,row[i].y,-1)
           else
           begin
             change(1,row[i].x,row[i].y,1);
           end;
          mynew:=p[1].m;
          if mynew>now then
          begin
               inc(ans,mynew-now);
          end;
          now:=mynew;
     end;
     qsort2(1,2*n);
     tot:=1;
     maketree(minx,maxx);
     change(1,cro[1].x,cro[1].y,1);
     inc(ans,cro[1].y-cro[1].x);
     now:=cro[1].y-cro[1].x;
     for i:=2 to 2*n do
     begin
          if cro[i].r then change(1,cro[i].x,cro[i].y,-1)
           else
           begin
             change(1,cro[i].x,cro[i].y,1);
           end;
          mynew:=p[1].m;
          if mynew>now then
          begin
               inc(ans,mynew-now);
          end;
          now:=mynew;
     end;
     writeln(ans*2);
     close(input); close(output);
end.
