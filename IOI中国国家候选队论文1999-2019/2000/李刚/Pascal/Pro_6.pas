Program  Pro_6;					     {例6的动态规划解法}
Const  Fin		  ='Input.txt';		     {输入文件名}
       Fou		  ='Output.txt';	     {输出文件名}
Type   Kus		  =Array[0..1160] Of Byte;   {记录数组的类型说明}
       Zis		  =Array[0..1160] Of Integer;
Var    Ku                 :Array[1..1000] Of ^kus;   {记录决策的数组}
       Shu,Shu1           :Array[1..1000] Of Byte;   
       Zi                 :Array[0..1] Of Zis;       {记录状态的数组}
       Use1               :Array[0..20,0..20,0..20] Of Integer; {记录三个数的组合的数组}
       Use2               :Array[0..1160,1..3] Of Byte;  {将一个数转化为三个数组合的数组}
       Total,I,M,N,P,N1   :Integer;
       F                  :Text;
       W1,W2,W3,W4        :Word;
 {--Init--}
 Procedure Init;    {初始化}
  Var I,J:Integer;
   Begin
     Assign(F,Fin);
     Reset(F);
      Readln(F,N1,M,P);
      For I:=1 To N1 Do
        Read(F,Shu1[I]);
     Shu[1]:=Shu1[1];
     N:=1;
     For I:=2 To N1 Do
      If Shu1[I]<>Shu1[I-1] Then
         Begin Inc(N);Shu[N]:=Shu1[I];End;
     Close(F);
   End;
 {---Diduse----}
 Procedure Diduse;      {将三个数组合的情况转化为一个序数与其对应}
 Var Qs    :Array[1..3] Of Byte;
     Stop  :Byte;
     I,J,K :Byte;
      {==Serch==}
   Procedure Serch(Depth,From:Byte);  {搜索所有的组合情况}
    Var I:Byte;
     Begin
      If Depth=Stop+1 Then
        Begin
         Inc(Total);
         Use2[Total,1]:=Qs[1];Use2[Total,2]:=Qs[2];
         Use2[Total,3]:=Qs[3];
         Use1[Qs[1],Qs[2],Qs[3]]:=Total;Use1[Qs[1],Qs[3],Qs[2]]:=Total;
         Use1[Qs[2],Qs[1],Qs[3]]:=Total;Use1[Qs[2],Qs[3],Qs[1]]:=Total;
         Use1[Qs[3],Qs[1],Qs[2]]:=Total;Use1[Qs[3],Qs[2],Qs[1]]:=Total;
        End
      Else
       For I:=From To M-1 Do
        Begin
          Qs[Depth]:=I;
          Serch(Depth+1,I+1);
        End;
     End;
  Begin  
    Total:=0;
    Fillchar(Qs,Sizeof(Qs),0);
    For I:=0 To M Do
      For J:=0 To M Do
        For K:=0 To M Do
          Use1[I,J,K]:=-1;
    Use2[0,1]:=0;Use2[0,2]:=0;Use2[0,3]:=0;
    Use1[0,0,0]:=0;
    For Stop:=1 To P-1 Do
       Serch(1,1);
  End;
 {-----Main-------}   {主过程}
 Procedure Main;
  Var I,J,K,W1,W2,W3   :Integer;
      Q                :Array[1..4] Of Byte;
  Begin
    For I:=1 To N Do
      Begin New(Ku[I]);End;
    Fillchar(Zi,Sizeof(Zi),0);  {动态规划初始化}
    Fillchar(Ku[1]^,Sizeof(Ku[1]^),0);
    Zi[0][0]:=1;
    Fillchar(Q,Sizeof(Q),0);
    For I:=2 To N Do     {动态规划求值}
     Begin
       For J:=0 To Total Do
         If Zi[0][J]<>0 Then
           Begin
             W1:=0;
             For K:=1 To 3 Do
                 Begin Q[K]:=Use2[J,K];
                       If Q[K]>=Shu[I-1] Then Inc(Q[K]);
                       If Q[K]=Shu[I] Then W1:=K;
                 End;{End For K}
             Q[4]:=Shu[I-1];
             If W1<>0 Then    
                Begin
                  W2:=Q[4];Q[4]:=Q[W1];Q[W1]:=W2;
                  For K:=1 To 3 Do
                      If Q[K]>Shu[I] Then Dec(Q[K]);
                  W3:=Use1[Q[1],Q[2],Q[3]];
                  If (Zi[1][W3]=0) Or (Zi[1][W3]>Zi[0][J]) Then
                      Begin
                        Zi[1][W3]:=Zi[0][J];
                        Ku[I]^[W3]:=Shu[I];
                      End;
                End {End If}
              Else
                Begin
                   For K:=1 To 4 Do
                    If Q[K]>Shu[I] Then Dec(Q[K]);
                  For K:=1 To 4 Do  {分四种情况决策}
                     Begin
                       Case K Of
                         1:W1:=Use1[Q[2],Q[3],Q[4]];
                         2:W1:=Use1[Q[1],Q[3],Q[4]];
                         3:W1:=Use1[Q[1],Q[2],Q[4]];
                         4:W1:=Use1[Q[1],Q[2],Q[3]];
                       End;
                     If W1<>-1 Then
                       If (Zi[1][W1]=0) Or (Zi[1][W1]>Zi[0][J]+1) Then
                          Begin
                            Zi[1][W1]:=Zi[0][J]+1;
                            W2:=Q[K];
                            If W2>=Shu[I] Then Inc(W2);
                            Ku[I]^[W1]:=W2;
                          End;{End If}
                       End;{End For K}
                 End;{End For Else};
           End;{End For J}
        Zi[0]:=Zi[1];
        Fillchar(Zi[1],Sizeof(Zi[1]),0);
     End;{End For I}
  End;
  {-----Print---}
 Procedure Print;  {打印结果}
  Var Pr,Pr1             :Array[1..1000] Of Integer;
      Now,Q              :Array[1..4] Of Byte;
      I,J,K,Ps,W1,W2     :Integer;
  Begin
    Ps:=1001;
     For J:=0 To Total Do
       If (Zi[0][J]<>0) And (Zi[0][J]<Ps) Then
           Begin Ps:=Zi[0][J];K:=J;End;
    Assign(F,Fou);
    Rewrite(F);
      Writeln(F,Ps);
      Now[2]:=Use2[K,1];
      Now[3]:=Use2[K,2];
      Now[4]:=Use2[K,3];
      For I:=2 To 4 Do
         If Now[I]>=Shu[N] Then Inc(Now[I]);
      Now[1]:=Shu[N];
      Pr[N]:=1;
      For K:=N-1 Downto 1 Do  {分阶段打印}
       Begin
         J:=1;
         While Now[J]<>Shu[K+1] Do
              Inc(J);
         W2:=0;
         For I:=1 To 4 Do
          If I<>J Then
           Begin
              Inc(W2);Q[W2]:=Now[I];
              If Q[W2]>=Shu[K+1] Then Dec(Q[W2]);
           End;
         W1:=Use1[Q[1],Q[2],Q[3]];
         Now[J]:=Ku[K+1]^[W1];
         For I:=1 To 4 Do
          If Now[I]=Shu[K] Then
           Pr[K]:=I;
       End;{End For K}
       J:=1;
       Pr1[1]:=Pr[1];
       For I:=2 To N1 Do
         Begin
           If Shu1[I]<>Shu1[I-1] Then Inc(J);
           Pr1[I]:=Pr[J];
         End;
     For I:=1 To N1 Do
       Write(F,Pr1[I],' ');
    Close(F);
  End;
 {Main} {主程序}
Begin
  Init;		{初始化}
  Diduse;	{准备}
  Main;		{动态规划过程}
  Print;	{输出}
End.
