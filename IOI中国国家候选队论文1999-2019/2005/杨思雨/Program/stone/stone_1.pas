Program Stone_Algorithm1;

Const
    inf='stone.in';
    outf='stone.out';
    maxn=100;

Var
    a,b:longint;
    ans:array[0..maxn,0..maxn]of longint;

function dfs(a,b:longint):longint;
var i,t:longint;
begin
    if ans[a,b]<>0 then begin
        ans[b,a]:=ans[a,b];
        dfs:=ans[a,b]; exit;
    end;
    if ans[b,a]<>0 then begin
        ans[a,b]:=ans[b,a];
        dfs:=ans[a,b]; exit;
    end;

    for i:=1 to a do
      begin
          t:=dfs(a-i,b);
          if t=1 then begin
              ans[a,b]:=2; ans[b,a]:=2;
              dfs:=2;
              exit;
          end;
      end;
    for i:=1 to b do
      begin
          t:=dfs(a,b-i);
          if t=1 then begin
              ans[a,b]:=2; ans[b,a]:=2;
              dfs:=2;
              exit;
          end;
      end;
    for i:=1 to a do
      if i<=b then begin
          t:=dfs(a-i,b-i);
          if t=1 then begin
              ans[a,b]:=2; ans[b,a]:=2;
              dfs:=2;
              exit;
          end;
      end
      else break;
    dfs:=1;
end;

Begin
    assign(input,inf); reset(input);
    assign(output,outf); rewrite(output);
      fillchar(ans,sizeof(ans),0);
      ans[0,0]:=1;
      while not(seekeof) do
        begin
            read(a,b);
            ans[a,b]:=dfs(a,b);
            writeln(ans[a,b]-1);
        end;
    close(input); close(output);
End.
