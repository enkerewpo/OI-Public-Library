program zju2009;
const
  maxn=1004;
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
  tri:array[1..maxn*3]of record
    a,b,c:point;
  end;
  way:array[1..maxn,1..maxn]of boolean;
  used,a:array[1..maxn]of longint;
  check:array[1..maxn]of boolean;
  e_free:array[1..maxn*maxn]of edge;
  p:array[1..maxn]of point;
  v:array[1..maxn]of edge;
  tot,m,n,tasks:longint;
  x,y:double;

procedure fill;
var
  i:longint;
begin
  for i:=1 to maxn do v[i]:=nil;
//  for i:=1 to maxn*maxn do dispose(e_free[i]);
  fillchar(tri,sizeof(tri),0);
  fillchar(way,sizeof(way),false);
  fillchar(check,sizeof(check),false);
  fillchar(used,sizeof(used),0);
  fillchar(a,sizeof(a),0);
  fillchar(p,sizeof(p),0);
  n:=0;m:=0;tot:=0;
end;

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
  x,y:double;
  i:longint;
begin
  readln(x,y,n);
  for i:=1 to n do begin
    readln(p[i].x,p[i].y);
    p[i].k:=i;
    v[i]:=nil;
  end;
  p[n+1].x:=0;p[n+1].y:=0;
  p[n+2].x:=0;p[n+2].y:=y;
  p[n+3].x:=x;p[n+3].y:=0;
  p[n+4].x:=x;p[n+4].y:=y;
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
  xx,i:longint;
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
  if a[tot]<>l then begin
    inc(tot);
    a[tot]:=l;
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

function check_circle(q:point;r:double;k:longint):boolean;
var
  i:longint;
begin
  check_circle:=false;
  for i:=1 to n do
    if (get_dis(q,p[i])-r<zero) then begin
      dec(k);
      if k<0 then exit;
    end;
  check_circle:=true;
end;

procedure main;
var
  b,i,c:longint;
  ee,e:edge;
  qmin,q,ans,p1,p2:point;
  rans,r:double;
begin
  x:=p[n+3].x;
  y:=p[n+4].y;
  if n=1 then begin
    q:=p[1];
    if get_dis(q,p[1])<get_dis(p[1],p[n+1]) then q:=p[n+1];
    if get_dis(q,p[1])<get_dis(p[1],p[n+2]) then q:=p[n+2];
    if get_dis(q,p[1])<get_dis(p[1],p[n+3]) then q:=p[n+3];
    if get_dis(q,p[1])<get_dis(p[1],p[n+4]) then q:=p[n+4];
    writeln('The safest point is (',q.x:0:1,', ',q.y:0:1,').');
    exit;
  end;
  m:=0;
  for i:=1 to n do begin
    e:=v[i];
    repeat
      if e^.x>i then begin
        b:=e^.x;
        ee:=v[b];c:=ee^.x;
        while ee<>nil do begin
          if (get_sit(p[i],p[b],p[c])>0)or((get_sit(p[i],p[b],p[ee^.x])<0)and(get_sit(p[b],p[c],p[ee^.x])<0)and(way[ee^.x,i])) then c:=ee^.x;
          ee:=ee^.next;
        end;
        if way[i,c] then begin
          inc(m);
          tri[m].a:=p[i];
          tri[m].b:=p[b];
          tri[m].c:=p[c];
        end;
      end;
      e:=e^.next;
    until e=nil;
  end;
  rans:=0;
  for i:=1 to m do begin
    q:=get_three(tri[i].a,tri[i].b,tri[i].c);
    r:=get_dis(q,tri[i].a);
    if (r>rans)and(r<1e20)and(q.x>=0)and(q.x<=x)and(q.y>=0)and(q.y<=y) then begin
      rans:=r;
      ans:=q;
    end;
  end;
  get_tang(1,n div 2,n,b,b,b,b);
  for i:=1 to tot-1 do begin
    r:=0;
    get_bis(p[a[i]],p[a[i+1]],p1,p2);
    get_inter(p1,p2,p[n+1],p[n+3],q);
    if (get_dis(q,p[a[i]])>r)and(q.x>=0)and(q.x<=x)and(check_circle(q,get_dis(q,p[a[i]]),2)) then begin
      qmin:=q;
      r:=get_dis(q,p[a[i]]);
    end;
    get_inter(p1,p2,p[n+3],p[n+4],q);
    if (get_dis(q,p[a[i]])>r)and(q.y>=0)and(q.y<=y)and(check_circle(q,get_dis(q,p[a[i]]),2)) then begin
      qmin:=q;
      r:=get_dis(q,p[a[i]]);
    end;
    get_inter(p1,p2,p[n+1],p[n+2],q);
    if (get_dis(q,p[a[i]])>r)and(q.y>=0)and(q.y<=y)and(check_circle(q,get_dis(q,p[a[i]]),2)) then begin
      qmin:=q;
      r:=get_dis(q,p[a[i]]);
    end;
    get_inter(p1,p2,p[n+2],p[n+4],q);
    if (get_dis(q,p[a[i]])>r)and(q.x>=0)and(q.x<=x)and(check_circle(q,get_dis(q,p[a[i]]),2)) then begin
      qmin:=q;
      r:=get_dis(q,p[a[i]]);
    end;
    if (r>rans)and(r<=1e20) then begin
      ans:=qmin;
      rans:=r;
    end;
  end;
{  q.x:=x;q.y:=y;r:=1e100;
  for i:=1 to n do
    if get_dis(p[i],q)<r then
      r:=get_dis(p[i],q);
  if (r<1e20)and(r>rans) then begin
    rans:=r;
    ans:=q;
  end;
  q.x:=0;q.y:=y;r:=1e100;
  for i:=1 to n do
    if get_dis(p[i],q)<r then
      r:=get_dis(p[i],q);
  if (r<1e20)and(r>rans) then begin
    rans:=r;
    ans:=q;
  end;
  q.x:=x;q.y:=0;r:=1e100;
  for i:=1 to n do
    if get_dis(p[i],q)<r then
      r:=get_dis(p[i],q);
  if (r<1e20)and(r>rans) then begin
    rans:=r;
    ans:=q;
  end;
  q.x:=0;q.y:=0;r:=1e100;
  for i:=1 to n do
    if get_dis(p[i],q)<r then
      r:=get_dis(p[i],q);
  if (r<1e20)and(r>rans) then begin
    rans:=r;
    ans:=q;
  end;}
  writeln('The safest point is (',ans.x:0:1,', ',ans.y:0:1,').');
end;

begin
  assign(input,'away.in');reset(input);
  assign(output,'2009.out');rewrite(output);
  while not eof(input) do begin
    readln(tasks);
    while tasks>0 do begin
      dec(tasks);
      fill;
      init;
      if n>1 then begin
        set_memory;
        build_vor(1,n);
      end;
      main;
    end;
  end;
  close(input);close(output);
end.
