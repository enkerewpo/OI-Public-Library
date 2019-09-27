{高精度计算问题，这里给出的是算法3-3}

{$R-,S-,Q-}
{$M 65520,0,655360}

const
  Maxn          =9999;{N的最大值}
  MaxK          =99;{K的最大值}
  MaxValue      =10000;

  Maxkk         =(MaxK-1) div 4+1;

type
  TNum          =record{高精度类型}
                l      :Integer;
                x      :array[1..Maxkk+1] of Integer
  end;

var
  Save          :array[1..Maxn] of ^TNum;{保存计算过的信息}
  Split         :array[1..Maxn] of Integer;{保存合数的分解}
  Result,Org    :TNum;
  Time          :LongInt;
  n,m,k,kk      :Integer;
  Template      :Longint;

procedure InitSplit;{对合数进行分解}
  var
    i,j :Integer;
  begin
    FillChar(Split,Sizeof(Split),0);
    Split[1]:=1;
    for i:=2 to n do
      if Split[i]=0 then begin
        Split[i]:=1;
        j:=i+i;while j<=n do begin Split[j]:=i;Inc(j,i) end
      end
  end;

procedure Mul(var x:TNum;y:TNum);{x:=x*y}
  var
    i,j         :Integer;
    p,q,Tmp     :LongInt;
  begin
    Org:=x;FillChar(x,Sizeof(x),0);
    for i:=1 to y.l do begin
      p:=y.x[i];
      if p<>0 then begin
        Tmp:=0;
        for j:=i to i+Org.l-1 do begin
          Inc(Tmp,p*Org.x[j-i+1]);
          q:=x.x[j];
          Inc(q,Tmp);
          Tmp:=q div MaxValue;
          Dec(q,Tmp*MaxValue);
          x.x[j]:=q
        end;
        Inc(x.x[j+1],Tmp)
      end;
      if Org.l+i=kk+1 then Dec(Org.l)
    end;
    x.l:=y.l+Org.l;if x.x[x.l]=0 then Dec(x.l)
  end;

procedure Add(var x,y:TNum);{x:=x+y}
  var
    i   :Integer;
  begin
    if x.l<y.l then x.l:=y.l;
    for i:=1 to y.l do begin
      Inc(x.x[i],y.x[i]);
      if x.x[i]>=MaxValue then begin
        Dec(x.x[i],MaxValue);
        Inc(x.x[i+1])
      end
    end;
    while (i<=x.l) and (x.x[i]>=MaxValue) do begin
      Dec(x.x[i],MaxValue);
      Inc(i);
      Inc(x.x[i])
    end;
    if (x.x[x.l+1]=1) and (x.l<kk) then Inc(x.l)
  end;

procedure Power(var Res,x:TNum;m:Integer);{Res=x^m}
  begin
    if m=1 then Res:=x
           else begin
             Power(Res,x,m shr 1);
             Mul(Res,Res);
             if Odd(m) then Mul(Res,x)
           end
  end;

function IntToStr(x:LongInt):string;
  var
    Res :string;
  begin
    Str(x,Res);
    if x<10 then IntToStr:='000'+Res else
    if x<100 then IntToStr:='00'+Res else
    if x<1000 then IntToStr:='0'+Res else IntToStr:=Res
  end;

procedure Print;{输出}
  var
    i   :Byte;
    Res :string;
  begin
    Res:='';
    for i:=Result.l downto 1 do Res:=Res+IntToStr(Result.x[i]);
    while Length(Res)>k do Delete(Res,1,1);
    while Res[1]='0' do Delete(Res,1,1);
    Writeln(Res)
  end;

procedure Main;{计算主过程}
  var
    i           :Integer;
    x,y         :TNum;
    MustSave    :array[1..Maxn] of Boolean;
  begin
    FillChar(MustSave,Sizeof(MustSave),False);
    for i:=1 to n do
      if Split[i]<>1 then begin
        MustSave[Split[i]]:=True;
        MustSave[i div Split[i]]:=True
      end;
    FillChar(Result,Sizeof(Result),0);
    Result.l:=1;Result.x[1]:=1;{1^m}
    for i:=2 to n do begin
      if Split[i]=1 then begin
        y.l:=1;y.x[1]:=i;
        Power(x,y,m)
      end else begin
        x:=Save[Split[i]]^;
        Mul(x,Save[i div Split[i]]^)
      end;
      if MustSave[i] then begin
        New(Save[i]);
        Save[i]^:=x
      end;
      Add(Result,x)
    end
  end;

begin

  Write('Input n = ');Readln(n);
  Write('Input m = ');Readln(m);
  Write('Input k = ');Readln(k);
  kk:=(k-1) div 4+1;

  Time:=MemL[$40:$6C];
  InitSplit;
  Main;
  Time:=MemL[$40:$6C]-Time;

  Write('1^',m,'+2^',m,'+...+',n,'^',m,' = ...');
  Print;
  Writeln('Time Used = ',Time);

end.
