var a:array[1..3] of longint;
    f:longint;
    i:integer;
begin
  for i:=1 to 3 do read(a[i]);
  if a[1]>a[2] then
    begin
      if a[1]>a[3] then
        i:=1
      else
        i:=3;
    end
  else
    begin
      if a[3]>a[2] then
        i:=3
      else
        i:=2;
    end;
  f:=0;
  while true do
    begin
      case i of
      1:begin
          if a[2]=a[3] then
            begin
              inc(f);break;
            end
          else
            if a[2]>a[3] then
              begin
                inc(f,2);a[1]:=a[2]-a[3];i:=2;
              end
            else
              begin
                inc(f);a[1]:=a[3]-a[2];i:=3;
              end;
        end;
      2:begin
          if a[1]=a[3] then
            begin
              inc(f,2);break;
            end
          else
            if a[1]>a[3] then
              begin
                inc(f);a[2]:=a[1]-a[3];i:=1;
              end
            else
              begin
                inc(f,2);a[2]:=a[3]-a[1];i:=3;
              end;
        end;
      3:begin
          if a[1]=a[2] then
            begin
              inc(f,3);break;
            end
          else
            if a[1]>a[2] then
              begin
                inc(f,2);a[3]:=a[1]-a[2];i:=1;
              end
            else
              begin
                inc(f);a[3]:=a[2]-a[1];i:=2;
              end;
        end;
      end;
    end;
  i:=f mod 3;
  if i=0 then i:=3;
  writeln('The student ',i,' can guess his number at round ',f);
end.