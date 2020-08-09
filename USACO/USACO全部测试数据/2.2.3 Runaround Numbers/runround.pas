{
ID:asiapea1
PROB:runround
LANG:PASCAL
}
 const ph=['0'..'9'];
 var
   f1,f2:text;
   ch:char;
   t1,i,j,w,k:integer;
   f:boolean;
   a,b:array[1..20]of 0..9;
 begin
   assign(f1,'runround.in');
   reset(f1);
   t1:=0;
   read(f1,ch);
   while ch in ph do
     begin
       inc(t1);
       a[t1]:=ord(ch)-ord('0');
       read(f1,ch);
     end;
   close(f1);
   for i:=20 downto 21-t1 do
     a[i]:=a[t1-(20-i)];
   for i:=1 to 20-t1 do a[i]:=0;
   assign(f2,'runround.out');
   rewrite(f2);
   f:=false;
   repeat
     j:=20;
     while a[j]=9 do j:=j-1;
     inc(a[j]);
     for i:=j+1 to 20 do a[i]:=1;
     fillchar(b,sizeof(b),0);
     j:=1;
     while a[j]=0 do j:=j+1;
     k:=j;
     w:=1;
     repeat
       b[k]:=1;
       inc(w);
       t1:=k;
       for i:=1 to a[t1] do
         if k=20 then k:=j
                 else inc(k);
       inc(b[k]);
       if (w=21-j) and (b[k]<>2) then f:=true;
     until f or (b[k]=2);
     t1:=k;
     for i:=1 to a[t1] do
       if k=20 then k:=j
               else inc(k);
     if k<>j then f:=false;
     for i:=j to 19 do
       for w:=i+1 to 20 do
         if a[i]=a[w] then f:=false;
   until f;
   for i:=j to 20 do write(f2,a[i]);
   writeln(f2);
   close(f2);
 end.