Program Pro_4_1;				       {例4的动态规划算法}
Const
 Map:Array['A'..'G','A'..'G'] Of Byte=		       {每两个农场之间的距离}
    ((0,56,43,71,35,41,36),
     (56,0,54,58,36,79,31),
     (43,54,0,30,20,31,58),
     (71,58,30,0,38,59,75),
     (35,36,20,38,0,44,67),
     (41,79,31,59,44,0,72),
     (36,31,58,75,67,72,0));

 Inputfile           ='Input.Txt';			{输入文件名}
 Outputfile          ='Output.Txt';			{输出文件名}

Type
  Kus                =Array[0..4095] Of Word;		{权值数组类型说明}
  Dirs               =Array[0..4095] Of Byte;		{标记数组类型说明}
  Ses                =Set Of 1..12;			{集合类型}

Var
  F                 :Text;				{文件变量}
  N                 :Integer;				{任务数目}
  Wu                :Array[0..12,1..2] Of Char;		{记录任务的数组}
  Dis               :Array[0..12,0..12] Of Integer;	{每两个任务的连接费用}
  Ku                :Array[1..12] Of ^kus;		{动态规划中记录权值的数组}
  Dir               :Array[1..12] Of ^dirs;		{动态规划的标记数组}

 Procedure Init;					{初始化过程}
 Var
   I                :Integer;
   Ch               :Char;
  Begin
    Assign(F,Inputfile);
    Reset(F);
       Readln(F,N);
       For I:=1 To N Do					{读入数据}
          Readln(F,Wu[I,1],Ch,Wu[I,2]);
    Close(F);
  End;

 Procedure Prepare;					{准备过程}
  Var
    I,J             :Integer;
    Begin
      Wu[0,1]:='A';Wu[0,2]:='A';			{求出每两个任务的连接费用}
      For I:=0 To N Do
        For J:=0 To N Do
          Dis[I,J]:=Map[Wu[I,2],Wu[J,1]];
    End;

 Procedure Main;					{动态规划过程}
 Var
   Last,I,K,What    :Word;
   S                :Ses;

     Function Num(S:Ses):Word;				{将集合转化为整数的函数}
      Var
        X           :Word Absolute S;
        Begin
           Num:=X Div 2;
        End;

     Procedure Did(Dep,From:Byte;S:Ses);		{为动态规划中记录权值的数组赋值}     
       Var
        I           :Byte;
       Begin
         If Dep>K Then
           Begin
             For I:=1 To N Do
              If (I In S) And (Ku[I]^[Num(S-[I])]+Dis[What,I]<Ku[What]^[Num(S)]) Then
                Begin      				{如果更小，改变现有权值与表示变量}
                  Ku[What]^[Num(S)]:=Ku[I]^[Num(S-[I])]+Dis[What,I];
                  Dir[What]^[Num(S)]:=I;
                End;
           End
         Else
           For I:=From+1 To N Do
             If I<>What Then
                Did(Dep+1,I,S+[I]);
       End;

  Begin
    For I:=1 To N Do					{初始化动态规划记录数组}
      Begin
        New(Ku[I]);
        New(Dir[I]);
        Fillchar(Ku[I]^,Sizeof(Ku[I]^),$ff);
      End;
    For I:=1 To N Do
        Ku[I]^[0]:=Dis[I,0];

    For K:=1 To N-1 Do					{为动态规划数组赋值}
       For What:=1 To N Do
         Did(1,0,[]);

    S:=[1..N];
    K:=60000;
    For I:=1 To N Do
      If Dis[0,I]+Ku[I]^[Num(S-[I])]<K Then
        Begin
          K:=Dis[0,I]+Ku[I]^[Num(S-[I])];
          What:=I;
        End;
    For I:=1 To N Do
      Inc(K,Map[Wu[I,1],Wu[I,2]]);

   Assign(F,Outputfile);			       {输出结果}
   Rewrite(F);
     Writeln(F,K);
     Write(F,'A ');
     Last:=0;
     For I:=1 To N Do
       Begin
         If Wu[Last,2]<>Wu[What,1] Then Write(F,Wu[What,1],' ');
            Write(F,Wu[What,2],' ');
         Exclude(S,What);
         Last:=What;
         What:=Dir[What]^[Num(S)];
       End;
      If 'A'<>Wu[Last,2] Then Write(F,'A');
   Close(F);
  End;


Begin
 Init;		{初始化}
 Prepare;	{准备}
 Main;		{计算}
End.
