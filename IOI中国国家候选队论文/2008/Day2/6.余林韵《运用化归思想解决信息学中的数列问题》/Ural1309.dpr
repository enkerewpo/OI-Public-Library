{
http://acm.timus.ru/forum/thread.aspx?space=1&num=1309&id=12571
There *is* a period of 9973, but not for the given function.

Let's denote 9973 as M.

//////////////////////////////////////////////////////////////////////////
//In short////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////

1. g(n) is linear by f(n - 1), and g(x, y) = g(x mod M, y), which means we can find such A and B (in O(M)) that f(x + M) = (A * f(x) + B) mod M.

2. Having found such A and B, it's easy to show that for p > 0, f(p * M) = B * (A^(p-1) + A^(p-2) + .. + A^2 + A + 1) mod M.
I'm not sure if the last sum can be calculated in O(1), but it surely can be found in O(M).

3. So, we calc A and B, read N, find f(N - N % M) and then iterate till N in O(M), resulting with overall O(M).


//////////////////////////////////////////////////////////////////////////
//In detail///////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////

//////
//1.//
//////

Let's assume we know f(i) and wish to find f(i+1).
Easy to see, g(x, y) = g(x mod M, y). This is why,

f(i + 1) = g(i + 1, f(i)) = g((i + 1) mod M, f(i)).

Let's denote (i + 1) mod M as j.

f(i + 1) = g(j, f(i)) = ((f(i) - 1) * j^5 + j^3 ¨C j * f(i) + 3 * j + 7 * f(i)) mod M

f(i + 1) = f(i) * (j^5 - j + 7) + (-j^5 + j^3 + 3 * j) mod M

f(i + 1) = f(i) * ((j^5 - j + 7) mod M) + (-j^5 + j^3 + 3 * j) mod M

Remembering that j = (i + 1) mod M, let us denote

U(i) = (j^5 - j + 7) mod M,
V(i) = (-j^5 + j^3 + 3 * j) mod M.

As a result:

f(i + 1) = U(i) * f(i) + V(i)

Note that for any i, we calculate U(i) and V(i) in O(1) time.
Also note that U(i) = U(i mod M) and V(i) = V(i mod M):

f(i + 1) = U(i mod M) * f(i) + V(i mod M)

Let's consider some certain x, and let's denote f(x) as X.

f(x+0) == X == 1 * X + 0 == (a0 * X + b0) (mod M)
f(x+1) == U(0) * f(x+0) + V(0) == (a1 * X + b1) (mod M)
f(x+2) == U(1) * f(x+1) + V(1) == (U(1) * a1) * X + (U(1) * b1 + V(1)) == (a2 * X + b2) (mod M)
f(x+3) == U(2) * f(x+2) + V(2) == (U(2) * a2) * X + (U(2) * b2 + V(2)) == (a3 * X + b3) (mod M)
f(x+4) == U(3) * f(x+3) + V(3) == (U(3) * a3) * X + (U(3) * b3 + V(3)) == (a4 * X + b4) (mod M)
...
f(x+M) == (aM * X + bM)) (mod M)

Note that aM and bM do not depend on x - this is the key point!

Let's denote aM as A and bM as B. Each iteration above needs O(1) time, so we found A and B in O(M), such that for any x,

f(x+M) = (A * f(x) + B) mod M

//////
//2.//
//////

Consider the following sequence

f(0 * M) == 0 (mod M)
f(1 * M) == A * f(0 * M) + B == B (mod M)
f(2 * M) == A * f(1 * M) + B == A * B + B == B * (A + 1) (mod M)
f(3 * M) == A * f(2 * M) + B == A * B * (A + 1) + B == B * (A^2 + A + 1) (mod M)
...
f(p * M) == B * (A^(p-1) + A^(p-2) + .. + 1) (mod M)

Function A^p mod M is periodic by p with period being divisor of M, so we can easily calculate f(p * M) in O(M) time by summing up first M items of the sequence above.

Moreover, for this particular problem p (see below) is very small - less than N/M, so we may calculate this sum explicitly.

//////
//3.//
//////

The most pleasant part. Given N, we set p to N / M, and calculate f(p * M) with the method desribed above. N - p * M < M, so all we have to do left is explicitly apply the initial formula N - p * M times to find f(N).
}
{
	1876604	07:08:50	19 Nov 2007	ScaleRhyme	1309	Pascal	Accepted	0.015	291 KB
}
{$IFDEF ONLINE_JUDGE}
{$I-,R-,D-,Q-,S-}
{$MODE DELPHI}
{$ENDIF}
Program ScaleRhyme_Ural1309;
Const
	Inpath = 'ural.in' ;
	Outpath = 'ural.out' ;
	ModNum = 9973 ;
Type
	TIndex = Longint ;
Var
	N,Ans:TIndex;
	U,V:Array [1..ModNum] Of TIndex;
	A,B:Array [0..ModNum] Of TIndex;
	Procedure Init;
	Begin
		ReadLn(N);
	End;
	Procedure Main;
	Var
		I:TIndex;
	Begin
		Init;
		For I := 1 To ModNum Do
		Begin
			U[I] := (I * I Mod ModNum * I Mod ModNum * I Mod ModNum * I Mod ModNum - I + 7 + ModNum) Mod ModNum ;
			V[I] := (I * I Mod ModNum * I Mod ModNum - I * I Mod ModNum * I Mod ModNum * I Mod ModNum * I Mod ModNum + 3 * I Mod ModNum + ModNum) Mod ModNum ;
		End;
		A[0] := 1 ;
		B[0] := 0 ;
		For I := 1 To ModNum Do
		Begin
			A[I] := U[I] * A[I - 1] Mod ModNum ;
			B[I] := (U[I] * B[I - 1] Mod ModNum + V[I]) Mod ModNum ;
		End;
		Ans := 0 ;
		For I := 1 To N Div ModNum Do
			Ans := (Ans * A[ModNum] + B[ModNum]) Mod ModNum ;
		N := N Mod ModNum ;
		Ans := (Ans * A[N] + B[N]) Mod ModNum ;
		WriteLn(Ans);
	End;
Begin
	{$IFNDEF ONLINE_JUDGE}
	Assign(Input,Inpath);
	Reset(Input);
	Assign(Output,Outpath);
	Rewrite(Output);
	{$ENDIF}
	Main;
	{$IFNDEF ONLINE_JUDGE}
	Close(Input);
	Close(Output);
	{$ENDIF}
End.