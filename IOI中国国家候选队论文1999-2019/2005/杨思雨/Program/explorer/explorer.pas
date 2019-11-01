uses tools_p;

Const
    zero=1e-4;
    phi=(sqrt(5)-1)/2;

Var
    L,h,t:extended;

procedure work;
var lastf,lastx,x,f:extended;
begin
    lastx:=t*phi;
    lastf:=ask(lastx);
    while abs(h-t)>zero do
      begin
          x:=h+t-lastx;
          f:=ask(x);
          if f>lastf then begin
              if x>lastx then h:=lastx else t:=lastx;
              lastx:=x; lastf:=f;
          end
          else begin
              if x>lastx then t:=x else h:=x;
          end;
      end;
end;

Begin
    L:=Start;
    h:=0; t:=L;
    work;
    Answer((h+t)/2);
End.