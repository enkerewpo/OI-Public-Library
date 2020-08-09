//
{
ID:asiapea1
PROB:wissqu
LANG:PASCAL
}
//由于用的是PAS，只能加卡时了
uses dos;
var a,d:array[0..5,0..5]of longint;
    b:array[1..4,1..4]of boolean;
    use:array[1..5]of longint;
    ans:array[1..16,1..3]of longint;
    ii,i,j:longint;
    ch:char;
 
procedure init;
begin
 assign(input,'wissqu.in');reset(input);
 for i:=1 to 4 do
  begin
   for j:=1 to 4 do
    begin
      read(ch);
      a[i,j]:=ord(ch)-64;
    end;
   readln;
  end;
 d:=a;
end;
 
procedure out;
begin
 for i:=1 to 16 do
   writeln(chr(ans[i,1]+64),' ',ans[i,2],' ',ans[i,3]);
end;
 
function ok(kind,x,y:longint):boolean;
begin
 if (a[x-1,y-1]=kind)or(a[x-1,y]=kind)or(a[x-1,y+1]=kind)or
    (a[x,y+1]=kind)or(a[x+1,y+1]=kind)or(a[x+1,y]=kind)or
    (a[x+1,y-1]=kind)or(a[x,y-1]=kind)
     then exit(false);
 exit(true);
end;
 
procedure dfs(k:longint);forward;
 
procedure get(kind,k:longint);
var i,j:longint;
begin
 for i:=1 to 4 do
  for j:=1 to 4 do
     if b[i,j] and (a[i,j]<>kind) and ok(kind,i,j)
        then begin
              a[i,j]:=kind;
              b[i,j]:=false;
              ans[k,2]:=i;ans[k,3]:=j;
              dfs(k+1);
              a[i,j]:=d[i,j];
              b[i,j]:=true;
             end;
end;
 
procedure dfs(k:longint);
var j:longint;
begin
 if k>16 then begin
               inc(ii);
               if ii=1 then out;
               if ii=14925 then begin
                                 writeln(ii);
                                 close(output);
                                 halt;
                                end;
               exit;
              end;
 for j:=1 to 5 do
  if use[j]>0 then begin
                    dec(use[j]);
                    ans[k,1]:=j;
                    get(j,k);
                    inc(use[j]);
                   end;
end;
 
begin
 init;
 fillchar(b,sizeof(b),true);
 use[1]:=3;use[2]:=3;use[3]:=3;use[4]:=3;use[5]:=3;
 ans[1,1]:=4;
 ii:=0;
 assign(output,'wissqu.out');rewrite(output);
 get(4,1);
end.