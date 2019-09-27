{$Mode delphi}
Program ScaleRhyme_Count;
Const
	Inpath = 'count.in' ;
	Outpath = 'count.out' ;
	MaxSize = 52 ;
	MaxK = 5 ;
	ModNum = 65521 ;
	CoordinateX:Array [1..10] Of Longint = (1,1,2,1,2,3,1,2,3,4) ;
	CoordinateY:Array [1..10] Of Longint = (2,3,3,4,4,4,5,5,5,5) ;
Type
	TIndex = Longint ;
	TMatrix = Array [1..MaxSize,1..MaxSize] Of Int64;
	TList = Array [1..MaxK] Of TIndex ;
	TUsed = Array [1..MaxK] Of Boolean;
Var
	N:Int64;
	K:TIndex;
	Position:Array [1..MaxK,1..MaxK,1..MaxK,1..MaxK] Of TIndex;
	Ans:Array [1..MaxSize] Of TIndex;
		TotalNum:TIndex;
	Matrix,AnsMatrix:TMatrix;
	List,Turn,Tmp:TList;
	Used,Chosen:TUsed;
	CountList:Array [1..MaxK] Of TIndex;
	Edge:Array [1..MaxK,1..MaxK] Of Boolean;
	Belong:Array [1..(MaxK - 1) * MaxK Div 2 + 1,1..MaxK] Of TIndex;

	Procedure Init;
	Begin
		ReadLn(K,N);
	End;

	Function Max(A,B:TIndex):TIndex;
	Begin
		If A > B Then	Result := A
			Else	Result := B ;
	End;
	Procedure Choose(Steps,Count,MaxNum:TIndex);
	Var
		I,J,S:TIndex;
	Begin
		If Steps = MaxNum + 1 Then
		Begin
			For I := 1 To K - 1 Do
				Tmp[I] := List[I + 1] ;
			Tmp[K] := K + 1 ;
			For I := 1 To K - 1 Do
				If Chosen[Tmp[I]] Then
					Tmp[I] := K + 1 ;

			FillChar(Used,SizeOf(Used),False);
			S := 0 ;
			For I := 1 To K Do
			If Not Used[I] Then
			Begin
				Inc(S);
				For J := I To K Do
					If Tmp[J] = Tmp[I] Then
					Begin
						Turn[J] := S ;
						Used[J] := True ;
					End;
			End;

			Inc(Matrix[Position[List[2],List[3],List[4],List[5]]]
				[Position[Turn[2],Turn[3],Turn[4],Turn[5]]],Count);
		End
		Else
		Begin
			Chosen[Steps] := False ;
			Choose(Steps + 1,Count,MaxNum);
			Chosen[Steps] := True ;
			Choose(Steps + 1,Count * CountList[Steps],MaxNum);
		End;
	End;
	Procedure FindEdge(MaxNum:TIndex);
	Var
		I:TIndex;
	Begin
		FillChar(CountList,SizeOf(CountList),0);
		For I := 1 To K Do
			Inc(CountList[List[I]]);
		Chosen[1] := True ;
		Choose(2,CountList[List[1]],MaxNum);
		If CountList[1] > 1 Then
		Begin
			Chosen[1] := False ;
			Choose(2,1,MaxNum);
		End;
	End;
	Procedure DFS(Kind,Steps,MaxNum:TIndex);
	Var
		I,J,Count,L:TIndex;
	Begin
		For I := 1 To MaxNum + 1 Do
		Begin
			List[Steps] := I ;
			If Steps = K Then
			Begin
				If Kind = 1 Then
				Begin
					Inc(TotalNum);
					Position[List[2],List[3],List[4],List[5]] := TotalNum ;
					{WriteLn(TotalNum);
					Write('	');
					For L := 1 To K Do
						Write(List[L],' ');
					WriteLn;}
				End
				Else	//Kind = 2 
					FindEdge(Max(I,MaxNum));
			End
			Else
				DFS(Kind,Steps + 1,Max(I,MaxNum));
		End;
	End;

	Function FindFa(X,Y:TIndex):TIndex;
	Begin
		If Belong[X][Y] = 0 Then	Result := Y
		Else
		Begin
			Result := FindFa(X,Belong[X][Y]);
			Belong[X][Y] := Result ;
		End;
	End;
	Procedure GetAns(Steps:TIndex);
	Var
		I,J,S:TIndex;
	Begin
		If Steps = (K - 1) * K Div 2 + 1 Then
		Begin
			For I := 1 To K Do
				Tmp[I] := FindFa(Steps,I) ;

			FillChar(Used,SizeOf(Used),False);
			S := 0 ;
			For I := 1 To K Do
			If Not Used[I] Then
			Begin
				Inc(S);
				For J := I To K Do
					If Tmp[J] = Tmp[I] Then
					Begin
						Turn[J] := S ;
						Used[J] := True ;
					End;
			End;

			Inc(Ans[Position[Turn[2],Turn[3],Turn[4],Turn[5]]]);

			Exit;
		End;
		Belong[Steps + 1] := Belong[Steps] ;
		GetAns(Steps + 1);
		If FindFa(Steps,CoordinateX[Steps]) <> FindFa(Steps,CoordinateY[Steps]) Then
		Begin
			Belong[Steps + 1][FindFa(Steps,CoordinateY[Steps])] := FindFa(Steps,CoordinateX[Steps]) ;
			GetAns(Steps + 1);
		End;
	End;

	Function MatrixMulty(A,B:TMatrix):TMatrix;
	Var
		I,J,K:TIndex;
	Begin
		FillChar(Result,SizeOf(Result),0);
		For I := 1 To TotalNum Do
			For J := 1 To TotalNum Do
				For K := 1 To TotalNum Do
					Result[I][J] := (Result[I][J] + A[I][K] * B[K][J]) Mod ModNum ;
	End;

	Procedure Main;
	Var
		I,J:TIndex;
		Final:Int64;
	Begin
		Init;
		If K >= N Then	//Print N ^ (N - 2)
		Begin
			Case N Of
				2:WriteLn(1);
				3:WriteLn(3);
				4:WriteLn(16);
				5:WriteLn(125);
			End;
			Exit;
		End;

		For I := 1 To MaxK Do
			List[I] := 1 ;
		For I := 1 To MaxK Do
			Turn[I] := 1 ;
		TotalNum := 0 ;
		DFS(1,2,1);
		DFS(2,2,1);
		{WriteLn(TotalNum);
		For J := 1 To TotalNum Do
		Begin
			For I := 1 To TotalNum Do
				Write(Matrix[I][J],' ');
			WriteLn;
		End;}

		Dec(N,K);
		For I := 1 To TotalNum Do
			AnsMatrix[I][I] := 1 ;
		While N > 0 Do
		Begin
			If Odd(N) Then
				AnsMatrix := MatrixMulty(AnsMatrix,Matrix) ;
			Matrix := MatrixMulty(Matrix,Matrix) ;
			N := N Div 2 ;
		End;

		FillChar(Edge,SizeOf(Edge),False);
		FillChar(Belong,SizeOf(Belong),0);
		GetAns(1);

		Final := 0 ;
		For I := 1 To TotalNum Do
			Final := (Final + Ans[I] * AnsMatrix[I][1]) Mod ModNum ;
		{For I := 1 To TotalNum Do
			WriteLn(Ans[I],' ',AnsMatrix[I][1]);}
		
		WriteLn(Final);
	End;
Begin
	Assign(Input,Inpath);
	Reset(Input);
	Assign(Output,Outpath);
	Rewrite(Output);
	Main;
	Close(Input);
	Close(Output);
End.