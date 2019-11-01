var
 n,k,ck,t,x3,y3,i,j,cnum:longint;
 num:array[0..520,0..520] of longint;
procedure solve(ck,x1,y1,x2,y2,x3,y3:longint);
 var
  xm,ym,p:longint;
 begin
  xm:=(x1+x2) div 2;
  ym:=(y1+y2) div 2;
  if (x3<=xm) and (y3>ym) then p:=1;
  if (x3<=xm) and (y3<=ym) then p:=2;
  if (x3>xm) and (y3<=ym) then p:=3;
  if (x3>xm) and (y3>ym) then p:=4;
  if ck=1 then
   begin
    cnum:=cnum+1;
    case p of
     1:begin
        num[xm,ym]:=cnum;
        num[xm+1,ym]:=cnum;
        num[xm+1,ym+1]:=cnum;
       end;
     2:begin
        num[xm,ym+1]:=cnum;
        num[xm+1,ym]:=cnum;
        num[xm+1,ym+1]:=cnum;
       end;
     3:begin
        num[xm,ym]:=cnum;
        num[xm,ym+1]:=cnum;
        num[xm+1,ym+1]:=cnum;
       end;
     4:begin
        num[xm,ym]:=cnum;
        num[xm,ym+1]:=cnum;
        num[xm+1,ym]:=cnum;
       end;
    end;
   end
  else
   begin
    cnum:=cnum+1;
    case p of
     1:begin
        num[xm,ym]:=cnum;
        num[xm+1,ym]:=cnum;
        num[xm+1,ym+1]:=cnum;
        solve(ck-1,x1,ym+1,xm,y2,x3,y3);
        solve(ck-1,x1,y1,xm,ym,xm,ym);
        solve(ck-1,xm+1,y1,x2,ym,xm+1,ym);
        solve(ck-1,xm+1,ym+1,x2,y2,xm+1,ym+1);
       end;
     2:begin
        num[xm,ym+1]:=cnum;
        num[xm+1,ym]:=cnum;
        num[xm+1,ym+1]:=cnum;
        solve(ck-1,x1,ym+1,xm,y2,xm,ym+1);
        solve(ck-1,x1,y1,xm,ym,x3,y3);
        solve(ck-1,xm+1,y1,x2,ym,xm+1,ym);
        solve(ck-1,xm+1,ym+1,x2,y2,xm+1,ym+1);
       end;
     3:begin
        num[xm,ym]:=cnum;
        num[xm,ym+1]:=cnum;
        num[xm+1,ym+1]:=cnum;
        solve(ck-1,x1,ym+1,xm,y2,xm,ym+1);
        solve(ck-1,x1,y1,xm,ym,xm,ym);
        solve(ck-1,xm+1,y1,x2,ym,x3,y3);
        solve(ck-1,xm+1,ym+1,x2,y2,xm+1,ym+1);
       end;
     4:begin
        num[xm,ym]:=cnum;
        num[xm,ym+1]:=cnum;
        num[xm+1,ym]:=cnum;
        solve(ck-1,x1,ym+1,xm,y2,xm,ym+1);
        solve(ck-1,x1,y1,xm,ym,xm,ym);
        solve(ck-1,xm+1,y1,x2,ym,xm+1,ym);
        solve(ck-1,xm+1,ym+1,x2,y2,x3,y3);
       end;
    end;
   end;
 end;
begin
 n:=0; k:=0; ck:=0; t:=0; x3:=0; y3:=0; i:=0; j:=0; cnum:=0;
 fillchar(num,sizeof(num),0);
 readln(k);
 ck:=k;
 t:=1;
 for i:=1 to k do
  t:=t*2;
 n:=t;
 readln(x3,y3);
 num[x3,y3]:=0;
 cnum:=0;
 solve(ck,1,1,n,n,x3,y3);
 for i:=1 to n do
  begin
   for j:=1 to n-1 do
    write(num[i,j],' ');
   writeln(num[i,n]);
  end;
end.
