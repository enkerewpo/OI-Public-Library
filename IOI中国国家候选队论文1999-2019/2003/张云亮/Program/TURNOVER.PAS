{$S-,Y-,Q-,R-}
program turnover;
{This program was written by tiger.lee}

const
  InputFileName = 'turnover.in';
  OutputFileName = 'turnover.out';

type
  Pnode = ^Tnode;
  Tnode = object
    key: Longint;
    h: Integer;
    l, r: Pnode;
  end;

var
  n, i: Integer;
  x, answer, min: Longint;
  tree: Pnode;

procedure insertNode(const x : Longint;var node : Pnode);

var
  p, temp, child: Pnode;
  lh, rh: Integer;
  tmp: Longint;

procedure regulateLL;
begin
  temp := node^.l;
  node^.h := temp^.h - 1;
  node^.l := temp^.r;
  temp^.r := node;
  node := temp;
end;

procedure regulateLR;
begin
  child := node^.l;
  child^.h := child^.h - 1;
  node^.h := child^.h;
  temp := child^.r;
  temp^.h := child^.h + 1;
  child^.r := temp^.l;
  node^.l := temp^.r;
  temp^.r := node;
  temp^.l := child;
  node := temp;
end;

procedure regulateRR;
begin
  temp := node^.r;
  node^.r := temp^.l;
  node^.h := temp^.h - 1;
  temp^.l := node;
  node := temp;
end;

procedure regulateRL;
begin
  child := node^.r;
  child^.h := child^.h - 1;
  node^.h := child^.h;
  temp := child^.l;
  temp^.h := child^.h + 1;
  child^.l := temp^.r;
  node^.r := temp^.l;
  temp^.l := node;
  temp^.r := child;
  node := temp;
end;

begin
  if node = nil then begin
    New(p);
    p^.l := nil;
    p^.r := nil;
    p^.h := 1;
    p^.key := x;
    node := p;
    answer := answer + min;
    Exit;
  end;
  tmp := abs(node^.key - x);
  if tmp < min then min := tmp;
  if x <= node^.key then insertNode(x, node^.l)
  else insertNode(x, node^.r);
  if node^.l = nil then lh := 0 else lh := node^.l^.h;
  if node^.r = nil then rh := 0 else rh := node^.r^.h;
  if lh - rh = 2 then begin
    if node^.l^.l = nil then lh := 0 else lh := node^.l^.l^.h;
    if node^.l^.r = nil then rh := 0 else rh := node^.l^.r^.h;
    if lh - rh = 1 then regulateLL
    else regulateLR;
    Exit;
  end;
  if lh - rh = -2 then begin
    if node^.r^.l = nil then lh := 0 else lh := node^.r^.l^.h;
    if node^.r^.r = nil then rh := 0 else rh := node^.r^.r^.h;
    if lh - rh = -1 then regulateRR
    else regulateRL;
    Exit;
  end;
  if lh > rh then node^.h := lh + 1 else node^.h := rh + 1;
end;

begin
  Assign(Input, InputFileName);
  Reset(Input);
  Readln(n);
  Readln(answer);
  insertNode(answer, tree);
  for i := 2 to n do begin
    Readln(x);
    min := MaxLongint;
    insertNode(x, tree);
  end;
  Close(Input);
  Assign(Output, OutputFileName);
  Rewrite(Output);
  Writeln(answer);
  Close(Output);
end.