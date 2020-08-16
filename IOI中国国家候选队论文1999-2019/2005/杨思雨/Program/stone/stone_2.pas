Program Stone_Algorithm2;

Const
    inf='stone.in';
    outf='stone.out';
    maxn=1000000;

Var
    a,b,ans:longint;
    f:array[0..maxn]of boolean;

procedure swap;
var t:longint;
begin
    t:=a; a:=b; b:=t;
end;

procedure work;
var i,t:longint;
begin
    fillchar(f,sizeof(f),0);
    t:=0;
    for i:=0 to a-1 do
      if not f[i] then begin
          f[i+t]:=true;
          inc(t);
      end;
    if not(f[a]) and (a+t=b)
       then writeln(0) else writeln(1);
end;

Begin
    assign(input,inf); reset(input);
    assign(output,outf); rewrite(output);
      while not(seekeof) do
        begin
            read(a,b);
            if a>b then swap;
            work;
        end;
    close(input); close(output);
End.
