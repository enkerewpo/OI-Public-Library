//ÀëÉ¢»¯
{
ID:asiapea1
PROB:window
LANG:PASCAL
}
var ax,ay:array[1..250]of longint;
    d:array[1..250,1..250,0..62]of longint;
    a:array[1..255,1..4]of longint;
    bx,by:array[0..32767]of longint;
    l,x,y,x1,x2,y1,y2,i,k:longint;
    ch:char;
 
function num:longint;
var s:string;
    n,code:longint;
begin
 s:='';
 read(ch);
 while (ch>='0')and(ch<='9') do
  begin
   s:=s+ch;
   read(ch);
  end;
 val(s,n,code);
 num:=n;
end;
 
procedure init;
begin
 assign(input,'window.in');reset(input);
 while not eof do
  begin
   read(ch);
   if ch='w' then
       begin
         read(ch,ch,ch);
         x1:=num;y1:=num;x2:=num;y2:=num;
         bx[x1]:=1;
         bx[x2]:=1;
         by[y1]:=1;
         by[y2]:=1;
        end;
   readln;
  end;
 close(input);
 x1:=0;y1:=0;
 for i:=1 to 32767 do
  begin
   if bx[i]>0 then begin
                    inc(x1);
                    bx[i]:=x1;
                    ax[x1]:=i;
                   end;
   if by[i]>0 then begin
                    inc(y1);
                    by[i]:=y1;
                    ay[y1]:=i;
                   end;
  end;
end;
 
procedure insert;
begin
 read(ch,ch);
 i:=ord(ch);
 read(ch);
 x1:=num;y1:=num;x2:=num;y2:=num;
 readln;
 if x1>x2 then begin
                 k:=x1;x1:=x2;x2:=k;
               end;
 if y1>y2 then begin
                 k:=y1;y1:=y2;y2:=k;
               end;
 a[i,1]:=bx[x1];
 a[i,2]:=by[y1];
 a[i,3]:=bx[x2];
 a[i,4]:=by[y2];
 for x:=bx[x1] to bx[x2]-1 do
  for y:=by[y1] to by[y2]-1 do
   begin
    inc(d[x,y,0]);
    d[x,y,d[x,y,0]]:=i;
   end;
end;
 
procedure up;
begin
 readln(ch,ch);
 i:=ord(ch);
 for x:=a[i,1] to a[i,3]-1 do
  for y:=a[i,2] to a[i,4]-1 do
   begin
    k:=d[x,y,0];
    while d[x,y,k]<>i do  dec(k);
    for l:=k to d[x,y,0]-1 do
     d[x,y,l]:=d[x,y,l+1];
    d[x,y,d[x,y,0]]:=i;
   end;
end;
 
procedure down;
begin
 readln(ch,ch);
 i:=ord(ch);
 for x:=a[i,1] to a[i,3]-1 do
  for y:=a[i,2] to a[i,4]-1 do
   begin
    k:=d[x,y,0];
    while d[x,y,k]<>i do dec(k);
    for l:=k-1 downto 1 do
     d[x,y,l+1]:=d[x,y,l];
    d[x,y,1]:=i;
   end;
end;
 
procedure delete;
begin
 readln(ch,ch);
 i:=ord(ch);
 for x:=a[i,1] to a[i,3]-1 do
  for y:=a[i,2] to a[i,4]-1 do
   begin
    k:=d[x,y,0];
    while d[x,y,k]<>i do  dec(k);
    for l:=k to d[x,y,0]-1 do
     d[x,y,l]:=d[x,y,l+1];
    dec(d[x,y,0]);
   end;
end;
 
procedure out;
var s:longint;
begin
 read(ch,ch);
 i:=ord(ch);
 s:=0;
 for x:=a[i,1] to a[i,3]-1 do
  for y:=a[i,2] to a[i,4]-1 do
   if d[x,y,d[x,y,0]]=i
        then s:=s+(ax[x+1]-ax[x])*(ay[y+1]-ay[y]);
 writeln(s/(ax[a[i,3]]-ax[a[i,1]])/(ay[a[i,4]]-ay[a[i,2]])*100:0:3);
end;
 
begin
 init;
 assign(input,'window.in');reset(input);
 assign(output,'window.out');rewrite(output);
 while not eof do
  begin
   read(ch);
   case ch of
    'w':insert;
    't':up;
    'b':down;
    'd':delete;
    's':out;
   end;
  end;
 close(output);
end.