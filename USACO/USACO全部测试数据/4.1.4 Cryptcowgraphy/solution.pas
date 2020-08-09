{
ID:zpyds1
PROB:cryptcow
LANG:PASCAL
}
program Cryptcowgraphy;
const st='Begin the Escape execution at the Break of Dawn';
var c,o,w:array[1..9,0..9]of integer;
    f:array[1..122,1..122,1..122]of boolean;
    hash:array[0..50000]of boolean;
    elf:array[1..75]of integer;
    m:longint;
    s:string;
 
  procedure timeout;
  begin
    writeln(0,' ',0);
    close(input);
    close(output);
    halt;
  end;
 
  procedure ansout;
  begin
    writeln(1,' ',m);
    close(input);
    close(output);
    halt;
  end;
 
  procedure init;
  var i,j,l,z,r:longint;
  begin
    readln(s);
    if s=st then ansout;
    if (length(s)-47)mod 3<>0 then timeout else m:=(length(s)-47)div 3;
    for i:=3 to 47 do
      begin
        l:=ord(st[i-2]);
        z:=ord(st[i-1]);
        r:=ord(st[i]);
        f[l,z,r]:=true;
      end;
    randomize;
    for i:=1 to 122 do
      for j:=1 to 122 do
        begin
          f[i,j,67]:=true; f[i,67,j]:=true; f[67,i,j]:=true;
          f[i,j,79]:=true; f[i,79,j]:=true; f[79,i,j]:=true;
          f[i,j,87]:=true; f[i,87,j]:=true; f[87,i,j]:=true;
        end;
 
  end;
 
  procedure get(k:longint; var ct,ot,wt:longint);
  var i:longint;
  begin
    ct:=0; ot:=0; wt:=0;
    c[k,1]:=100; o[k,1]:=100;
    for i:=1 to length(s) do
      begin
        if s[i]='C' then begin inc(ct); c[k,ct]:=i; end;
        if (s[i]='O')and(i>c[k,1]) then begin inc(ot); o[k,ot]:=i; end;
        if (s[i]='W')and(i>o[k,1]) then begin inc(wt); w[k,wt]:=i; end;
      end;
  end;
 
  function change(l,z,r:longint):string;
  var i:longint;
  begin
    change:='';
    change:=copy(s,1,l-1)+copy(s,z+1,r-z-1)+copy(s,l+1,z-l-1)+copy(s,r+1,length(s)-r);
  end;
 
  function checksub:boolean;
  var i,l,z,r:longint;
      g,h:longword;
  begin
    l:=ord(s[1]); z:=ord(s[2]);
    for i:=3 to length(s) do
      begin
        r:=ord(s[i]);
        if not f[l,z,r] then exit(true);
        l:=z; z:=r;
      end;
    exit(false);
  end;
 
  function checkprefix:boolean;
  var i:longint;
  begin
    for i:=1 to 47 do
      begin
        if s[i] in ['C','O','W'] then
          begin if s[i]='C' then exit(false) else exit(true); end;
        if s[i]<>st[i] then exit(true);
      end;
    exit(false);
  end;
 
 
  function checksuffix:boolean;
  var l,i:longint;
  begin
    l:=length(s);
    for i:=47 downto 1 do
      begin
        if s[l] in ['C','O','W'] then
          begin if s[l]='W' then exit(false) else exit(true); end;
        if s[l]<>st[i] then exit(true);
        l:=l-1;
      end;
    exit(false);
  end;
 
  function checkhash:boolean;
  var g,h,i:longword;
  begin
    h:=0;
    for i:=1 to length(s) do
      begin
        h:=h shl 4 + ord(s[i]);
        g:=h and $f0000000;
        if g<>0 then h:=h xor (g shr 24);
        h:=h and (not g);
      end;
    h:=h mod 50000;
    if hash[h] then begin hash[h]:=false; exit(false); end;
    exit(true);
  end;
 
  procedure dfs(k:longint);
  var i,l,r,ct,ot,wt:longint;
      temp:string;
  begin
    if k>m then ansout;
    get(k,ct,ot,wt);
    for i:=1 to ot do
      for l:=1 to ct do
        for r:=wt downto 1 do
          if (c[k,l]<o[k,i])and(o[k,i]<w[k,r]) then
            begin
              temp:=s;
              s:=change(c[k,l],o[k,i],w[k,r]);
              if checksub    then begin s:=temp; continue; end;
              if checkprefix then begin s:=temp; continue; end;
              if checksuffix then begin s:=temp; continue; end;
              if checkhash   then begin s:=temp; continue; end;
              dfs(k+1);
              s:=temp;
            end;
  end;
 
begin
  assign(input,'cryptcow.in');   reset(input);
  assign(output,'cryptcow.out'); rewrite(output);
  fillchar(hash,sizeof(hash),true);
  init;
  dfs(1);
  writeln(0,' ',0);
  close(input);
  close(output);
end.