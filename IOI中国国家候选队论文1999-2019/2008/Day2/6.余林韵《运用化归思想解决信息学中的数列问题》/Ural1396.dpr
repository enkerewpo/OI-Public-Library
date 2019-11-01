{$IFDEF ONLINE_JUDGE}
{$I-,R-,D-,Q-,S-}
{$MODE DELPHI}
{$ENDIF}
{
	1754550	18:28:08	4 Sep 2007	Scale Rhyme	1396	Pascal	Wrong answer	1	0.093	208 KB
	1754567	18:39:12	4 Sep 2007	Scale Rhyme	1396	Pascal	Accepted	0.078	208 KB
}
Program ScaleRhyme_Ural1396;
Const
	Inpath = 'ural.in' ;
	Outpath = 'ural.out' ;
	Precision = 1E-10 ;
Type
	TIndex = Longint ;
	TData = Extended ;
	TMem = Record
		A,B:TData;
	End;
Var
	N:TData;
	F:Array [1..63] Of TMem;
	Procedure Init;
	Var
		I:TIndex;
	Begin
		F[1].A := 1 ;
		F[1].B := 0 ;
		F[2].A := 0 ;
		F[2].B := 1 ;
		For I := 3 To 63 Do
		Begin
			F[I].A := F[I - 1].A + F[I - 2].A ;
			F[I].B := F[I - 1].B + F[I - 2].B ;
		End;
	End;
	Function Max(A,B:TData):TData;
	Begin
		If A > B Then	Result := A
			Else	Result := B ;
	End;
	Function Ans(Left,Right:TData;Count:TIndex;LeftValue,RightValue:TData):TData;
	Var
		Mid,MidValue:TData;
	Begin
		Mid := (Left + Right)/2 ;
		MidValue := LeftValue + RightValue ;
		If Mid - Precision <= N + 1 Then
		Begin
			If Abs(Count - 1) < Precision Then
				Result := LeftValue
			Else
				If LeftValue < MidValue Then
					Result := LeftValue * F[Count + 1].A + MidValue * F[Count + 1].B
			Else
				Result := MidValue * F[Count + 1].A + LeftValue * F[Count + 1].B ;
			If N >= Mid - Precision Then
				Result := Max(Result,Ans(Mid,Right,Count - 1,MidValue,RightValue)) ;
		End
		Else
			Result := Ans(Left,Mid,Count - 1,LeftValue,MidValue) ;
	End;
	Procedure Main;
	Var
		Left,Right:TData;
		Count:TIndex;
	Begin
		ReadLn(N);
		Repeat
			Left := 1 ;
			Count := 0 ;
			While Left * 2 <= N Do
			Begin
				Left := Left * 2 ;
				Count := Count + 1 ;
			End;
			Right := Left * 2 ;
			WriteLn(Max(F[Count + 1].A + F[Count + 1].B,Ans(Left,Right,Count,1,1)):0:0);
			ReadLn(N);
		Until N = 0 ;
	End;
Begin
	{$IFNDEF ONLINE_JUDGE}
	Assign(Input,Inpath);
	Reset(Input);
	Assign(Output,Outpath);
	Rewrite(Output);
	{$ENDIF}
	Init;
	Main;
	{$IFNDEF ONLINE_JUDGE}
	Close(Input);
	Close(Output);
	{$ENDIF}
End.