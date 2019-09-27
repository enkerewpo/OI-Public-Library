Program Stone_Algorithm3;

Const
    inf='stone.in';
    outf='stone.out';
    phi=(sqrt(5)+1)/2;

Var
    a,b:longint;

procedure swap;
var t:longint;
begin
    t:=a; a:=b; b:=t;
end;


procedure main;
var t:longint;
begin
    assign(input,inf); reset(input);
    assign(output,outf); rewrite(output);
      while not(seekeof) do
        begin
            read(a,b);
            if a>b then swap;

            if a+b=0 then begin
                writeln(0); continue;
            end;
            t:=trunc(a/phi+1);
            if (a=trunc(t*phi)) and (b=a+t)
            then writeln(0) else writeln(1);
        end;
    close(input); close(output);
end;

Begin
    main;
End.
