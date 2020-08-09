{
ID:asiapea1
PROB:charrec
LANG:PASCAL
}
const ff:string=' abcdefghijklmnopqrstuvwxyz';
 
var font:array[1..27,1..20]of string[20];
    a:array[1..1200]of string[20];
    d,q,p:array[0..1200]of longint;
    f,fc:array[0..1200,19..21]of longint;
    line:array[0..1200,1..27,1..20]of longint;
    s,x,n,i,j,k,l:longint;
    ans:string;
 
procedure init;
begin
 assign(input,'font.in');reset(input);
 readln(n);
 for i:=1 to n div 20 do
  begin
   for j:=1 to 20 do
     readln(font[i,j]);
  end;
 close(input);
 assign(input,'charrec.in');reset(input);
 readln(n);
 for i:=1 to n do
   readln(a[i]);
end;
 
procedure update(x,i,j,k:longint);
begin
 if x=f[i,k] then begin
                   if fc[i,k]<>j then fc[i,k]:=0;
                  end
             else if x<f[i,k] then begin
                                    if x>120 then fc[i,k]:=0
                                             else fc[i,k]:=j;
                                    f[i,k]:=x;
                                   end;
end;
 
procedure dof;
begin
 for i:=1 to n do
  for j:=1 to 27 do
   for l:=1 to 20 do
    begin
      line[i,j,l]:=0;
      for k:=1 to 20 do
        if a[i,k]<>font[j,l,k] then inc(line[i,j,l]);
    end;
 fillchar(f,sizeof(f),10);
 for i:=1 to n do
  for j:=1 to 27 do
   begin
    s:=0;
    if i+20-1<=n then begin
                       for l:=1 to 20 do
                         s:=s+line[i+l-1,j,l];
                       update(s,i,j,20);
                      end;
 
    if i+19-1<=n then begin
                       if s=0 then for l:=1 to 20 do
                                     s:=s+line[i+l-1,j,l];
                       x:=s-line[i+20-1,j,20];
                       update(x,i,j,19);
                       for l:=19 downto 1 do
                        begin
                         x:=x-line[i+l-1,j,l]+line[i+l-1,j,l+1];
                         update(x,i,j,19);
                        end;
                     end;
 
   if i+21-1<=n then begin
                      x:=s;
                      update(x,i,j,21);
                      for l:=20 downto 1 do
                       begin
                        x:=x-line[i+l-1,j,l]+line[i+l,j,l];
                        update(x,i,j,21);
                       end;
                     end;
  end;
end;
 
begin
 init;
 dof;
 fillchar(d,sizeof(d),10);
 d[0]:=0;
 for i:=19 to n do
  for k:=19 to 21 do
      if (i>=k)and (d[i-k]<>168430090)and(d[i]>d[i-k]+f[i-k+1,k])
         then begin
                d[i]:=d[i-k]+f[i-k+1,k];
                q[i]:=fc[i-k+1,k];
                p[i]:=i-k;
              end;
 i:=n;
 while i<>0 do
  begin
   if q[i]=0 then ans:='?'+ans
             else ans:=ff[q[i]]+ans;
   i:=p[i];
  end;
 assign(output,'charrec.out');rewrite(output);
 writeln(ans);
 close(output);
end.