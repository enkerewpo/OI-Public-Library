{
ID:asiapea1
PROB:hamming
LANG:PASCAL
}
Var
 s:array[1..100,1..100]of boolean;
 num:array[1..100]of boolean;
 i,max,s1,t,j,n,b,d:integer;
Procedure print;
Var
 nums,t,ss:integer;
 i,j,k:integer;
Begin
 nums:=0;
 For I:= 1 to n do
  Begin
   ss:=0;
   For j:= 1 to b do
    Begin
     t:=1;
     For k:= 1 to b-j do
      t:=t*2;
     ss:=ss+t*ord(s[i,j]);
    End;
   Write(ss);
   If nums<>9
    Then If i=n
     Then Writeln
     Else Begin
     nums:=nums+1;
     Write(' ');
    End
    Else If i=n
     Then Writeln
     Else Begin
     nums:=0;
     Writeln;
    End;
  End;
End;
Procedure save;
Var
 i:integer;
Begin
 max:=max+1;
 For i:= 1 to b do
  s[max,i]:=num[i];
End;
Procedure panduan;
Var
 i,j,hcode:integer;
 bool:boolean;
Begin
 bool:=true;
 For i:=1 to max do
  Begin
   hcode:=0;
   For j:= 1 to b do
    If s[i,j]<>num[j]
     Then hcode:=hcode+1;
   If hcode<d
    Then bool:=false;
  End;
 If bool
  Then Save;
End;
Procedure search(weishu:integer);
Begin
 If weishu>b
  Then panduan
  Else Begin
   num[weishu]:=false;
   search(weishu+1);
   num[weishu]:=true;
   search(weishu+1);
  End;
End;
Begin
 Assign(input,'hamming.in');
 Reset(input);
 Assign(output,'hamming.out');
 Rewrite(output);
 Read(n);Read(b);Readln(d);
 max:=1;
 For I:= 1 to b do
  s[1,i]:=false;
 Search(1);
 Print;
 Close(input);
 Close(output);
End.