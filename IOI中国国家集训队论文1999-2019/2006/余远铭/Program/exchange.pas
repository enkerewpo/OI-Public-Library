Program Ural1162_Currency_Exchange;
Const
  Fin='';//'Input.in';
  Maxn=100;

Type
  Link=^Node;
  Node=Record
         v:Integer; {顶点}
         rate,less:Double; {兑换比率和中转费用}
         Next:Link;
       End;

Var
  Map:Array[1..Maxn]of Link; {用邻接表存图}
  Dist:Array[1..Maxn]of Double; {最短路估计值}
  n,s:Integer; {顶点总数和源点}
  v:Double; {开始时拥有的货币数}

Procedure Init; {读入}
  Var i,j,k,m:Integer;
      p:Link;
  Begin
    Assign(Input,Fin);
    Reset(Input);
    Readln(n,m,s,v);
    New(p); p:=Nil;
    For i:=1 to n do Map[i]:=p;
    For k:=1 to m do
    Begin
      Read(i,j);
      New(p);
      Read(p^.rate,p^.less);
      p^.v:=j; p^.Next:=Map[i]; Map[i]:=p;
      New(p);
      Readln(p^.rate,p^.less);
      p^.v:=i; p^.Next:=Map[j]; Map[j]:=p;
    End;
  End;

Procedure Main; {用Bellman-Ford求最长路}
  Var i:Integer;
      Tt:Double;
      Quit:Boolean;
      p:Link;
  Begin
    For i:=1 to n do Dist[i]:=0; Dist[s]:=v;
    Repeat
      Quit:=True;
      For i:=1 to n do
      If Dist[i]>1e-8 Then {当前顶点由源点可达}
      Begin
        p:=Map[i];

        {对每条边进行松弛操作}
        While p<>Nil do
        Begin
          Tt:=(Dist[i]-p^.less)*p^.rate; {计算转移后可得到的货币数}
          If Tt>Dist[p^.v]+1e-8 Then
          Begin
            Dist[p^.v]:=Tt;
            Quit:=False; {记录该次循环有顶点的最短路估计值更新了}
          End;
          p:=p^.Next;
        End;
      End;
    Until Quit Or (Dist[s]>v+1e-8); {没有顶点可更新或已经得到比初始多的货币则退出}
    If Dist[s]>v+1e-8 Then Writeln('YES')
                      Else Writeln('NO');
  End;

Begin
  Init;
  Main;
End.