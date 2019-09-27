{理想收入问题，包括算法2-1，2-2，2-3和2-4}

{$M 65520,0,655360}

const
  Fn            ='2.in';
  MaxM          =5000;{M的最大值}

var
  M             :Integer;{天数}
  V             :array[0..MaxM] of Extended;{股票价格}
  Result        :Extended;{答案}
  Time          :Longint;

procedure Create;{为了方便测试，生成随机数据}
  var
    i   :Integer;
    f   :Text;
  begin
    Randomize;
    Writeln('Create Random Data ');
    Write('Input M (1<=M<=',MaxM,') : ');Readln(M);
    Assign(f,Fn);ReWrite(f);
    Writeln(f,M);
    for i:=1 to M do Writeln(f,Random(M)+1.0*M*M*M*M:0:0);
    Close(f)
  end;

procedure GetInfo;{读入数据}
  var
    i   :Integer;
    f   :Text;
  begin
    Assign(f,Fn);Reset(f);
    Readln(f,M);
    for i:=1 to M do Readln(f,V[i]);
    Close(f)
  end;

function Max(x,y:Extended):Extended;
  begin
    if x>y then Max:=x else Max:=y
  end;

procedure Main1;{算法2-1}
  var
    F           :array[0..MaxM] of Extended;
    i,j,k       :Integer;
  begin
    F[0]:=1;V[0]:=1;
    Result:=1;
    for i:=1 to M do begin
      F[i]:=0;
      for j:=0 to i-1 do
        for k:=j to i-1 do
          F[i]:=Max(F[i],F[j]/V[k]*V[i]);
      if F[i]>Result then Result:=F[i]
    end
  end;

procedure Main2;{算法2-2}
  var
    F           :array[0..MaxM] of Extended;
    i,j         :Integer;
    MaxFV       :Extended;
  begin
    F[0]:=1;V[0]:=1;MaxFV:=1;
    Result:=1;
    for i:=1 to M do begin
      for j:=0 to i-1 do
        MaxFV:=Max(MaxFV,F[j]/V[i-1]);
      F[i]:=MaxFV*V[i];
      if F[i]>Result then Result:=F[i]
    end
  end;

procedure Main3;{算法2-3}
  var
    i                   :Integer;
    F,MaxF,MaxFV        :Extended;
  begin
    F:=1;MaxF:=1;MaxFV:=1;V[0]:=1;
    for i:=1 to M do begin
      if F>MaxF then MaxF:=F;
      if MaxF/V[i-1]>MaxFV then MaxFV:=MaxF/V[i-1];
      F:=MaxFV*V[i]
    end;
    Result:=Max(MaxF,F)
  end;

procedure Main4;{算法2-4}
  var
    i           :Integer;
  begin
    Result:=1;V[0]:=1;
    for i:=1 to M do
      if V[i]>V[i-1] then Result:=Result*V[i]/V[i-1];
  end;

procedure InitTimer;
  begin
    Time:=MemL[$40:$6C];
  end;

procedure DoneTimer;
  begin
    Writeln('   Time Used = ',MemL[$40:$6C]-Time)
  end;

begin

  Create;

  GetInfo;

  Writeln('Algorithm 1 : ');
  InitTimer;
  Main1;
  DoneTimer;
  Writeln('   Result = ',Result:0:1);

  Writeln('Algorithm 2 : ');
  InitTimer;
  Main2;
  DoneTimer;
  Writeln('   Result = ',Result:0:1);

  Writeln('Algorithm 3 : ');
  InitTimer;
  Main3;
  DoneTimer;
  Writeln('   Result = ',Result:0:1);

  Writeln('Algorithm 4 : ');
  InitTimer;
  Main4;
  DoneTimer;
  Writeln('   Result = ',Result:0:1);

end.
