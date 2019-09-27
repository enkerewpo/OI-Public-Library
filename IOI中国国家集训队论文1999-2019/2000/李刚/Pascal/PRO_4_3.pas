Program Pro_4_3;				    {例4改进后的搜索算法}
Const
 Map:Array['A'..'G','A'..'G'] Of Byte=		    {每两个农场的距离}
      ((0,56,43,71,35,41,36),
       (56,0,54,58,36,79,31),
       (43,54,0,30,20,31,58),
       (71,58,30,0,38,59,75),
       (35,36,20,38,0,44,67),
       (41,79,31,59,44,0,72),
       (36,31,58,75,67,72,0));

 Inputfile         ='Input.Txt';		    {输入文件名}
 Outputfile        ='Output.Txt';		    {输出文件名}

Type
  Kus              =Array[0..4095] Of Word;	    {记录数组类型}
  Ses              =Set Of 1..12;		    {集合类型}

Var
  F                :Text;			    {文件变量}
  N                :Integer;			    {任务的数目}
  Min		   :Word;			    {最短路径的长度}
  Big,I            :Word;		   	    {应用变量}
  Wu               :Array[0..12,1..2] Of Char;	    {记录任务的数组}
  Dis              :Array[0..12,0..12] Of Integer;  {记录每两个任务的连接权值}
  Ku               :Array[1..12] Of ^kus;	    {记录最优权值的数组}
  Qiu              :Array[1..13] Of Byte;	    {搜索中记录路径的数组}
  Se               :Ses;

 Procedure Init;				    {初始化过程}
 Var
   I               :Integer;
   Ch              :Char;
  Begin
    Assign(F,Inputfile);
    Reset(F);
       Readln(F,N);
       For I:=1 To N Do				    {读入数据}
       Readln(F,Wu[I,1],Ch,Wu[I,2]);
    Close(F);
  End;

 Procedure Prepare;				   {准备过程}
  Var
    I,J             :Integer;
    Begin
      Wu[0,1]:='A';Wu[0,2]:='A';		   {求出每两个任务的连接权值}
      For I:=0 To N Do
        For J:=0 To N Do
          Dis[I,J]:=Map[Wu[I,2],Wu[J,1]];

         For I:=1 To N Do			   {初始化记录数组}
           Begin
             New(Ku[I]);
             Fillchar(Ku[I]^,Sizeof(Ku[I]^),$ff);
           End;
         Big:=Ku[1]^[1];
    End;

  Function Num(S:Ses):Word;			    {将集合转化为整数的函数}
    Var
         X         :Word Absolute S;
      Begin  
         Num:=X Div 2;
      End;

  Procedure Search(Dep:Byte;Al:Word);		     {搜索过程}
     Var
        I             :Byte;
        D             :Word;
    Begin
      If Al>=Min Then Exit;
      If Ku[Qiu[Dep-1]]^[Num(Se)]<Big Then
        Begin					     {如果已经做过此工作,则直接读值}
          If Al+Ku[Qiu[Dep-1]]^[Num(Se)]<Min Then
             Min:=Al+Ku[Qiu[Dep-1]]^[Num(Se)];
        End
      Else
        If Dep>N Then
            Begin				     {边界时直接计算}
               Ku[Qiu[Dep-1]]^[Num(Se)]:=Dis[Qiu[Dep-1],0];
               If Al+Ku[Qiu[Dep-1]]^[Num(Se)]<Min Then
                    Min:=Al+Ku[Qiu[Dep-1]]^[Num(Se)];
            End
       Else
          Begin
            D:=Big;				     {搜索每个位访问点}
            For I:=1 To N Do
             If I In Se Then
               Begin
                 Exclude(Se,I);
                 Qiu[Dep]:=I;
                 Search(Dep+1,Al+Dis[Qiu[Dep-1],Qiu[Dep]]);
                 If Ku[I]^[Num(Se)]+Dis[Qiu[Dep-1],Qiu[Dep]]<D Then
                 D:=Ku[I]^[Num(Se)]+Dis[Qiu[Dep-1],Qiu[Dep]];  {记录工作结果}
                 Include(Se,I);
               End;
            Ku[Qiu[Dep-1]]^[Num(Se)]:=D;
          End;
    End;

  Procedure Print;				      {输出结果}
  Var
    I,J,Last          :Integer;
    D                 :Word;
   Begin
     Se:=[1..N];
     J:=1;
     While  Dis[0,J]+Ku[J]^[Num(Se-[J])]<>Min Do
       Inc(J);
    D:=Min;
     For I:=1 To N Do
       Inc(D,Map[Wu[I,1],Wu[I,2]]);
     Assign(F,Outputfile);
     Rewrite(F);
        Writeln(F,D);
        Write(F,'A ');
        Dec(Min,Dis[0,J]);
        Last:=0;

       For I:=1 To N Do
         Begin
            If Wu[J,1]<>Wu[Last,2] Then
               Write(F,Wu[J,1],' ');
            Write(F,Wu[J,2],' ');
            If I<>N Then
              Begin
                Last:=J;
                Exclude(Se,J);
                J:=1;
                While (Not (J In Se)) Or (Ku[J]^[Num(Se-[J])]+Dis[Last,J]<>Min) Do
                       Inc(J);
                Dec(Min,Dis[Last,J]);
              End;
          End;
        If Wu[J,2]<>'A' Then Write(F,'A');
     Close(F);
   End;

Begin
 Init;		{输入}
 Prepare;	{准备}
 Se:=[1..N];	{初始化搜索中应用的各项值}
 Min:=Big;
  For I:=1 To N Do
    Begin
      Se:=[1..N]-[I];
      Qiu[1]:=I;
      Search(2,Dis[0,I]);	{搜索}
    End;
  Print;        {输出}
End.

