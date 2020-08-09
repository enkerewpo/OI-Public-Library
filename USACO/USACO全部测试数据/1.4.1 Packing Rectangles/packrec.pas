{
ID:asiapea1
PROG:packrec
LANG:PASCAL
}
var
     x,y:array[1..4]of integer;
     rx,ry,s:array[0..5000]of integer;
     i1,i2,i3,i4,n,min,m,t:longint;
     procedure swap(var x,y:integer);
     var t:longint;
     begin t:=x;x:=y;y:=t; end;
     function mx(a,b:longint):longint;
     begin
       if a>b then mx:=a else mx:=b;
     end;
     procedure js(k:integer);
     var
       xx,yy:integer;
     begin
       case k of
         1:begin
             xx:=x[i1]+x[i2]+x[i3]+x[i4];
             yy:=mx(y[i1],mx(y[i2],mx(y[i3],y[i4])));
           end;
         2:begin
             xx:=mx(x[i1],x[i2]+x[i3]+x[i4]);
             yy:=y[i1]+mx(y[i2],mx(y[i3],y[i4]));
           end;
         3:begin
             xx:=x[i1]+mx(x[i2],x[i3]+x[i4]);
             yy:=mx(y[i1],y[i2]+mx(y[i3],y[i4]));
           end;
         4:begin
             xx:=x[i1]+mx(x[i2],x[i3])+x[i4];
             yy:=mx(y[i2]+y[i3],mx(y[i1],y[i4]));
           end;
         5:begin
             xx:=mx(x[i1],mx(x[i4],x[i2]+x[i3]));
             yy:=mx(y[i1]+y[i2],y[i3]+y[i4]);               //以下四行是最让人烦的，自己可以画个图试一试
             if (x[i1]>x[i2])and(y[i3]>y[i2]) then exit;
             if (x[i1]>x[i2])and(x[i4]>(x[i2]+x[i3]-x[i1]))and(y[i4]>(y[i2]-y[i3])) then exit;
             if (x[i1]>x[i2])and(x[i4]>x[i3]) then exit;
             if (x[i1]<=x[i2])and(y[i3]<y[i2])and(x[i4]>x[i3])then exit;
             if (x[i1]<=x[i2])and(y[i3]<(y[i1]+y[i2]))and(x[i4]>(x[i2]+x[i3]-x[i1])) then exit;
           end;
       end;
       inc(n);
       rx[n]:=xx;
       ry[n]:=yy;
       s[n]:=xx*yy;
     end;
     procedure js2(i:longint);
     begin
       case i of
         1:begin swap(x[i1],y[i1]);js2(i+1);swap(x[i1],y[i1]);js2(i+1);end;
         2:begin swap(x[i2],y[i2]);js2(i+1);swap(x[i2],y[i2]);js2(i+1);end;
         3:begin swap(x[i3],y[i3]);js2(i+1);swap(x[i3],y[i3]);js2(i+1);end;
         4:begin swap(x[i4],y[i4]);js2(i+1);swap(x[i4],y[i4]);js2(i+1);end;
         5:begin js(1);js(2);js(3);js(4);js(5);end;
       end;
     end;
begin
     assign(input,'packrec.in');reset(input);
     assign(output,'packrec.out');rewrite(output);
     for i1:=1 to 4 do
       readln(x[i1],y[i1]);
     n:=0;
     for i1:=1 to 4 do
     for i2:=1 to 4 do
     for i3:=1 to 4 do
     for i4:=1 to 4 do
       if (i1<>i2)and(i1<>i3)and(i1<>i4)and(i2<>i3)and(i2<>i4)and(i3<>i4) then
         js2(1);
     min:=maxlongint;
     m:=0;
     for i1:=1 to n do
       if min>s[i1] then min:=s[i1];
     writeln(min);
     for i1:=1 to n do begin
       if s[i1]=min then
       begin
         inc(m);
         rx[m]:=rx[i1];
         ry[m]:=ry[i1];
         if rx[m]>ry[m] then swap(rx[m],ry[m]);
       end;
     end;
     for i1:=1 to m do for i2:=1 to m do
       if rx[i1]<rx[i2] then begin swap(rx[i1],rx[i2]);swap(ry[i1],ry[i2]);end;
     for i1:=1 to m do begin
       if t<>rx[i1] then writeln(rx[i1],' ',ry[i1]);
       t:=rx[i1];
     end;
     close(input);close(output);
end.
