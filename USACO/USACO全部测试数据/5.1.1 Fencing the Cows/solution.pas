{
id:asiapea1
PROG:fc
LANG:PASCAL
}
program fc;
  type
    ty=record
      x,y:real;
    end;
  var
    aa:array[1..20000]of ty;
    dui:array[1..20000]of integer;
    n,open:longint;
    ans:real;
  procedure swap(var a,b:ty);
    var
      temp:ty;
    begin
      temp:=a;a:=b;b:=temp;
    end;
  procedure  int;
    var i:longint;
    begin
      assign(input,'fc.in');reset(input);
      readln(n);
      for i:=1 to n do
        begin
          readlN(aa[i].x,aa[i].y);
          if (aa[i].y<aa[1].y)or((aa[i].y=aa[1].y)and(aa[i].x<aa[1].x)) then
            swap(aa[i],aa[1]);
        end;
      close(input);
    end;
  function check(p1,p2,p0:ty):real;
    begin
      check:=(p1.x-p0.x)*(p2.y-p0.y)-(p2.x-p0.x)*(p1.y-p0.y);
    end;
  function dist(p1,p2:ty):real;
    begin
      dist:=sqrt((p1.x-p2.x)*(p1.x-p2.x)+(p1.y-p2.y)*(p1.y-p2.y));
    end;
  procedure  kuai(s,t:integer;var k:integer);
    var
      i,j:integer;
      temp:ty;
    begin
      i:=s;j:=t;temp:=aa[s];
      while i<j do
        begin
          while (i<j)and((check(aa[j],temp,aa[1])<0)or((check(aa[j],temp,aa[1])=0)and(dist(aa[j],aa[1])>dist(temp,aa[1])))) do
            dec(j);
          aa[i]:=aa[j];
          while (i<j)and((check(aa[i],temp,aa[1])>0)or((check(aa[i],temp,aa[1])=0)and(dist(aa[i],aa[1])<dist(temp,aa[1])))) do
            inc(i);
          aa[j]:=aa[i];
        end;
      aa[i]:=temp;
      k:=i;
    end;
  procedure  pai(s,t:integer);
    var k:integer;
    begin
      if s<t then
        begin
          kuai(s,t,k);
          pai(s,k-1);
          pai(k+1,t);
        end;
    end;
  procedure  main;
    var
      i:integer;
    begin
      dui[1]:=1;dui[2]:=2;open:=2;
      for i:=3 to n do
        begin
          while (open>1)and(check(aa[i],aa[dui[open]],aa[dui[open-1]])>=0) do dec(open);
          inc(open);dui[open]:=i;
        end;
      ans:=0;
      for i:=1 to open-1 do
        ans:=ans+dist(aa[dui[i]],aa[dui[i+1]]);
      ans:=ans+dist(aa[dui[open]],aa[dui[1]]);
    end;
  procedure  out1;
    begin
      assign(output,'fc.out');rewrite(output);
      writeln(ans:0:2);
      close(output);
    end;
begin
  int;
  pai(2,n);
  main;
  out1;
end.
