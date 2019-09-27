{ Created by Weidong Hu, Jan.19, 2005 }

const
  inf = 'epidemic.in';
  ouf = 'epidemic.out';
  maxn = 300;

type
  xtype = array[0..maxn] of integer;

var
  linker : array[1..maxn] of ^xtype;
  ill : array[1..maxn] of byte;
  ti : integer;
  ills : array[1..maxn] of integer;
  n : integer;
  ans : integer;

  procedure prepare;
  var
    i : integer;
  begin
    for i := 1 to maxn do
    begin
      new(linker[i]);
      linker[i]^[0] := 0;
    end;
  end;

  procedure init;
  var
    i, a, b : integer;
  begin
    assign(input, inf); reset(input);
    read(n, a);
    for i := 1 to n - 1 do
    begin
      read(a, b);
      inc(linker[a]^[0]); linker[a]^[linker[a]^[0]] := b;
      inc(linker[b]^[0]); linker[b]^[linker[b]^[0]] := a;
    end;
    close(input);
  end;

  procedure main;
  var
    ii, i, j : integer;
    w, a : integer;
    total : integer;
  begin
    randSeed := 19860805;
    ans := n;
    for ii := 1 to 20000 do
    begin
      fillchar(ill, sizeof(ill), 0);
      ill[1] := 1;
      ills[1] := 1;
      ti := 1;
      total := 1;
      while true do
      begin
        for i := ti downto 1 do
        begin
          w := ills[i];
          ills[i] := ills[ti];
          dec(ti);
          for j := 1 to linker[w]^[0] do
          begin
            a := linker[w]^[j];
            if ill[a] = 0 then
            begin
              ill[a] := 1;
              inc(ti);
              ills[ti] := a;
            end;
          end;
        end;
        if ti <= 0 then break;
        w := random(ti) + 1;
        ills[w] := ills[ti];
        dec(ti);
        inc(total, ti);
        if total >= ans then break;
      end;
      if total < ans then ans := total;
    end;
  end;

  procedure print;
  begin
    assign(output, ouf); rewrite(output);
    writeln(ans);
    close(output);
  end;

begin
  prepare;
  init;
  main;
  print;
end.