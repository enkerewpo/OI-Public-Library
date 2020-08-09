{
  ID : asiapea1
  LANG : PASCAL
  TASK : ariprog
}
const a : array[1..22] of integer=(1,1,1,4,4,12,12,12,12,12,12,84,84,84,84,84,84,84,84,84,84,2772);
var i,j,jj,k,n,m,mm : longint; l : byte;
    b : packed array[0..125000] of boolean;
    find,f : boolean;

begin
  assign(input,'ariprog.in'); reset(input); assign(output,'ariprog.out'); rewrite(output);
  readln(n); readln(m); close(input);
  if n>=23 then begin writeln('NONE'); close(output); halt; end;
  fillchar(b,sizeof(b),0);
  for i := 0 to m do
    for j := i to m do b[sqr(i)+sqr(j)] := true;
  find := false; m := sqr(m) shl 1; mm := m div (n-1) div a[n]+1;
  for j := 1 to mm do begin
    jj := j*a[n];
    for i := 0 to m-(n-1)*j do begin
        f := true; k := i;
        for l := 1 to n do
          if not b[k] then begin f := false; break; end
          else begin
            inc(k,jj);
            if (k>m) and (l<n) then begin f := false; break; end;
          end;
        if f then begin writeln(i,' ',jj); if not find then find := true; end;
      end;
    end;
  if not find then writeln('NONE');
  close(output);
end.
