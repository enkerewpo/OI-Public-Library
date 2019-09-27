Program Pro_1_2;				  {用“动态规划”的方法解决例1}

Const
  Max           =300;				  {最多的城市数}
  Inputfile     ='Input.Txt';			  {输入文件名}
  Outputfile    ='Output.Txt';			  {输出文件名}
  Big           =1000000;			  {最大整数}

Type
  Maps          =Array[1..Max] Of Integer;   	  {地图类型说明}

Var
   Se           :Set Of Byte;			  {未访问过的城市集合}
   Map          :Array[1..Max] Of ^maps;	  {地图变量}
   Dis          :Array[1..Max] Of Longint;	  {某城市到终点城市的最短距离}
   Fr           :Array[1..Max] Of Byte;		  {动态规划的标识数组}
   Bo           :Array[1..Max] Of Boolean;	  {访问过城市标识}
   N,M          :Integer;			  {输入数据}
   F            :Text; 				  {文件变量}

 Procedure Init;				  {初始化过程}
 Var
   I,J,K,W      :Integer;
  Begin
     Assign(F,Inputfile);			  {读入数据}
     Reset(F);
        Readln(F,N,M);
         For I:=1 To N Do
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

 Procedure Main;				    {动态规划递推过程}
   Var
     I,J,Who    :Integer;
     Min        :Longint;			    {当前最小值}

    Begin
       Dis[N]:=0;			  	    {初始化动态规划数组}
       Who:=N;
       Fillchar(Fr,Sizeof(Fr),0);
       Fillchar(Bo,Sizeof(Bo),True);
       Bo[N]:=False;
       While Who<>1 Do
        Begin
          For I:=1 To N Do			     {利用“状态转移方程”递推结果}
           If Map[I]^[Who]>0 Then
            If (Fr[I]=0) Or (Dis[I]>Dis[Who]+Map[I]^[Who]) Then
              Begin
                Dis[I]:=Dis[Who]+Map[I]^[Who];
                Fr[I]:=Who;
              End;
           Min:=Big;
           For I:=1 To N Do
            If Bo[I] And (Fr[I]>0) And (Dis[I]<Min) Then
             Begin
                Who:=I;
                Min:=Dis[I];
             End;
           Bo[Who]:=False;
        End;
    End;

  Procedure Print;				     {输出结果}
  Var
   I            :Integer;
   Begin
     Assign(F,Outputfile);
     Rewrite(F);
       Writeln(F,Dis[1]);
       I:=1;
       While I<>N Do
       Begin
          Write(F,I,' ');
          I:=Fr[I];
       End;
       Writeln(F,N);
    Close(F);
   End;

Begin
    Init;		{输入}
    Main;		{求解}
    Print;		{输出}
End.
