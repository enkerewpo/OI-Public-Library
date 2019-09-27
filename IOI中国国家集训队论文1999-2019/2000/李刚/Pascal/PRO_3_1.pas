Program Pro_3_1;				{例3的动态规划解法}
Const
  Inputfile	='input.Txt';			{输入文件名}
  Outputfile	='output.Txt';			{输出文件名}
  Max		=100;				{最多点的数目}
  Big		=10000;				{最大整数值}

Var
  F		:Text;				{文件变量}
  Po		:Array[1..Max,1..2] Of Integer; {记录每个点坐标的数组}
  Dis		:Array[1..Max,1..Max] Of Real;	{记录动态规划中状态的权值}
  N		:Integer;			{点的总数}

 Procedure Init;				{初始化过程}
 Var
   I		:Integer;
   Begin
     Assign(F,Inputfile);			{读入数据}
     Reset(F);
       Readln(F,N);
        For I:=1 To N Do
         Readln(F,Po[I,1],Po[I,2]);
     Close(F);
   End;

 Function Len(P1,P2:Integer):Real;		{求两个点之间的距离}
   Begin
     Len:=Sqrt(Sqr(Po[P1,1]-Po[P2,1])+Sqr(Po[P1,2]-Po[P2,2]));
   End;

 Procedure Main;				{动态规划过程}
  Var
    I,J,K	:Integer;
    Now		:Real;				{当前最小值}
   Begin
      Dis[N,N]:=0;				{初始化动态规划数组}
      For I:=N-1 Downto 1 Do
        Begin
          Dis[I,N]:=Len(I,I+1)+Dis[I+1,N];
          Dis[N,I]:=Dis[I,N];
        End;

      For I:=N-2 Downto 1 Do			{递推最小值}
        For J:=N-1 Downto I+1 Do
        Begin
          If I+1<J Then Now:=Dis[I+1,J]+Len(I,I+1)
           Else
             Begin
               Now:=Big;
               For K:=J+1 To N Do
                If Dis[K,J]+Len(I,K)<Now Then
                  Now:=Dis[K,J]+Len(I,K);
             End;
          For K:=J+1 To N Do
            If Dis[I,K]+Len(J,K)<Now Then
                Now:=Dis[I,K]+Len(J,K);
          Dis[I,J]:=Now;
          Dis[J,I]:=Now;
        End;
   End;

 Procedure Print;					{输出过程}
   Var
      X1,X2,I,D		:Integer;			
      Now		:Real;				{当前最小值}
      P			:Array[1..2] Of Integer;	{打印数组的长度}
      Pr		:Array[1..2,1..Max] Of Byte;	{打印数组}
      Ok		:Boolean;

        Procedure Change;				{交换两个数的值}
        Var
          G		:Integer;
          Begin
             D:=3-D;
             G:=X1;X1:=X2;X2:=G;
          End;

    Begin
       Assign(F,Outputfile);
       Rewrite(F);					{输出数据}
       Now:=Big;
        For I:=2 To N Do				{求最短的路径值}
           If Dis[1,I]+Len(1,I)<Now Then
             Begin
               Now:=Dis[1,I]+Len(1,I);
               X2:=I;
             End;
        X1:=1;
        Writeln(F,Now:0:2);			
        P[1]:=1;P[2]:=1;				{打印数组初始化}
        Pr[1,1]:=X1;Pr[2,1]:=X2;
        D:=1;
        While (X1<>N) And (X2<>N) Do
           Begin
             Ok:=True;					{根据动态规划递推规则构造打印数组}
              If X1+1<X2 Then
                Begin
                  If Dis[X1+1,X2]+Len(X1,X1+1)=Dis[X1,X2] Then
                      Begin
                         Inc(X1);
                         Inc(P[D]);
                         Pr[D,P[D]]:=X1;
                         Ok:=False;
                      End;
                End
               Else
                Begin
                  I:=X2+1;
                  While (I<=N) And ( Dis[I,X2]+Len(X1,I)<>Dis[X1,X2]) Do
                         Inc(I);
                  If I<=N Then
                    Begin
                       Ok:=False;
                       X1:=I;
                       Inc(P[D]);
                       Pr[D,P[D]]:=X1;
                       Change;
                    End;
                End;
             If Ok Then
              Begin
                 I:=X2+1;
                 While Dis[X1,I]+Len(I,X2)<>Dis[X1,X2] Do
                       Inc(I);
                 X2:=I;
                 Inc(P[3-D]);
                 Pr[3-D,P[3-D]]:=X2;
              End;
           End;
        While Pr[D,P[D]]<>N Do
          Begin
             Inc(P[D]);
             Pr[D,P[D]]:=Pr[D,P[D]-1]+1;
          End;

       For I:=1 To P[1] Do		{输出打印数组}
            Write(F,Pr[1,I],' ');
       Writeln(F);
       For I:=1 To P[2] Do
            Write(F,Pr[2,I],' ');
       Close(F);
    End;

Begin
  Init;	    {初始化}
  Main;	    {动态规划递推最短路径}
  Print;    {输出结果}
End.
