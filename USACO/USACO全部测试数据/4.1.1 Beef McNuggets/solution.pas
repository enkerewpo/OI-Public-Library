{ID:asiapea1
PROB:nuggets
LANG:PASCAL
}
var
dp:array[0..700004] of longint;
a,b:array[0..300]of longint;
min,t,w,i,j,k,l,m,n:longint;
begin
assign(input,'nuggets.in');
reset(input);
readln(n);
m:=9999999;
for i:=1 to n do
begin
   read(a[i]);
   if a[i]<m then m:=a[i];
end;
//----------------------------
w:=0;
while (dp[w]<=2000000000)and(w<700000) do
   begin
    inc(w);
    l:=dp[w-1];
    min:=2000000005;
    for i:=1 to n do
      begin
        while dp[b[i]]+a[i]<=l do inc(b[i]);
        if dp[b[i]]+a[i]<min then min:=dp[b[i]]+a[i];
      end;
    dp[w]:=min;
    if dp[w]-dp[w-1]=1 then inc(k)
                       else k:=1;
    if k=m then break;
   end;
   assign(output,'nuggets.out');
   rewrite(output);
   if k<>m then  writeln(0)
           else writeln(dp[w-k+1]-1);
  close(output);

end.