Program Pro_1_1;                        	{用搜索算法解决例1的程序}

Const
  Max           =300;				{最多城市数}
  Inputfile     ='Input.Txt';			{输入文件}
  Outputfile    ='Output.Txt';			{输出文件}
  Big           =1000000;			{最大整数}

Type
  Maps          =Array [1..Max] Of Integer;	{地图类型说明}

Var
   Se           :Set Of Byte;			{一个记录还未访问过的城市的集合}
   Map          :Array[1..Max] Of ^maps;	{地图数组}
   Qiu,Pr       :Array[1..Max] Of Byte;		{最短路径的数组}
   F            :Text;				{文件变量}
   Lp		:Integer;			{最短路径的城市数}
   N,M       	:Integer;			{输入的数据}
   Min          :Longint;			{最短路径的长度}


 Procedure Init;				{初始化过程}
 Var
   I,J,K,W      :Integer;
  Begin
     Assign(F,Inputfile);
     Reset(F);
        Readln(F,N,M);
        For I:=1 To N Do			{读入数据}
          Begin
            New(Map[I]);
            Fillchar(Map[I]^,Sizeof(Map[I]^),0);
          End;
        For I:=1 To M Do
          Begin
            Readln(F,J,K,W);
            Map[J]^[K]:=W;
          End;
     Close(F);
  End;

 Procedure Search(Dep:Byte;Al:Longint);		{寻找最短路径}
 Var
   I            :Byte;
   Begin
     If Al>=Min Then Exit;			{砍枝条件}
     If Qiu[Dep-1]=N Then			{如果比当前还小，记录}
       Begin
         Min:=Al;
         Pr:=Qiu;
         Lp:=Dep-1;
       End
     Else
      For I:=2 To N Do				{访问所有没访问过的城市}
       If (I In Se) And (Map[Qiu[Dep-1]]^[I]>0) Then
        Begin
          Exclude(Se,I);
          Qiu[Dep]:=I;
             Search(Dep+1,Al+Map[Qiu[Dep-1]]^[Qiu[Dep]]);
          Include(Se,I);
        End;
   End;

 Procedure Print;				{输出数据}
 Var
   I            :Integer;
  Begin
    Assign(F,Outputfile);
    Rewrite(F);
      Writeln(F,Min);
      For I:=1 To Lp Do
        Write(F,Pr[I],' ');
    Close(F);
  End;

Begin
  Init;						{输入数据}
  Se:=[2..N];					{各项值初始化}
  Qiu[1]:=1;
  Min:=Big;
  Search(2,0);					{寻找最短路径}
  Print;					{输出}
End.
