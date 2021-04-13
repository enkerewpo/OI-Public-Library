var
  n : integer;
  number : integer;
  sym : char;

procedure gamerule;
begin
  writeln; writeln; writeln; writeln; writeln; writeln;
  writeln('Hi! You are now in a funny game. There are n balls. One of them is different ');
  writeln('from the others -- it can be either heavier or lighter.');
  writeln;
  writeln('You should select the special ball and whether it''s heavier or lighter in mind.');
  writeln;
  writeln('The computer will ask you some questions. For each question, two sets of balls ');
  writeln('will be given, and you should answer which set is');
  writeln(' heavier or that they are of the same weight.');
  writeln;
  writeln('At the end, the computer will tell which ball is special, and whether it is ');
  writeln('heavier or lighter.');
  writeln('The computer will ask the least number of questions possible during a game');
  writeln('session.');
  writeln;
  writeln('Now, have the special ball number in your mind and enter the number of balls:');
  readln(n);
  writeln;
end;

procedure show(s, t : integer);
var
  i : integer;
begin
  for i := s to t do
    write(' ', i);
end;

procedure difball(s0, t0, s1, t1 : integer);
var
  l0, l1 : integer;
  part0, part1 : integer;
  p : integer;
begin
  l0 := t0 - s0 + 1;
  l1 := t1 - s1 + 1;
  if l0 = 0 then begin
    number := s1;
    sym := 'L'
  end else if l1 = 0 then begin
    number := s0;
    sym := 'H';;
  end else if (l0 = 1) and (l1 = 1) then begin
    write('Set 1 : '); writeln(s0);
    write('Set 2 : '); writeln(n);
    write('Enter which set is heavier (1 or 2) or 0 if same : ');
    readln(p);
    if p = 1 then begin
      number := s0;
      sym := 'H'
    end else if p = 0 then begin
      number := s1;
      sym := 'L';
    end;
  end else if (l0 = 1) and (l1 = 2) then begin
    write('Set 1 : '); writeln(s1);
    write('Set 2 : '); writeln(t1);
    write('Enter which set is heavier (1 or 2) or 0 if same : ');
    readln(p);
    if p = 0 then begin
      number := s0;
      sym := 'H';
    end else if p = 1 then begin
      number := t1;
      sym := 'L';
    end else if p = 2 then begin
      number := s1;
      sym := 'L';
    end;
  end else if (l0 = 2) and (l1 = 1) then begin
    write('Set 1 : '); writeln(s0);
    write('Set 2 : '); writeln(t0);
    write('Enter which set is heavier (1 or 2) or 0 if same : ');
    readln(p);
    if p = 0 then begin
      number := s1;
      sym := 'L';
    end else if p = 1 then begin
      number := s0;
      sym := 'H';
    end else if p = 2 then begin
      number := t0;
      sym := 'H';
    end;
  end else begin
    if l0 mod 3 <> 2 then
      part0 := l0 div 3
    else
      part0 := l0 div 3 + 1;
    if l1 mod 3 <> 2 then
      part1 := l1 div 3
    else
      part1 := l1 div 3 + 1;

    if (l0 mod 3 = 1) and (l1 mod 3 = 1) then
      part1 := l1 div 3 + 1;

    write('Set 1 :');
    show(s0, s0 + part0 - 1);
    show(s1 + part1, s1 + 2 * part1 - 1);
    writeln;

    write('Set 2 :');
    show(s0 + part0, s0 + 2 * part0 - 1);
    show(s1, s1 + part1 - 1);
    writeln;

    write('Enter which set is heavier (1 or 2) or 0 if same : ');
    readln(p);
    if p = 1 then
      difball(s0, s0 + part0 - 1, s1, s1 + part1 - 1)
    else if p = 2 then
      difball(s0 + part0, s0 + 2 * part0 - 1, s1 + part1, s1 + 2 * part1 - 1)
    else if p = 0 then
      difball(s0 + part0 * 2, t0, s1 + part1 * 2, t1);
  end;
end;

procedure sameball(s, t : integer);
var
  part, p : integer;
  l, l1, l2 : integer;
begin
  l := t - s + 1;
  l1 := l div 3;
  if l mod 3 <> 0 then l2 := l1 + 1 else l2 := l1;
  write('Set 1 :');
  show(s, s + l1 - 1);
  if l2 > l1 then writeln(' 1') else writeln;

  write('Set 2 :');
  show(s + l1, s + l1 + l2 - 1);
  writeln;

  write('Enter which set is heavier (1 or 2) or 0 if same : ');
  readln(p);

  if p = 0 then
    sameball(s + l1 + l2, t)
  else if p = 1 then
    difball(s, s + l1 - 1, s + l1, s + l1 + l2 - 1)
  else if p = 2 then
    difball(s + l1, s + l1 + l2 - 1, s, s + l1 - 1);
end;

procedure main;
var
  part, p : integer;
begin
  if n mod 3 = 2 then
    part := n div 3 + 1
  else
    part := n div 3;
  write('Set 1 :'); show(1, part); writeln;
  write('Set 2 :'); show(part + 1, 2 * part); writeln;
  write('Enter which set is heavier (1 or 2) or 0 if same : ');
  readln(p);
  if p = 0 then
    sameball(part * 2 + 1, n)
  else if p = 1 then
    difball(1, part, part + 1, 2 * part)
  else if p = 2 then
    difball(part + 1, 2 * part, 1, part);
end;

procedure print;
begin
  writeln('The ordinal number of the special ball is : '); writeln(number, '.');
  write('It is ');
  if sym = 'H' then
    writeln('heavier than the others.')
  else
    writeln('lighter than the others.');
end;

begin
  gamerule;
  main;
  print;
end.
