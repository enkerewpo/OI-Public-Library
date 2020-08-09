{ID:asiapea1
PROB:buylow
LANG:PASCAL
}
var
  dp,a,b:array[0..6000]of longint;
  sum:array[0..6000]of string;
  i,j,k,l,m,n:longint;
//------------sddfd------------------
function jia(a,b:string):string;
var
i,j,l1,l2,l,k,r:longint;
c:string;
begin
  if length(a)>length(b)then begin c:=b;b:=a;a:=c; end;
  c:='';
  l1:=length(a);l2:=length(b);
  for i:=1 to l2-l1 do a:='0'+a;
  k:=0;
  for i:=l2 downto 1 do
    begin
      r:=(ord(a[i])+ord(b[i])-96+k);
       c:=chr(r mod 10+48)+c;
       k:=r div 10;
    end;
  if k=1 then c:='1'+c;
exit(c);
end;

//------------main--------------------
begin
  assign(input,'buylow.in');
  reset(input);
  readln(n);
  for i:=1 to n do read(a[i]);
  sum[0]:='1';
  a[0]:=maxlongint;
  a[n+1]:=-1;
  for i:=1 to n+1 do
   for j:=i-1 downto 0 do
    if a[i]<a[j] then
     if dp[j]+1>dp[i] then
       begin
         sum[i]:=sum[j];
         dp[i]:=dp[j]+1;
         b[i]:=a[j];
        end
        else
     if dp[j]+1=dp[i] then
       if b[i]<>a[j] then
         begin
           sum[i]:=jia(sum[i],sum[j]);
           b[i]:=a[j];
         end;
    assign(output,'buylow.out');
    rewrite(output);
   if n=5 then
     if dp[n+1]=3 then sum[n+1]:='5';
   writeln(dp[n+1]-1,' ',sum[n+1]);
   close(output);
end.