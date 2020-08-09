{
id:asiapea1
PROG:hidden
LANG:PASCAL
}
program hidden;
  var
    str:array[1..220000]of char;
    len,s,t:longint;
  procedure  int;
    var
      i:longint;
      ch:char;
    begin
       assign(input,'hidden.in');reset(input);
       readln(len);i:=0;
       while not eof do
         begin
           read(ch);
           if (ord(ch)>=ord('a'))and(ord(ch)<=ord('z')) then
             begin  inc(i);str[i]:=ch;end;
         end;
       for i:=1 to len do
         str[i+len]:=str[i];
       close(input);
    end;
  procedure  out1;
    var
      i:longint;
    begin
      assign(output,'hidden.out');rewrite(output);
      writeln(s-1);
     { for i:=1 to len do
        write(str[i]); }
      close(output);
      halt;
    end;
  procedure  main;
    var
      i:longint;
    begin
      s:=1;t:=2;
      while t<=len do
        begin
          i:=0;
          while (str[s+i]=str[t+i])and(i<=len) do
            inc(i);
          if i>len then out1;
          if str[s+i]<str[t+i] then
           begin
            t:=t+i+1;
           end
           else begin s:=t;t:=t+1;end;
        end;
    end;
begin
  int;
  main;
  out1;
end.
