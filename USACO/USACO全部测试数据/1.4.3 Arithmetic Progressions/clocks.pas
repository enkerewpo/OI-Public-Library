{
PROB:clocks
LANG:PASCAL
ID:asiapea1
}

const
        dir     :       array[1..9] of string =
        ('ABDE','ABC','BCEF','ADG','BDEFH','CFI','DEGH','GHI','EFHI');

type
        tclock  =       array[1..9] of longint;
        tstep   =       array[1..100] of longint;

var
        q,a     :       tstep;
        used,s  :       tclock;
        ans     :       longint;

procedure prepare;
var
        i       :       longint;
begin
  assign(input,'clocks.in');reset(input);
  for i:=1 to 9 do
    begin
      read(s[i]);
      s[i]:=(s[i] div 3) and 3;
    end;
  close(input);
  ans:=maxlongint;
end;

function equal(dd:tclock):boolean;
var
        xx      :       longint;
begin
  for xx:=1 to 9 do if dd[xx]<>0 then exit(false);
  exit(true);
end;

procedure dfs(dep,last:longint;st:tclock);
var
        i,j,k   :       longint;
        ss      :       tclock;
begin
  if dep>ans then exit;
  if equal(st) and (dep<ans) then
    begin
      ans:=dep;
      a:=q;
      exit;
    end;
  for i:=last to 9 do
    if used[i]<4 then
      begin
        inc(used[i]);
        q[dep]:=i;
        ss:=st;
        for j:=1 to length(dir[i]) do
          begin
            k:=ord(dir[i][j])-64;
            ss[k]:=(ss[k]+1) and 3;
          end;
        dfs(dep+1,i,ss);
        dec(used[i]);
      end;
end;

procedure print;
var
        i       :       longint;
begin
  assign(output,'clocks.out');rewrite(output);
  dec(ans);
  for i:=1 to ans do
    if i<>ans then write(a[i],' ')
              else writeln(a[i]);
  close(output);
end;

begin
  prepare;
  dfs(1,1,s);
  print;
end.
