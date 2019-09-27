program nta;
var a:array[1..15] of 0..1;
    b,c:array[1..15,1..15,1..15] of 0..1;
    i,j,k,l,l1,l2,l3,n,num,ok:integer;
    x:boolean;
    str:string;
    f1,f2:text;
procedure init;
begin
     assign(f1,'nta6.dat');
     assign(f2,'nta.out');
     reset(f1);
     rewrite(f2);
     readln(f1,n);
end;
procedure clean;
begin
     for j:=1 to 15 do a[j]:=0;
     for j:=1 to 15 do
         for k:=1 to 15 do
             for l:=1 to 15 do
                 begin
                      b[j,k,l]:=0;
                      c[j,k,l]:=0;
                 end;
     x:=false;
end;
procedure read_file;
begin
     read(f1,num);
     readln(f1,ok);
     for j:=num-ok+1 to num do a[j]:=1;
     for j:=1 to num do
         for k:=1 to num do
             begin
                  readln(f1,str);
                  for l:=1 to length(str) do
                      b[j,k,ord(str[l])-96]:=1;
             end;
     readln(f1,str);
     for j:=1 to length(str)-1 do
         c[length(str)-1,j,ord(str[j])-96]:=1;
end;
procedure try;
begin
     for j:=length(str)-1 downto 1 do
         for k:=1 to j do
             for l1:=1 to num do
                 if c[j+1,k,l1]=1 then
                    for l2:=1 to num do
                        if c[j+1,k+1,l2]=1 then
                           for l3:=1 to num do
                               if b[l1,l2,l3]=1 then
                                  c[j,k,l3]:=1;
     for j:=num-ok+1 to num do
         if c[1,1,j]=1 then x:=true;
end;
procedure write_file;
begin
     if x then writeln(f2,'accept')
          else writeln(f2,'reject');
end;
procedure close_file;
begin
     close(f1);
     close(f2);
end;
begin
     init;{打开文件}
     for i:=1 to n do
         begin
              clean;{清0}
              read_file;{读入数据}
              try;{判断过程}
              write_file;{写入文件}
         end;
     close_file;{关闭文件}
end.
