{用SPFA算法实现}

{$R-,S-,Q-}
Program BOI2002_Bicriterial_routing;
Const
  Fin = 'bic.in';
  Fou = 'bic.out';
  Maxn = 100;
  MaxNode = 1280128;

Var
  Count: Array[1 .. MaxNode]of Boolean;                 {记录每个顶点当前是否在队列中}
  Sta: Array[1 .. MaxNode]of Longint;                   {求最短路的辅助队列}
  Dis: Array[1 .. MaxNode]of Word;                      {最短路径估计值}
  a, b, d: Array[1 .. Maxn, 1 .. Maxn]of Longint;       {用邻接表存图}
  c: Array[1 .. Maxn]of Longint;                        {每个点的出度}
  n, s, t: Longint;

Procedure Init; {读入}
  Var
    i, j, k, x, y, m: Longint;
  Begin
    Assign(Input, Fin);
    Reset(Input);
    Read(n, m, s, t);
    For k:= 1 to m do
      Begin
        Read(i, j, x, y);
        {将每条边拆成两条有向边}
        Inc(c[i]);
        a[i, c[i]]:= x;
        b[i, c[i]]:= y;
        d[i, c[i]]:= j;
        Inc(c[j]);
        a[j, c[j]]:= x;
        b[j, c[j]]:= y;
        d[j, c[j]]:= i;
      End;
   Close(Input);
  End;

Procedure Main;
  Var
    v, w, w1, i, j, k, tmp, head, tail: Longint;
  Begin
    {最短路估计值处始化}
    For i:= 1 to MaxNode do
      Dis[i]:= 30000;

    {起点进入队列}
    head:= 1;
    tail:= 1;
    Sta[1]:= s;
    Dis[s]:= 0;
    Count[s]:= True;

    {SPFA算法的循环}
    Repeat
      v:= Sta[head] And 127; {得出当前顶点}
      w:= Sta[head] Shr 7;   {得出当前的费用}
      k:= Dis[Sta[head]];    {得出当前最短路长}
      For i:= 1 to c[v] do
        Begin
          w1:= w + a[v, i];
          If (w1 > 10000) then Continue; {比可能的最大值大则舍去}
          j:= w1 Shl 7 + d[v, i]; {将顶点加密，以节省空间}
          {进行松弛操作}
          tmp:= k + b[v, i];
          If (tmp < Dis[j]) then
            Begin
              Dis[j]:= tmp;
              If Not Count[j] then {不在队列中则进入队列}
                Begin
                  Count[j]:= True;
                  Inc(tail);
                  If (tail > MaxNode) then tail:= 1; {队列循环}
                  Sta[tail]:= j;
                End;
            End;
        End;
      Count[Sta[head]]:= False; {队首元素出队}
      If (head = tail) then Break; {队列空则循环结束}
      {队列循环}
      Inc(head);
      If (head > MaxNode) then head:= 1;
    Until False;
  End;

Procedure Print;
  Var
    i, j, tot, min: Longint;
  Begin
    min:= 30000; {最短路长最小值设置最大}
    tot:= 0;
    For i:= 0 to 10000 do {费用i不断增大}
      Begin
        j:= i Shl 7 + t;
        If (Dis[j] < min) then {当前的最短路长比最短路长最小值小，则方案是双调路径}
          Begin
            min:= Dis[j]; {更新最短路长最小值}
            Inc(tot); {更新双调路径总数}
          End;
      End;
    Assign(Output, Fou);
    Rewrite(Output);
    Writeln(tot);
    Close(Output);
  End;

Begin
  Init;
  Main;
  Print;
End.