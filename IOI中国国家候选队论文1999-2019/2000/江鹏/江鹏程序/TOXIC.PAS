{$R+}

program Toxic_Game;

const
  name1         =       'toxic.in';  {输入文件}
  name2         =       'toxic.out'; {输出文件}
  go            :       array[1..4, 1..2] of shortint {平面上4个方向的坐标增量}
                =       ((0, 1), (1, 0), (0, -1), (-1, 0));
  six           :       array[1..6, 1..3] of shortint {立方体6个相邻面的坐标增量}
                =       ((1, 0, 0), (0, 1, 0), (0, 0, 1),
                         (-1, 0, 0), (0, -1, 0), (0, 0, -1));

type
  Tsize         =       array[1..3] of integer;
  Tblocks       =       array[0..33, 0..33, 0..33] of shortint;

var
  size          :       Tsize;   {长方体的长、宽、高}
  StoE, EtoS,                    {StoE[i]由于坐标变换}
  BStoE         :       Tsize;   {BStoE表示Best Size to Experiment，记录下最优的坐标变换}
  mx, my, mz    :       integer; {maxX、maxY、maxZ}
  ans, sum      :       integer; {ans存放当前最优解，sum存放当前吃掉的立方体数目}
  blocks        :       Tblocks; {存放当前路径的信息}
       {blocks[x,y,z]:  -1表示走过该格  -2表示已经吃掉该格  大等于0表示当前暴露的面的数目}
  b2            :       ^TBlocks; {记录路径，为“拾遗”做准备}
  outf          :       text;     {输出文件}
  print         :       boolean;  {寻找最优解答和打印解用同一个过程，print表示是否打印}

procedure init; {文件初始化}
  var f : text;
  begin
  assign(f, name1);
  reset(f);
  readln(f, size[1], size[2], size[3]);
  close(f);

  assign(outf, name2);
  rewrite(outf)
  end;

procedure initblocks; {初始化blocks}
  var x, y, z : integer;
  begin
  fillchar(blocks, sizeof(blocks), 255);
  for x := 1 to mx do
    for y := 1 to my do
      for z := 1 to mz do
        blocks[x, y, z] := 0
  end;

procedure say(ch : char; x, y, z : integer); {当print=TRUE时输出一个命令}
  var o : Tsize;
  begin
  if not print then exit;
  o[ EtoS[1] ] := x;
  o[ EtoS[2] ] := y;
  o[ EtoS[3] ] := z;
  writeln(outf, ch, ' ', o[1], ' ', o[2], ' ', o[3])
  end;

function eat_block(x, y, z : integer) : boolean; {吃掉立方体(x,y,z)，返回是否成功}
  var i, xx, yy, zz : integer;
  begin
  if (x = 0) or (x > mx) or
     (y = 0) or (y > my) or
     (z = 0) or (z > mz) or
     (blocks[x, y, z] <> 1)
    then begin eat_block := false; exit end;
  eat_block := true;
  blocks[x, y, z] := -2;
  say('E', x, y, z);
  inc(sum);
  for i := 1 to 6 do
    begin
    xx := x + six[i, 1];
    yy := y + six[i, 2];
    zz := z + six[i, 3];
    if blocks[xx, yy, zz] >=0
      then inc(blocks[xx, yy, zz])
    end
  end;

procedure pick_block(x, y, z : integer); 
{对(x,y,z)拾遗，如果立方体(x,y,z)只有一个面与路径接触，则吃掉(x,y,z)不会影响路径}
  var i, j, xx, yy, zz : integer;
  begin
  if (x = 0) or (x > mx) or
     (y = 0) or (y > my) or
     (z = 0) or (z > mz) or
     (blocks[x, y, z] <> 1)
    then exit;
  j := 0;
  for i := 1 to 6 do
    begin
    xx := x + six[i, 1];
    yy := y + six[i, 2];
    zz := z + six[i, 3];
    if (xx >= 1) and (xx <= mx) and
       (yy >= 1) and (yy <= my) and
       (zz >= 1) and (zz <= mz) and (b2^[xx, yy, zz] = -1)
      then inc(j)
    end;
  if j = 1 then eat_block(x, y, z)
  end;

procedure pick_6(x, y, z : integer); {对6个方向拾遗}
  var i : integer;
  begin
  if (z > 0) and print
    then for i := 1 to 6 do
           pick_block(x + six[i, 1], y + six[i, 2], z + six[i, 3])
  end;

procedure make_way; {按照构造的方法路径}
  var nx, ny, nz, ns : integer; 
{(nx, ny, nz)表示当前坐标，ns表示当前状态，ns=1表示在主线上移动，ns>1表示在相邻主线的衔接处}
      ford, upd      : integer;

  procedure odd_plane; {奇数层的移动和吃食}
  var t, i, h : integer;
  begin
  eat_block(nx, ny, nz);
  pick_6(nx, ny, nz-1);
  blocks[nx, ny, nz-1] := -1;
  say('M', nx, ny, nz);
  if ns = 2
    then ns := 4
    else ns := 1;
  if ny = 1
    then upd := 1
    else upd := 3;

  repeat
    case ns of
    1 : begin
        if nx = 1
          then ford := 2
          else ford := 4;
        h := 1;
        while eat_block(nx + go[ford, 1], ny, nz) do
          begin
          inc(h);
          eat_block(nx, ny, nz-1);
          if nz+1 = mz then eat_block(nx, ny, nz+1);
          if (upd <> 1) or (h < mx-1) then eat_block(nx, ny+1, nz);
          if (upd <> 3) or (h < mx-1) then eat_block(nx, ny-1, nz);
          pick_6(nx, ny, nz);
          blocks[nx, ny, nz] := -1;
          nx := nx + go[ford, 1];
          say('M', nx, ny, nz)
          end;
        ns := 2
        end;
 2..4 : begin
        if eat_block(nx, ny + go[upd, 2], nz)
          then begin
               eat_block(nx, ny, nz-1);
               if nz+1 = mz then eat_block(nx, ny, nz+1);
               pick_6(nx, ny, nz);
               blocks[nx, ny, nz] := -1;
               ny := ny + go[upd, 2];
               say('M', nx, ny, nz);
               ns := ns mod 4+1
               end
          else break
        end
    end
  until false
  end;

  procedure even_plane; {偶数层的移动和吃食}
  begin
  if not eat_block(nx, ny, nz) then exit;
  pick_6(nx, ny, nz-1);
  blocks[nx, ny, nz-1] := -1;
  say('M', nx, ny, nz)
  end;

  begin
  {对坐标进行变换}
  sum := 0;
  EtoS[ StoE[1] ] := 1;
  EtoS[ StoE[2] ] := 2;
  EtoS[ StoE[3] ] := 3;
  mx := Size[ EtoS[1] ];
  my := Size[ EtoS[2] ];
  mz := Size[ EtoS[3] ];
  {开始构造}
  initblocks;
  blocks[1, 1, 1] := 1;
  nx := 1; ny := 1; nz := 0; ns := 3;

  for nz := 1 to mz do
    if odd(nz)
      then odd_plane
      else even_plane;

  {更新当前最优解}
  if sum > ans
    then begin ans := sum; b2^ := blocks; BStoE := StoE end
  end;

  {主程序}
  begin
  new(b2);
  init;
  ans := -1; min := maxint;
  print := false;

  for StoE[1] := 1 to 3 do
    for StoE[2] := 1 to 3 do
      for StoE[3] := 1 to 3 do
        if [ StoE[1], StoE[2], StoE[3] ] = [1..3]
          then make_way;

  StoE := BStoE;
  print := true;
  make_way;

  close(outf);
  writeln('Eat = ', sum);
  writeln('Rate = ', sum /mx/my/mz :0 :2)
  end.
