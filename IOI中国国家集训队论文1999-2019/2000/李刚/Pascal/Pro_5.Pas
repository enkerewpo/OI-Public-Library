Program Pro_5;					{例5的动态规划解法}

Const
  Datafile      ='Data.Txt';			{文本输入文件名}
  Inputfile     ='Input.Txt';			{基元输入文件名}
  Outputfile    ='Output.Txt';			{输出文件名}

Type
  Jis           =Record				{基元记录类型说明}
                   Lst:Byte;			{基元长度}
                   St:String[20];		{基元内容}
                 End;
Var
  F             :Text;				{文件变量}
  Ji            :Array[1..100] Of Jis;		{基元记录数组}
  Ch            :Array[0..21] Of Char;		{字符记录数组}
  Bo            :Array[0..21] Of Boolean;	{记录是否为前缀的数组}
  N             :Integer;			{基元数目}
  Tot           :Longint;			{总的字符数}
  Big           :Longint;			{最长的前缀长度}

  Procedure Init;				{初始化过程}
   Var
     I          :Integer;
    Begin
      Assign(F,Inputfile);
      Reset(F);
        Readln(F,N);				{读入每个基元}
        For I:=1 To N Do
          Begin
             Readln(F,Ji[I].Lst);
             Readln(F,Ji[I].St);
          End;
      Close(F);
    End;

 Procedure Main;				{求最长前缀的过程}
  Var
     I,J        :Integer;

     Procedure See;				{查看此位是否为前缀}
      Var
         I      :Byte;
         X,Y    :Integer;
       Begin
          Bo[J]:=False;
          For I:=1 To N Do
            Begin				{考察每个基元}
              X:=J;Y:=Ji[I].Lst;
              While (Y>0) And (Ji[I].St[Y]=Ch[X]) Do
                Begin
                   Dec(X);
                   Dec(Y);
                   If X<0 Then X:=21;
                End;
              If (Y=0) And (Bo[X]) Then
                Begin
                   Bo[J]:=True;
                   Exit;
                End;
            End;
       End;
  Begin
    Assign(F,Datafile);
    Reset(F);
    Big:=0;					{边读入边判定}
    Tot:=0;
    Bo[0]:=True;
    J:=0;
     While (Tot-Big<20) And (Ch[J]<>'.') Do	{如果超过20位不连续或读完文件,结束}
       Begin
         Inc(Tot);Inc(J);
         If J>21 Then J:=0;
         Readln(F,Ch[J]);
         If Ch[J]<>'.' Then
           Begin
             See;
             If Bo[J] Then Big:=Tot;
           End;
       End;
     Close(F);
  End;

 Procedure Print;				{输出数据}
  Begin
    Assign(F,Outputfile);
    Rewrite(F);
    Writeln(F,Big);
    Close(F);
  End;

Begin
  Init;		{输入}
  Main;		{动态规划求最长前缀}
  Print;	{输出}
End.
