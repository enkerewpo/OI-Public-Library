{
ID:asiapea1
PROB:lgame
LANG:PASCAL
}
const score:array['a'..'z']of longint=(2,5,4,4,1,6,5,5,1,7,6,3,5,2,3,5,7,2,1,2,4,6,6,7,5,7);
 
var an,pd,pp,p2:array['a'..'z']of longint;
    a:array['a'..'z',1..5000,1..7]of string[7];
    sc,dn:array['a'..'z',1..5000]of longint;
    ans,f,i,j,k,n,l:longint;
    ch:char;
    s:string[7];
 
function ok(s:string):longint;
var i,g:longint;
begin
  pp:=pd;
  g:=0;
  for i:=1 to length(s) do
     if pp[s[i]]=0 then exit(0)
                   else begin
                         dec(pp[s[i]]);
                         inc(g,score[s[i]]);
                        end;
  exit(g);
end;
 
procedure insert(s:string);
var i,p:longint;
begin
 if length(s)=l then begin
                      inc(an[s[1]]);
                      dn[s[1],an[s[1]]]:=1;
                      a[s[1],an[s[1]],1]:=s;
                      sc[s[1],an[s[1]]]:=f;
                      if ans<f then ans:=f;
                     end
                else begin
                      inc(an[s[1]]);
                      dn[s[1],an[s[1]]]:=1;
                      a[s[1],an[s[1]],1]:=s;
                      sc[s[1],an[s[1]]]:=f;
                      if ans<f then ans:=f;
                      p2:=pp;
                      for ch:='a' to 'z' do
                       if p2[ch]<>0
                         then for i:=1 to an[ch] do
                               begin
                                p:=ok(a[ch,i,1]+s);
                                if p>sc[ch,i]
                                     then begin
                                            dn[ch,i]:=2;
                                            a[ch,i,2]:=s;
                                            sc[ch,i]:=p;
                                            if ans<p then ans:=p;
                                          end
                                     else if p=sc[ch,i]
                                            then begin
                                                  inc(dn[ch,i]);
                                                  a[ch,i,dn[ch,i]]:=s;
                                                 end;
                               end;
                     end;
end;
 
begin
 assign(input,'lgame.in');reset(input);
 l:=0;
 while not eoln do
  begin
   read(ch);
   inc(pd[ch]);
   inc(l);
  end;
 close(input);
 
 n:=0;
 assign(input,'lgame.dict');reset(input);
 while not eof do
  begin
   readln(s);
   if s='.' then break;
   f:=ok(s);
   if f>0 then insert(s);
  end;
 assign(output,'lgame.out');rewrite(output);
 writeln(ans);
 for ch:='a' to 'z' do
  for i:=1 to an[ch] do
   if sc[ch,i]=ans then begin
                          if dn[ch,i]=1
                            then writeln(a[ch,i,1])
                            else for j:=2 to dn[ch,i] do
                                   writeln(a[ch,i,1],' ',a[ch,i,j]);
                        end;
 close(output);
end.