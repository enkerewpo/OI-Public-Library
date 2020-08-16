var
 m,n,t:integer;
begin
 read(m);
 read(n);
 if m=1 then
  begin
   writeln((n+1) div 2);
   halt;
  end;
 if n=1 then
  begin
   writeln((m+1) div 2);
   halt;
  end;
 m:=m mod 3;
 n:=n mod 3;
 if m<=1 then m:=m+3;
 if n<=1 then n:=n+3;
 if m>n then
  begin
   t:=m;
   m:=n;
   n:=t;
  end;
 case m of
  2:case n of
     2:writeln(1);
     3:writeln(2);
     4:writeln(1);
    end;
  3:case n of
     3:writeln(2);
     4:writeln(2);
    end;
  4:writeln(1);
 end;
end.