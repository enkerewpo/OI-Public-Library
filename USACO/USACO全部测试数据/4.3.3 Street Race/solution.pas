{
ID:asiapea1
PROB:race3
LANG:PASCAL
}
var a:array[0..50,0..50]of longint;
    d,ans1,ans2:array[0..50]of longint;
    b:array[0..50]of longint;
    ii,i,j,n,x:longint;
    pd1,pd2:boolean;
 
procedure init;
begin
 assign(input,'race3.in');reset(input);
 n:=-1;
 while x<>-1 do
  begin
   inc(n);
   read(x);
   while x>=0 do
    begin
     inc(a[n,0]);
     a[n,a[n,0]]:=x;
     read(x);
    end;
  end;
 dec(n);
end;
 
procedure dfs(i:longint);
var j:longint;
begin
 b[i]:=ii;
 if i=n then begin
              pd1:=true;
              exit;
             end;
 for j:=1 to a[i,0] do
  if b[a[i,j]]=0 then dfs(a[i,j])
                 else if b[a[i,j]]=1 then pd2:=false;
end;
 
begin
 init;
 for i:=1 to n-1 do
  begin
    fillchar(b,sizeof(b),0);
    b[i]:=1; pd1:=false;
    ii:=1;
    dfs(0);
    if not pd1 then begin
                      inc(ans1[0]);
                      ans1[ans1[0]]:=i;
                    end;
    pd2:=true;
    ii:=2;
    dfs(i);
    if pd2 then begin
                 inc(ans2[0]);
                 ans2[ans2[0]]:=i;
                end;
   end;
  assign(output,'race3.out');rewrite(output);
  if ans1[0]<>0 then begin
                      write(ans1[0],' ');
                      for i:=1 to ans1[0]-1 do
                        write(ans1[i],' ');
                      writeln(ans1[ans1[0]])
                     end
                else writeln(0);
  if ans2[0]<>0 then begin
                      write(ans2[0],' ');
                      for i:=1 to ans2[0]-1 do
                        write(ans2[i],' ');
                      writeln(ans2[ans2[0]])
                     end
                else writeln(0);
  close(output);
end.