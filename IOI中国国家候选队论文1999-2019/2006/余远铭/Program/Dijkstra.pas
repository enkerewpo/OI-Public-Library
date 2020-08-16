Program Dijkstra;
Const
  Fin = 'input.in';
  Maxn = 10000;

Type
  Link = ^Node;
  Node = Record
           v, w: Longint;                           {顶点和费用}
           Next: Link;
         End;

Var
  Q,                                                {最短路估计值最小堆}
  Q_Pos,                                            {每个顶点在堆中的位置}
  Dist,                                             {最短路估计值}
  Fa: Array[1 .. Maxn]of Longint;                   {每个顶点的前趋顶点}
  Map: Array[1 .. Maxn]of Link;                     {用临接表记录的图}
  n, m, s, t, Q_Tot: Longint;

Procedure Init; {读入}
  Var
    i, a, b, c: Longint;
    p: Link;
  Begin
    Assign(Input, Fin);
    Reset(Input);
    Read(n, m, s, t);
    For i:= 1 to m do
      Begin
        Read(a, b, c);

        {将每条无向边拆成两条有向边插入}
        New(p);
        p^.v:= b; p^.w:= c;
        p^.Next:= Map[a];
        Map[a]:= p;

        New(p);
        p^.v:= a; p^.w:= c;
        p^.Next:= Map[b];
        Map[b]:= p;
      End;
    Close(Input);
  End;

Procedure Swap(i, j: Longint); {交换堆中的两个元素i,j}
  Var
    k: Longint;
  Begin
    k:= Q[i]; Q[i]:= Q[j]; Q[j]:= k;
    Q_Pos[Q[i]]:= i;
    Q_Pos[Q[j]]:= j;
  End;

Procedure Updata(i: Longint); {将顶点i上升到合适位置}
  Var
    j: Longint;
  Begin
    j:= i Shr 1;
    While (j >= 1) and (Dist[Q[j]] > Dist[Q[i]]) do
      Begin
        Swap(i, j);
        i:= j; j:= i Shr 1;
      End;
  End;

Procedure Relax(i, j, w: Longint); {松弛操作}
  Begin
    If w >= Dist[j] Then Exit;
    Dist[j]:= w;
    Fa[j]:= i;
    Updata(Q_Pos[j]);
  End;

Procedure Heapfy(i: Longint); {将顶点i下降到合适位置}
  Var
    j: Longint;
  Begin
    Repeat
      j:= i;
      {与左儿子比较}
      If (i Shl 1 <= Q_Tot) and (Dist[Q[i Shl 1]] < Dist[Q[i]])
        Then i:= i Shl 1;
      {与右儿子比较}
      If (i Shl 1 < Q_Tot) and (Dist[Q[i Shl 1 + 1]] < Dist[Q[i]])
        Then i:= i Shl 1 + 1;
      If i <> j then Swap(i, j);
    Until (i = j);
  End;

Procedure Main;
  Var
    i: Longint;
    p: Link;
  Begin
    {最短路估计值初始化}
    For i:= 1 to n do
      Begin
        Q[i]:= i;
        Q_Pos[i]:= i;
        Dist[i]:= $FFFFFF;
      End;
    Swap(1, s);    {将源点交换到堆顶}
    Q_Tot:= n;     {堆的总元素设为顶点总数n}
    Dist[s]:= 0;   

    {Dijkstra算法主过程}
    While Q_Tot > 1 do
      Begin
        i:= Q[1]; {取出堆顶元素}

        {删除取出的元素}
        Swap(1, Q_Tot);
        Dec(Q_Tot);

        Heapfy(1); {维护新堆}

        {对i连出的每条边进行松弛操作}
        p:= Map[i];
        While p <> Nil do
          Begin
            If (Q_Pos[p^.v] <= Q_Tot) then Relax(i, p^.v, Dist[i] + p^.w);
            p:= p^.Next;
          End;
      End;
  End;

Procedure Print(i: Longint); {递归输出最短路径方案}
  Begin
    If (i = s)
      Then Write(i)
      Else Begin
        Print(Fa[i]);
        Write('--->', i);
      End;
  End;

Begin
  Init;
  Main;
  If (Dist[t] < $FFFFFF) then
    Begin
      Print(t);
      Writeln;
      Writeln('Total Cost: ', Dist[t]);
    End
  Else
    Writeln('No solution');
End.