program voronoi_dc;
const
  maxn=200;
  zero=1e-7;
type
  point=record
    x,y:double;
    k:longint;
  end;
  edge=^Tedge;
  Tedge=record
    x:longint;
    next:edge;
  end;
var
  way:array[1..maxn,1..maxn]of boolean;
  used,a:array[1..maxn]of longint;
  check:array[1..maxn]of boolean;
  e_free:array[1..maxn*maxn]of edge;
  p:array[1..maxn]of point;
  v:array[1..maxn]of edge;
  tot,m,n:longint;

procedure sort(l,r:longint);
var
  t:point;
  x,y:double;
  i,j:longint;
begin
  x:=p[(l+r) div 2].x;
  y:=p[(l+r) div 2].y;
  i:=l;j:=r;
  while true do begin
    while (p[i].x<x)or((p[i].x=x)and(p[i].y<y)) do inc(i);
    while (p[j].x>x)or((p[j].x=x)and(p[j].y>y)) do dec(j);
    if j>i then begin
      t:=p[i];
      p[i]:=p[j];
      p[j]:=t;
      inc(i);dec(j);
    end
    else break;
  end;
  if j>l then sort(l,j);
  if j<r then sort(j+1,r);
end;

procedure init;
var
  i:longint;
begin
  readln(n);
  for i:=1 to n do begin
    readln(p[i].x,p[i].y);
    p[i].k:=i;
    v[i]:=nil;
  end;
  sort(1,n);
end;

procedure get_bis(x,y:point;var p1,p2:point);
begin
  p1.x:=(x.x+y.x)/2;
  p1.y:=(x.y+y.y)/2;
  if abs(x.y-y.y)<zero then begin
    p2.x:=p1.x;
    p2.y:=1+p1.y;
  end
  else begin
    p2.x:=1+p1.x;
    p2.y:=-(p2.x-p1.x)*(y.x-x.x)/(y.y-x.y)+p1.y;
  end;
end;

procedure get_line(p1,p2:point;var a,b,c:double);
begin
  if p1.y=p2.y then begin
    a:=0;c:=-p1.y;b:=1;
  end
  else if p1.x=p2.x then begin
    b:=0;c:=-p1.x;a:=1;
  end
  else if abs(p2.x*p1.y-p2.y*p1.x)<=zero then begin
    c:=0;
    b:=1;
    if p1.x=0 then a:=-p2.y/p2.x
    else a:=-p1.y/p1.x;
  end
  else begin
    c:=1;
    b:=-(p2.x-p1.x)/(p2.x*p1.y-p2.y*p1.x);
    a:=-(p2.y-p1.y)/(p1.x*p2.y-p2.x*p1.y);
  end;
end;

function oneline(p1,p2,p3,p4:point):boolean;
begin
  oneline:=false;
  if abs((p2.x-p1.x)*(p4.y-p3.y)-(p2.y-p1.y)*(p4.x-p3.x))<=zero then oneline:=true;
  if abs((p1.x-p2.x)*(p4.y-p3.y)-(p1.y-p2.y)*(p4.x-p3.x))<=zero then oneline:=true;
  if abs((p2.x-p1.x)*(p3.y-p4.y)-(p2.y-p1.y)*(p3.x-p4.x))<=zero then oneline:=true;
  if abs((p1.x-p2.x)*(p3.y-p4.y)-(p1.y-p2.y)*(p3.x-p4.x))<=zero then oneline:=true;
end;

function get_inter(p1,p2,p3,p4:point;var p:point):boolean;
var
  a1,b1,c1,a2,b2,c2:double;
begin
  get_line(p1,p2,a1,b1,c1);
  get_line(p3,p4,a2,b2,c2);
  if oneline(p1,p2,p3,p4) then begin
    get_inter:=false;
    exit;
  end
  else get_inter:=true;
  if (a1=0)or(a2=0) then begin
    if a1=0 then begin
      p.y:=-c1/b1;
      if a2<>0 then p.x:=(-c2-b2*p.y)/a2;
    end;
    if a2=0 then begin
      p.y:=-c2/b2;
      if a1<>0 then p.x:=(-c1-b1*p.y)/a1;
    end;
  end
  else if (b1=0)or(b2=0) then begin
    if b1=0 then begin
      p.x:=-c1/a1;
      if b2<>0 then p.y:=(-c2-a2*p.x)/b2;
    end;
    if b2=0 then begin
      p.x:=-c2/a2;
      if b1<>0 then p.y:=(-c1-a1*p.x)/b1;
    end;
  end
  else begin
    p.x:=(-b2*c1+b1*c2)/(b2*a1-b1*a2);
    p.y:=(-a2*c1+a1*c2)/(a2*b1-a1*b2);
  end;
end;

function get_sit(p1,p2,p3:point):double;
begin
  get_sit:=(p2.x-p1.x)*(p3.y-p1.y)-(p3.x-p1.x)*(p2.y-p1.y);
end;

procedure get_tang(l,k,r:longint;var p1,p2,p3,p4:longint);
var
  xx,i,tot:longint;
begin
  tot:=2;
  fillchar(a,sizeof(a),0);
  fillchar(check,sizeof(check),false);
  a[1]:=l;a[2]:=l+1;i:=l+2;
  check[l]:=true;check[l+1]:=true;
  while i<=r do begin
    if not check[i] then begin
      while (tot>1)and(get_sit(p[a[tot-1]],p[a[tot]],p[i])<0) do begin
        check[a[tot]]:=false;
        a[tot]:=0;
        dec(tot);
      end;
      inc(tot);
      check[i]:=true;
      a[tot]:=i;
    end;
    inc(i);
  end;
  for i:=1 to tot do if a[i]>k then break;
  p1:=a[i-1];p2:=a[i];
  xx:=tot;
  for i:=a[tot] downto l do
    if not check[i] then begin
      check[i]:=true;
      inc(tot);
      a[tot]:=i;
      break;
    end;
  while i>=a[1] do begin
    if (not check[i])or(i=a[1]) then begin
      while (tot>xx)and(get_sit(p[a[tot-1]],p[a[tot]],p[i])<0) do begin
        check[a[tot]]:=false;
        a[tot]:=0;
        dec(tot);
      end;
      inc(tot);
      check[i]:=true;
      a[tot]:=i;
    end;
    dec(i);
  end;
  for i:=tot downto 1 do
    if a[i]>k then break;
  p4:=a[i];p3:=a[i+1];
end;

procedure set_memory;
var
  i:longint;
begin
  m:=n*n;
  for i:=1 to m do
    new(e_free[i]);
end;

function get_memory:edge;
begin
  dec(m);
  get_memory:=e_free[m+1];
end;

procedure add_edge(x,y:longint);
var
  e:edge;
begin
  if way[x,y] then exit;
  e:=get_memory;
  e^.next:=v[x];
  e^.x:=y;
  v[x]:=e;
  way[x,y]:=true;
end;

function get_dis(a,b:point):double;
begin
  get_dis:=sqrt(sqr(a.x-b.x)+sqr(a.y-b.y));
end;

procedure del_edge(x,y:longint);
var
  ee,e:edge;
begin
  way[x,y]:=false;
  e:=v[x];
  if e^.x=y then v[x]:=e^.next
  else begin
    while e^.next^.x<>y do e:=e^.next;
    ee:=e;
    e:=e^.next;
    ee^.next:=e^.next
  end;
  inc(m);
  e_free[m]:=e;
end;

function get_three(a,b,c:point):point;
var
  p1,p2,p3,p4,p:point;
begin
  get_bis(a,b,p1,p2);
  get_bis(c,a,p3,p4);
  if not get_inter(p1,p2,p3,p4,p) then p.y:=1e100;
  get_three:=p;
end;

procedure del_all(a,b,c,pd,l,r:longint);
var
  e:edge;
  x:longint;
begin
  e:=v[a];
  while e<>nil do
    if (get_sit(p[b],p[c],p[e^.x])*pd<0)and(e^.x<>b)and(get_sit(p[a],p[b],p[e^.x])*pd>0)and(e^.x>=l)and(e^.x<=r) then begin
      x:=e^.x;
      e:=e^.next;
      del_edge(a,x);
      del_edge(x,a);
    end
    else e:=e^.next;
end;

procedure merge(min,mid,max:longint);
var
  q3,q4,pd,qq2,qq1,q1,q2:longint;
  p1,p2,pp1,pp2,pp:point;
  e:edge;
begin
  fillchar(used,sizeof(used),0);
  get_tang(min,mid,max,q1,q2,q3,q4);
  qq1:=0;qq2:=0;
  add_edge(q1,q2);
  add_edge(q2,q1);
  add_edge(q3,q4);
  add_edge(q4,q3);
  while true do begin
    get_bis(p[q1],p[q2],p1,p2);
    pd:=0;pp.y:=1e100;
    e:=v[q1];
    while e<>nil do begin
      if (e^.x>=min)and(e^.x<=mid) then pp1:=get_three(p[q1],p[q2],p[e^.x])
      else pp1.y:=1e101;
      if ((used[q2]=0)or(get_sit(p[q2],p[used[q2]],p[e^.x])<0))and(get_sit(p[q2],p[q1],p[e^.x])<0)and((pp1.y<pp.y)or((pp1.y=pp.y)and(get_dis(pp1,p1)<get_dis(pp,p1)))) then begin
        pd:=1;
        qq1:=e^.x;
        pp:=pp1;
      end;
      e:=e^.next;
    end;
    e:=v[q2];
    while e<>nil do begin
      if e^.x>mid then pp2:=get_three(p[q1],p[q2],p[e^.x])
      else pp2.y:=1e101;
      if ((used[q1]=0)or(get_sit(p[q1],p[used[q1]],p[e^.x])>0))and(get_sit(p[q1],p[q2],p[e^.x])>0)and((pp2.y<pp.y)or((pp2.y=pp.y)and(get_dis(pp2,p1)<get_dis(pp,p1)))) then begin
        pd:=2;
        qq2:=e^.x;
        pp:=pp2;
      end;
      e:=e^.next;
    end;
    if pd=1 then begin
      add_edge(qq1,q2);
      add_edge(q2,qq1);
      del_all(q1,qq1,q2,-1,min,mid);
      used[q2]:=qq1;
      q1:=qq1;
    end
    else if pd=2 then begin
      add_edge(qq2,q1);
      add_edge(q1,qq2);
      del_all(q2,qq2,q1,1,mid+1,max);
      used[q1]:=qq2;
      q2:=qq2;
    end
    else break;
  end;
end;

procedure build_vor(min,max:longint);
var
  mid:longint;
begin
  if max-min=0 then exit
  else if max-min=1 then begin
    add_edge(min,max);
    add_edge(max,min);
  end
  else if max-min=2 then
    if not oneline(p[min],p[max],p[min],p[min+1]) then begin
      add_edge(min,min+1);
      add_edge(min,max);
      add_edge(min+1,min);
      add_edge(max,min);
      add_edge(min+1,max);
      add_edge(max,min+1);
    end
    else begin
      add_edge(min,min+1);
      add_edge(min+1,min);
      add_edge(min+1,max);
      add_edge(max,min+1);
    end
  else begin
    mid:=(max+min) div 2;
    build_vor(min,mid);
    build_vor(mid+1,max);
    merge(min,mid,max);
  end;
end;

procedure print;
var
  i:longint;
  e:edge;
begin
  for i:=1 to n do begin
    e:=v[i];
    while e<>nil do begin
      if e^.x>i then begin
        writeln(p[i].k-1,' ',p[e^.x].k-1);
        inc(tot);
      end;
      e:=e^.next;
    end;
  end;
  writeln(tot);
end;

begin
  assign(input,'voronoi.in');reset(input);
  assign(output,'voronoi.out');rewrite(output);
  init;
  set_memory;
  build_vor(1,n);
  print;
  close(input);close(output);
end.
