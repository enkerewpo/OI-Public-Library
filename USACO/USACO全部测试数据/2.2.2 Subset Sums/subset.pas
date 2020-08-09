{
ID:asiapea1
PROB:subset
LANG:PASCAL
}
 program subset;
 const MaxN=39;
       maxint=Maxn*(Maxn+1) div 2;
 var g:array[0..39,-maxn..maxint]of int64;
     t,n:longint;
   procedure Out;
   begin
     writeln(0);close(output);halt;
   end;
   procedure Init;
   begin
     assign(input,'subset.in');reset(input);
     assign(output,'subset.out');rewrite(output);
     read(n);
     t:=n*(n+1) div 2;
     if odd(t) then Out else t:=t div 2;
     fillchar(g,sizeof(g),255);
   end;
   function Main(n,t:integer):int64;
   var i:longint;
       totel:int64;
   begin
     if (t>n*(n+1) div 2) or (t<0) then g[n,t]:=0;
     if t=0 then g[n,t]:=1;
     if g[n,t]<>-1 then begin Main:=g[n,t];exit; end;
     totel:=0;
     for i:=n downto 1 do
       totel:=totel+Main(i-1,t-i);
     g[n,t]:=totel;Main:=totel;
   end;
 begin
   Init;
   Main(n,t);
   writeln(g[n,t] div 2);close(output);
 end.