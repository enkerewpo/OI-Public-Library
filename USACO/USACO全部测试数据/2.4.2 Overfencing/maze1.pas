{
ID:asiapea1
PROG:maze1
LANG:PASCAL
}
var
  a:array[1..100,1..100,1..4]of 0..1;
  f1,f2:text;
  b:array[1..100,1..100]of integer;
  step,i,j,x1,y1,x2,y2,h,w:integer;
  ch:char;
  Function Touch:boolean;
  var
    i,j:integer;
    begin
      Touch:=false;
      for i:=1 to h do
        for j:=1 to w do
          if b[i,j]=0 then exit;
      Touch:=true;
    end;
begin
  assign(f1,'maze1.in');
  reset(f1);
  readln(f1,w,h);
  fillchar(a,sizeof(a),0);
  for i:=1 to h*2+1 do
    begin
      for j:=1 to w*2+1 do
        begin
          read(f1,ch);
          if ch='-' then
              begin
                if i<>1 then a[i div 2,j div 2,2]:=1;
                if i<>h*2+1 then a[(i+1) div 2,j div 2,1]:=1;
              end;
          if ch='|' then
              begin
                if j<>1 then a[i div 2,j div 2,4]:=1;
                if j<>w*2+1 then a[i div 2,(j+1) div 2,3]:=1;
              end;
        end;
      readln(f1);
    end;
  close(f1);
  x1:=0;x2:=0;
  for j:=1 to w do
    if a[1,j,1]=0 then if x1=0 then begin
                                      x1:=1;y1:=j;
                                    end
                               else begin
                                      x2:=1;y2:=j;
                                    end;
  for i:=1 to h do
    if a[i,1,3]=0 then if x1=0 then begin
                                      x1:=i;y1:=1;
                                    end
                               else begin
                                      x2:=i;y2:=1;
                                    end;
  for j:=1 to w do
    if a[h,j,2]=0 then if x1=0 then begin
                                      x1:=h;y1:=j;
                                    end
                               else begin
                                      x2:=h;y2:=j;
                                    end;
    for i:=1 to h do
    if a[i,w,4]=0 then if x1=0 then begin
                                      x1:=i;y1:=w;
                                    end
                               else begin
                                      x2:=i;y2:=w;
                                    end;
    fillchar(b,sizeof(b),0);
    b[x1,y1]:=1;b[x2,y2]:=1;
    step:=1;
    while not Touch do
      begin
        inc(step);
        for i:=1 to h do
          for j:=1 to w do
            if b[i,j]=step-1 then
                begin
                  if (a[i,j,1]=0) and (i>1) then if b[i-1,j]=0 then b[i-1,j]:=step;
                  if (a[i,j,2]=0) and (i<h) then if b[i+1,j]=0 then b[i+1,j]:=step;
                  if (a[i,j,3]=0) and (j>1) then if b[i,j-1]=0 then b[i,j-1]:=step;
                  if (a[i,j,4]=0) and (j<w) then if b[i,j+1]=0 then b[i,j+1]:=step;
                end;
      end;
    assign(f2,'maze1.out');
    rewrite(f2);
    writeln(f2,step);
    close(f2);
end.