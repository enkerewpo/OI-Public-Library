Program Pro_3_2;				      {例3的搜索解法}
Const
  Inputfile	='input.Txt';			      {输入文件名}
  Outputfile	='output.Txt';			      {输出文件名}
  Max		=100;				      {最多点的数目}
  Big		=10000;				      {最大整数值}

Var
  F		:Text;				       {文件变量}
  Po		:Array[1..Max,1..2] Of Integer;	       {记录各个点的坐标}
  Qiu,Pr	:Array[1..Max] Of Byte;		       {记录搜索过程的数组}
  Lpr		:Integer;			       {打印数组的长度}
  N		:Integer;			       {点的数目}
  Min		:Real;				       {最短路径的长度}
	
 Procedure Init;				       {初始化过程}
 Var
   I		:Integer;
   Begin
     Assign(F,Inputfile);
     Reset(F);					        {读入数据}
       Readln(F,N);
        For I:=1 To N Do
         Readln(F,Po[I,1],Po[I,2]);
     Close(F);
   End;

 Function Len(P1,P2:Integer):Real;		        {求两点之间距离的函数}
   Begin
     Len:=Sqrt(Sqr(Po[P1,1]-Po[P2,1])+Sqr(Po[P1,2]-Po[P2,2]));
   End;

 Procedure Search(Dep,Fr,Last:Byte;Al:Real);		{搜索最短路径}
   Var
     I,P:Byte;
     Rs:Real;
       Procedure Did;					{将第2条路径的长度加入当前的长度}
       Var
        K:Byte;
         Begin
            K:=Fr+1;
            Rs:=0;
            P:=Last;
            While K<>I Do
              Begin
                Rs:=Rs+Len(P,K);
                P:=K;
                Inc(K);
              End;
           Rs:=Rs+Len(Fr,I);
         End;
    Begin
       If Al>=Min Then Exit;
       If Fr=N Then
         Begin
            If Al+Len(Last,N)<Min Then			{如果更优，记录}
             Begin
               Min:=Al+Len(Last,N);
               Pr:=Qiu;
               Lpr:=Dep-1;
             End;
         End
       Else
        For I:=Fr+1 To N Do				{访问每一个点}
          Begin
            Qiu[Dep]:=I;
            Did;
            Search(Dep+1,I,P,Al+Rs);
          End
    End;


 Procedure Print;					{输出数据}
  Var
   I			:Byte;	
   Se			:Set Of Byte;			{记录未输出的点}
   Begin
      Assign(F,Outputfile);
      Rewrite(F);
        Writeln(F,Min:0:2);
        Se:=[1..N];
        For I:=1 To Lpr Do
          Begin
             Write(F,Pr[I],' ');
             Se:=Se-[Pr[I]];
          End;
        Se:=Se+[1,N];
        Writeln(F);
        For I:=1 To N Do
          If I In Se Then
             Write(F,I,' ');
     Close(F);
   End;
Begin
  Init;			{输入数据}
  Min:=Big;		{最小值初始化}
  Search(1,1,1,0);	{搜索最短路径}
  Print;		{输出结果}
End.
