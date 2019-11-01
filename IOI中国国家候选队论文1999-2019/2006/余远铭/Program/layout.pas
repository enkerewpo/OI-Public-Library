Program Usaco_Dec05_layout;
Const
  Fin = 'layout.in';
  Fou = 'layout.out';
  MaxW = 1100000000;                                     {充分大的费用}
  Maxn = 1000;
  Maxm = 22000;

Var
  Dist: Array[1 .. Maxn]of Longint;                      {最短路长估计值}
  a, b, d: Array[1 .. Maxm]of Longint;                   {单独记录每条边}
  n, m, ML, MD: Longint;

Procedure Init;
  Var
    l, i, j, k: Longint;
  Begin
    Assign(Input, Fin);
    Reset(Input);
    Read(n, ML, MD);
    m:= 0;
    {为满足在队列中顺序与顶点顺序相同而加入的边}
    For l:= 2 to n do
      Begin
        Inc(m);
        a[m]:= l;
        b[m]:= l - 1;
        d[m]:= 0;
      End;
    {转换存有好感的边}
    For l:= 1 to ML do
      Begin
        Read(i, j);
        If i > j then
          Begin
            k:= i;
            i:= j;
            j:= k;
          End;
        Read(k);
        Inc(m);
        a[m]:= i;
        b[m]:= j;
        d[m]:= k;
      End;
    {转换存有反感的边}
    For l:= 1 to MD do
      Begin
        Read(i, j);
        If i > j then
          Begin
            k:= i;
            i:= j;
            j:= k;
          End;
        Read(k);
        Inc(m);
        a[m]:= j;
        b[m]:= i;
        d[m]:= -k;
      End;
    Close(Input);
  End;

Procedure Main;
  Var
    i, tmp, tot: Longint;
    Quit: Boolean;
  Begin
    For i:= 2 to n do Dist[i]:= MaxW; {将顶点的最短路设为充分大}
    Dist[1]:= 0;
    tot:= 0;
    {用Bellman-Ford求最短路，并判断是否存在负权圈}
    Repeat
      Inc(tot); {更新已经对每条边进行松弛操作的次数}
      Quit:= True;
      For i:= 1 to m do
        Begin
          tmp:= Dist[a[i]] + d[i];
          If tmp < Dist[b[i]] then
            Begin
              Dist[b[i]]:= tmp;
              Quit:= False; {有顶点的最短路径估计值更新了}
            End;
        End;
    Until Quit Or (tot > n); {没有顶点可以更新最短路估计值或存在负权圈}

    Assign(Output, Fou);
    Rewrite(Output);
    If (tot > n) then Writeln(-1) {存在负权圈，满足要求的方案不存在}
      Else
    If (Dist[n] = MaxW) then Writeln(-2) {当前最短路为充分大，说明距离可以任意大}
      Else
    Writeln(Dist[n] - Dist[1]); {输出可能的最大距离}
    Close(Output);
  End;

Begin
  Init;
  Main;
End.