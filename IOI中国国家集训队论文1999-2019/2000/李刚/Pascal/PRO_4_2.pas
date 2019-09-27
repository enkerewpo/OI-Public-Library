Program Pro_4_2;					{例4的搜索算法}

Const
 Map:Array['A'..'G','A'..'G'] Of Byte=			{每两个农场之间的距离}	
     ((0,56,43,71,35,41,36),
      (56,0,54,58,36,79,31),
      (43,54,0,30,20,31,58),
      (71,58,30,0,38,59,75),
      (35,36,20,38,0,44,67),
      (41,79,31,59,44,0,72),
      (36,31,58,75,67,72,0));

 Inputfile        ='Input.Txt';				{输入文件名}
 Outputfile       ='Output.Txt';			{输出文件名}


Var
  F               :Text;				{文件变量}
  N               :Integer;				{任务的数目}
  Min             :Word;				{最短距离}
  Wu              :Array[0..12,1..2] Of Char;		{记录任务的数组}
  Dis             :Array[0..12,0..12] Of Integer;	{记录每两个任务的连接权值}
  Qiu,Pr          :Array[0..14] Of Byte;		{搜索中的记录数组}
  Se              :Set Of Byte;				{未完成的任务的集合}

 Procedure Init;					{初始化过程}
 Var
   I              :Integer;
   Ch             :Char;
  Begin
    Assign(F,Inputfile);
    Reset(F);
       Readln(F,N);					{读入数据}
       For I:=1 To N Do
       Readln(F,Wu[I,1],Ch,Wu[I,2]);
    Close(F);
  End;

 Procedure Prepare;					{准备过程}
  Var
    I,J            :Integer;
    Begin
      Wu[0,1]:='A';Wu[0,2]:='A';			{求出每两个任务的连接权值}
      For I:=0 To N Do			
        For J:=0 To N Do
          Dis[I,J]:=Map[Wu[I,2],Wu[J,1]];
    End;

 Procedure Search(Dep:Byte;Al:Word);			{搜索最优得路径}
 Var
    I              :Byte;
   Begin
     If Al>=Min Then Exit;
     If Dep=N+1 Then
       Begin
           If Dis[Qiu[N],0]+Al<Min Then
            Begin
             Min:=Dis[Qiu[N],0]+Al;			{如果更优,记录之}
             Pr:=Qiu;
           End;
       End
     Else
      For I:=1 To N Do					{访问每个未访问的农场}
        If I In Se Then
          Begin
            Qiu[Dep]:=I;
            Exclude(Se,I);
             Search(Dep+1,Al+Dis[Qiu[Dep-1],I]);
            Include(Se,I);
          End;
   End;

  Procedure Print;					{输出结果}
  Var
      I            :Byte;
   Begin
    For I:=1 To N Do
     Inc(Min,Map[Wu[I,1],Wu[I,2]]);
    Assign(F,Outputfile);
    Rewrite(F);
       Writeln(F,Min);
       Write(F,'A ');
       For I:=1 To N Do
         Begin
            If Wu[Pr[I-1],2]<>Wu[Pr[I],1] Then Write(F,Wu[Pr[I],1],' ');
            Write(F,Wu[Pr[I],2],' ');
         End;
       If 'A'<>Wu[Pr[N],2] Then Write(F,'A');
    Close(F);
   End;

Begin
 Init;         		{初始化}
 Prepare;		{准备}
 Se:=[1..12];		{初始化各项搜索应用值}
 Qiu[0]:=0;
 Min:=60000;
 Search(1,0);		{搜索}
 Print;			{输出}
End.
