{
ID:asiapea1
PROG:castle
LANG:PASCAL
}
var m,n,i,j,h,d,i1,j1,cc:longint;
     mop:array[1..50,1..50] of longint;
     q:array[1..3000,1..2] of longint;
     map:array[1..50,1..50] of longint;
     s:array[1..2500] of longint;
     seed,max:longint;
   procedure inbox(x:longint);
   begin
     case x of
      1:if map[q[h,1],q[h,2]-1]=0 then
        begin
           inc(d);
          q[d,1]:=q[h,1]; q[d,2]:=q[h,2]-1;   map[q[d,1],q[d,2]]:=seed; inc(s[seed]);
        end;
      2:if map[q[h,1]-1,q[h,2]]=0 then
        begin
            inc(d);
          q[d,1]:=q[h,1]-1; q[d,2]:=q[h,2];   map[q[d,1],q[d,2]]:=seed; inc(s[seed]);
        end;
      4:if map[q[h,1],q[h,2]+1]=0 then
        begin
            inc(d);
          q[d,1]:=q[h,1]; q[d,2]:=q[h,2]+1;   map[q[d,1],q[d,2]]:=seed; inc(s[seed]);
        end;
      8:if map[q[h,1]+1,q[h,2]]=0 then
       begin
            inc(d);
          q[d,1]:=q[h,1]+1; q[d,2]:=q[h,2];   map[q[d,1],q[d,2]]:=seed; inc(s[seed]);
        end;
      end;

   end;
   procedure search(x:longint);
   begin
     case x of
      1:if j-1>=1 then
        if map[i,j]<>map[i,j-1] then
        if s[map[i,j]]+s[map[i,j-1]]>max then
          begin
          max:=s[map[i,j]]+s[map[i,j-1]];
          i1:=i; j1:=j; cc:=x;
          end
        else
        if   s[map[i,j]]+s[map[i,j-1]]=max then
          if j<j1 then begin i1:=i; j1:=j; cc:=x; end
            else if j=j1 then
            if i>i1 then begin i1:=i; j1:=j; cc:=x;   end
            else if (i=i1)and(j=j1) then
            if x=1 then   begin i1:=i; j1:=j; cc:=x;   end
            else if x=8 then   begin i1:=i; j1:=j; cc:=x;   end;
      2:if i-1>=1 then
        if map[i,j]<>map[i-1,j]   then
        if s[map[i,j]]+s[map[i-1,j]]>max then
        begin
          max:=s[map[i,j]]+s[map[i-1,j]];
          i1:=i; j1:=j; cc:=x;
        end
               else
        if   s[map[i,j]]+s[map[i-1,j]]=max then
          if j<j1 then begin i1:=i; j1:=j; cc:=x; end
            else if j=j1 then
            if i>i1 then begin i1:=i; j1:=j; cc:=x;   end
            else if (i=i1)and(j=j1) then
            if x=1 then   begin i1:=i; j1:=j; cc:=x;   end
            else if x=8 then   begin i1:=i; j1:=j; cc:=x;   end;
      4:if j+1<=m then
        if map[i,j]<>map[i,j+1]   then
        if s[map[i,j]]+s[map[i,j+1]]>max then
        begin
          max:=s[map[i,j]]+s[map[i,j+1]];
          i1:=i; j1:=j; cc:=x;
        end
               else
        if   s[map[i,j]]+s[map[i,j+1]]=max then
          if j<j1 then begin i1:=i; j1:=j; cc:=x; end
            else if j=j1 then
            if i>i1 then begin i1:=i; j1:=j; cc:=x;   end
            else if (i=i1)and(j=j1) then
            if x=1 then   begin i1:=i; j1:=j; cc:=x;   end
            else if x=8 then   begin i1:=i; j1:=j; cc:=x;   end;
      8:if i+1<=n then
        if map[i,j]<>map[i+1,j]   then
        if s[map[i,j]]+s[map[i+1,j]]>max then
        begin
          max:=s[map[i,j]]+s[map[i+1,j]];
          i1:=i; j1:=j; cc:=x;
        end
               else
        if   s[map[i,j]]+s[map[i+1,j]]=max then
          if j<j1 then begin i1:=i; j1:=j; cc:=x; end
            else if j=j1 then
            if i>i1 then begin i1:=i; j1:=j; cc:=x;   end
            else if (i=i1)and(j=j1) then
            if x=1 then   begin i1:=i; j1:=j; cc:=x;   end
            else if x=8 then   begin i1:=i; j1:=j; cc:=x;   end;
      end;
   end;
begin
   assign(input,'castle.in'); reset(input);     assign(output,'castle.out'); rewrite(output);
   readln(m,n);
   for i:=1 to n do
     begin
       for j:=1 to m do read(mop[i,j]);
       readln;
     end;
   fillchar(map,sizeof(map),0); fillchar(s,sizeof(s),0);
   seed:=0; max:=0;
   for i:=1 to n do
   for j:=1 to m do
   if (map[i,j]=0) then
   begin
   h:=0; d:=1; inc(seed); q[1,1]:=i; q[1,2]:=j; map[i,j]:=seed; inc(s[seed]);
   repeat
     inc(h);
     case mop[q[h,1],q[h,2]] of
       0:begin   inbox(2); inbox(4); inbox(8); inbox(1);    end;
       1:begin inbox(2); inbox(4); inbox(8);   end;
       2:begin inbox(1); inbox(4); inbox(8);    end;
       4:begin inbox(1); inbox(2); inbox(8); end;
       8:begin inbox(1); inbox(2); inbox(4);   end;
       3:begin inbox(4); inbox(8); end;
       5:begin inbox(2); inbox(8); end;
       9:begin inbox(2); inbox(4); end;
       6:begin inbox(1); inbox(8); end;
       10:begin inbox(1); inbox(4); end;
       12:begin inbox(1); inbox(2); end;
       11:inbox(4);
       7:inbox(8);
       14:inbox(1);
       13:inbox(2);
     end;
   until h=d;
   if s[seed]>max then max:=s[seed];
   end;
   writeln(seed); writeln(max); max:=0;
   for i:=1 to n do
     for j:=1 to m do
       begin
         case mop[i,j] of
       1:search(1);
       2:search(2);
       4:search(4);
       8:search(8);
       3:begin search(2);   search(1);end;
       5:begin search(4);   search(1);end;
       9:begin search(8);   search(1);end;
       6:begin search(2); search(4); end;
       10:begin search(2); search(8); end;
       12:begin search(4); search(8); end;
       11:begin   search(2);search(8); search(1); end;
       7:begin search(2); search(4);   search(1); end;
       14:begin search(2); search(4);   search(8); end;
       15:begin search(2); search(4);   search(8); search(1); end;
       13:begin search(4);   search(8);   search(1);   end;
     end;
       end;
   writeln(max);
   write(i1,' ',j1,' ');
   case cc of
    1:writeln('W');
    2:writeln('N');
    4:writeln('E');
    8:writeln('S');
end;
close(input); close(output);
end.
