{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R-,S+,T-,V+,X+,Y+}
{$M 65520,0,655360}
program Toxic; {Search Arithmetic}
  {JP 2000-1-11}
  const
      fin = 'toxic.in';
      fon = 'toxic.out';
      Dir : array[1..6,1..3]of shortint =
           ((1,0,0), (-1,0,0),
            (0,1,0), (0,-1,0),
            (0,0,1), (0,0,-1));
      Max = 10;
  type
      T2D = array[0..max+1,0..max+1]of shortint;
      T3D = array[0..max+1]of t2d;
  var
      Block, Adjoin : t3d;
      n   : array[1..3]of integer;
      a,aa : array[1..1000]of char;
      o,oo : array[1..1000,1..3]of integer;
      l,ll, E,ee : integer;
  procedure DataIn;
    var f:text;
    begin
    assign(f,fin); reset(f);
    readln(f,n[1],n[2],n[3]);
    close(f);
    end;
  procedure Refresh(x,y,z:integer;r:shortint);
    var i,xx,yy,zz:integer;
    begin
    for i:=1 to 6 do
      begin
      xx:=x+dir[i,1]; yy:=y+dir[i,2]; zz:=z+dir[i,3];
      inc(adjoin[xx,yy,zz],r);
      end;
    end;
  procedure Search(x,y,z:integer);
    var i,
        xx,yy,zz : integer;
    begin
    {Eat}
    for i:=1 to 6 do
      begin
      xx:=x+dir[i,1]; yy:=y+dir[i,2]; zz:=z+dir[i,3];
      if (xx=0)or(xx=n[1]+1)or(yy=0)or(yy=n[2]+1)or(zz=0)or(zz=n[3]+1)
        then continue;
      if (block[xx,yy,zz]=0) and (adjoin[xx,yy,zz]=1) then
        begin
        block[xx,yy,zz]:=1;
        refresh(xx,yy,zz,1);
        inc(l); a[l]:='E';
        o[l,1]:=xx; o[l,2]:=yy; o[l,3]:=zz;
        inc(e);
        if e > ee then
          begin
          ee:=e; aa:=a; oo:=o; ll:=l;
          end;
        search(x,y,z);
        dec(l);
        dec(e);
        refresh(xx,yy,zz,-1);
        block[xx,yy,zz]:=0;
        end;
      end;
    {Move}
    for i:=1 to 6 do
      begin
      xx:=x+dir[i,1]; yy:=y+dir[i,2]; zz:=z+dir[i,3];
      if (block[xx,yy,zz]=1) {and (adjoin[xx,yy,zz]=1)} then
        begin
        block[xx,yy,zz]:=2;
        inc(l); a[l]:='M';
        o[l,1]:=xx; o[l,2]:=yy; o[l,3]:=zz;
        search(xx,yy,zz);
        dec(l);
        block[xx,yy,zz]:=1;
        end;
      end;
    end;
  procedure out;
    var f:text;
        i:integer;
    begin
    assign(f,fon); rewrite(f);
    for i:=1 to ll do
      writeln(f,aa[i],' ',oo[i,1],' ',oo[i,2],' ',oo[i,3]);
    close(f);
    end;
  begin
  datain; e:=1;
  l:=2; a[1]:='E'; a[2]:='M';
  o[1,1]:=1; o[1,2]:=1; o[1,3]:=1;
  o[2,1]:=1; o[2,2]:=1; o[2,3]:=1;
  block[1,1,1]:=2; refresh(1,1,1,1);
  search(1,1,1);
  out;
  end.
