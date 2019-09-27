{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R+,S+,T-,V+,X+,Y+}
{$M 65520,0,655360}
program Toxic_Simulation;
  {JP 2000-1-10}
  uses Graph, Crt;
  const
    fin = 'toxic.in';
    fon = 'toxic.out';
    Dir : array[1..6,1..3]of ShortInt =
          ((0,0,1),(0,0,-1),
           (0,1,0),(0,-1,0),
           (0,0,1),(0,0,-1));
    Max = 32;
  type
    T2d = array[0..max+1,0..max+1]of Byte;
    T3d = array[0..max+1]of T2d;
  var
    Ans         :       Integer;
    Block       :       T3d;
    n,m,p,x,y   :       array[0..3]of Integer;
    w,a,b,r     :       integer;
    x1,y1,x2,y2 :       integer;
    i,j         :       integer;
  procedure Change(i,j,k:integer);
    begin
    m[1]:=i; m[2]:=j; m[3]:=k;
    p[1]:=n[i]; p[2]:=n[j]; p[3]:=n[k];
    end;
  procedure DataIn;
    var f:text;
    begin
    Assign(f,fin); Reset(f);
    ReadLn(f,n[1],n[2],n[3]);
    Change(1,2,3);
    n:=p;
    Close(f);
    end;
  procedure GetZPos(k:integer; var xx,yy:integer);
    var x,y:integer;
    begin
    y:=(k-1)div a;
    x:=k-1-a*y;
    xx:=11+x*(w*n[1]+11);
    yy:=7+w*n[2]+y*(w*n[2]+21);
    end;
  procedure GetCoords(i,j,k:integer; var xx,yy:integer);
    begin
    GetZPos(k,xx,yy);
    xx:=xx+(i-1)*w;
    yy:=yy-j*w;
    end;
  procedure DrawBlock(i,j,k:integer; s:integer);
    var x0,y0:integer;
    begin
    GetCoords(i,j,k,x0,y0);
    SetColor(White);
    Rectangle(x0,y0,x0+w,y0+w);
    case s of
      0:begin
        SetFillStyle(1,Green);
        Bar(x0+1,y0+1,x0+w-1,y0+w-1);
        end;
      1:begin
        SetFillStyle(1,Black);
        Bar(x0+1,y0+1,x0+w-1,y0+w-1);
        end;
      2:begin
        SetColor(Red);
        SetFillStyle(1,Red);
        x1:=x0+w div 2;
        y1:=y0+w div 2;
        PieSlice(x1,y1,0,360,R);
        end;
      3:begin
        SetColor(Black);
        SetFillStyle(1,Black);
        x1:=x0+w div 2;
        y1:=y0+w div 2;
        PieSlice(x1,y1,0,360,R);
        end;
    end;
    end;
  procedure InitDraw;
    var i,j,k:integer;
        s:string[10];
        xx,yy:integer;
    begin
    for k:=1 to n[3] do
      begin
      Str(k,s); s:='Z = '+s;
      GetZPos(k,xx,yy);
      SetColor(White);
      OutTextXY(xx+30,yy+6,s);
      for i:=1 to n[1] do
        for j:=1 to n[2] do
          DrawBlock(i,j,k,0);
      end;
    end;
  procedure Initialize;
    var gd,gm:integer;
    begin
    gd:=0;
    InitGraph(gd, gm, 'c:\bp\bgi');
    w:=400;
    repeat
      a:=620 div (w*n[1]+1+10);
      b:=460 div (w*n[2]+1+20);
      if (n[3]<=a*b) then
        break;
      dec(w);
    until w<2;
    R:=(w-1) div 2-2;
    InitDraw;
    end;
  var
      f:text;
      ch:char;
      sum:integer;
      s:string[30];
  begin
  DataIn; Initialize;
  p[1]:=0;p[2]:=0;p[3]:=0;
  Assign(f,fon); Reset(f);
  while not eof(f) do
    begin
    Read(f,ch);
    ReadLn(f,x[1],x[2],x[3]);
    for i:=1 to 3 do
      y[i]:=x[m[i]];
    x:=y;
    case ch of
      'E':begin
          Block[x[1],x[2],x[3]]:=1;
          DrawBlock(x[1],x[2],x[3],1);
          inc(sum);
          end;
      'M':begin
          if p[1]>0 then
          DrawBlock(p[1],p[2],p[3],3);
          x2:=x1; y2:=y1;
          DrawBlock(x[1],x[2],x[3],2);
          SetLineStyle(0, 0, ThickWidth);
{          if p[3]=x[3]
            then SetColor(LightBlue)
            else SetColor(LightRed);
          Line(x1,y1,x2,y2);}
          p:=x;
          SetLineStyle(0, 0, 0);
          end;
    end;
    if readkey=#27 then halt;
    end;
  Close(f);
  setcolor(yellow);
  str(sum, s);
  outtextxy(100, 450, s + ' END...');
  repeat until readkey = #13;
  end.
