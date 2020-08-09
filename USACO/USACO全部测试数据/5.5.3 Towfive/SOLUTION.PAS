//具体解法参见Maigo大牛的题解TJU1143
{
ID:asiapea1
PROB:twofive
LANG:PASCAL
}
const all=7776;
 
var x,y:array['A'..'Y']of longint;
    l:array[0..5]of longint;
    d:array[0..all-1]of longint;
    s:array[1..25]of char;
    c:char;
 
function dfs(c:char):longint;
var state,i:longint;
begin
 state:=0;
 for i:=1 to 5 do
   state:=state*6+l[i];
 if d[state]<0 then begin
                     d[state]:=0;
                     if x[c]=0
                        then begin
                              for i:=1 to 5 do
                               if l[i]<l[i-1]
                                 then begin
                                        inc(l[i]);
                                        inc(d[state],dfs(succ(c)));
                                        dec(l[i]);
                                      end
                             end
                        else if (l[x[c]]<l[x[c]-1]) and (l[x[c]]+1=y[c])
                                then begin
                                       inc(l[x[c]]);
                                       inc(d[state],dfs(succ(c)));
                                       dec(l[x[c]]);
                                     end;
                    end;
 exit(d[state]);
end;
 
function count:longint;
begin
 fillchar(l,sizeof(l),0);
 fillchar(d,sizeof(d),255);
 l[0]:=5;
 d[all-1]:=1;
 count:=dfs('A');
end;
 
procedure numtoword;
var n,t,i,j:longint;
begin
  readln(n);
  for i:=1 to 5 do
   for j:=1 to 5 do
    for c:='A' to 'Y' do
     if x[c]=0 then begin
                     x[c]:=i;y[c]:=j;
                     t:=count;
                     if n>t then dec(n,t)
                            else break;
                     x[c]:=0;
                    end;
  for c:='A' to 'Y' do
    s[(x[c]-1)*5+y[c]]:=c;
  for i:=1 to 25 do
    write(s[i]);
  writeln;
end;
 
procedure wordtonum;
var n,i,j:longint;
    k:char;
begin
  n:=1;
  for i:=1 to 5 do
   for j:=1 to 5 do
    begin
     read(c);
     for k:='A' to pred(c) do
      if x[k]=0 then begin
                       x[k]:=i;y[k]:=j;
                       inc(n,count);
                       x[k]:=0;
                     end;
     x[c]:=i;y[c]:=j;
    end;
  readln;
  writeln(n);
end;
 
begin
  assign(input,'twofive.in');reset(input);
  assign(output,'twofive.out');rewrite(output);
  fillchar(x,sizeof(x),0);
  fillchar(y,sizeof(y),0);
  readln(c);
  if c='N' then numtoword
           else wordtonum;
  close(output);
end.