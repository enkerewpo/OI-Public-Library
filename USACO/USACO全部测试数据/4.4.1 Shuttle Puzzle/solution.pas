{
ID:asiapea1
PROB:shuttle
LANG:PASCAL
}
var ans:array[1..500]of longint;
    i,j,x,n,y,l1,l2,k1,k2:longint;
begin
 assign(input,'shuttle.in');reset(input);
 read(n);
 ans[1]:=n+1;
 y:=-1;
 l1:=0; k1:=1;
 l2:=0; k2:=1;
 for i:=2 to (n+1)*(n+1) div 2 do
  begin
   if l1=k1 then begin
                  y:=(-1)*y;
                  l1:=0;
                  inc(k1);
                 end;
   inc(l2);
   if l2=k2 then begin
                  ans[i]:=ans[i-1]+1*y;
                  l2:=0;
                  inc(k2);
                 end
            else begin
                  ans[i]:=ans[i-1]+2*y;
                 end;
   inc(l1);
  end;
 assign(output,'shuttle.out');rewrite(output);
 l1:=0;
 for i:=2 to (n+1)*(n+1) div 2 do
  begin
   inc(l1);
   if l1=20 then begin
                  writeln(ans[i]);
                  l1:=0;
                 end
            else write(ans[i],' ');
  end;
 if (n+1)*(n+1) and 1=1 then begin
                              inc(l1);
                              if l1=20 then begin
                                             writeln(n+1);
                                             l1:=0;
                                            end
                                       else write(n+1,' ');
                             end;
 for i:=(n+1)*(n+1) div 2 downto 2 do
  begin
   inc(l1);
   if l1=20 then begin
                  writeln(2*n+2-ans[i]);
                  l1:=0;
                 end
            else write(2*n+2-ans[i],' ');
  end;
 writeln(2*n+2-ans[1]);
 close(output);
end.