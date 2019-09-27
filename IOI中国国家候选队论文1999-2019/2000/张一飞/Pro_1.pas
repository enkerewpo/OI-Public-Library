{序关系计数问题，包括算法1-1，1-2和1-3}

const
  MaxN          =17;{为了避免高精度计算，N所能达到的最大值}

type
  TSet          =set of 1..MaxN;

var
  Total         :Comp;{答案}
  F             :array[0..MaxN] of Comp;{辅助数组}
  N             :Integer;
  Time          :Longint;

procedure Count1(Step,First:Integer;Can:TSet);
  {
  Step表示当前确定第Step个大写字母
  First表示当前大写字母可能取到的最小值
  Can是一个集合，集合中的元素是还可以使用的大写字母
  }
  var
    i           :Integer;
  begin
    if Step=N then begin{确定最后一个字母}
      for i:=First to N do if i in Can then Total:=Total+1; {Total为统计的结果}
      Exit
    end;
    for i:=First to N do{枚举当前的大写字母}
      if i in Can then begin{i可以使用}
        Count1(Step+1,i+1,Can-[i]);{添等于号}
        Count1(Step+1,1,Can-[i]){添小于号}
      end
  end;

procedure Main1;{算法1-1}
  begin
    Time:=-MemL[$40:$6C];
    Total:=0;
    Count1(1,1,[1..n]);
    Inc(Time,MemL[$40:$6C])
  end;

procedure Count2(Step,First:Integer;Can:TSet);
  {
  Step表示当前确定第Step个大写字母
  First表示当前大写字母可能取到的最小值
  Can是一个集合，集合中的元素是还可以使用的大写字母
  }
  var
    i           :Integer;
  begin
    if Step=N then begin{确定最后一个字母}
      for i:=First to N do if i in Can then Total:=Total+1; {Total为统计的结果}
      Exit
    end;
    for i:=First to N do{枚举当前的大写字母}
      if i in Can then begin{i可以使用}
        Count2(Step+1,i+1,Can-[i]);{添等于号}
        if F[N-Step]=-1 then begin
          F[N-Step]:=Total;
          Count2(Step+1,1,Can-[i]);{添小于号}
          F[N-Step]:=Total-F[N-Step]
        end else Total:=Total+F[N-Step]
      end
  end;

procedure Main2;{算法1-2}
  begin
    Time:=-MemL[$40:$6C];
    Total:=0;
    FillChar(F,Sizeof(F),$FF);
    Count2(1,1,[1..n]);
    Inc(Time,MemL[$40:$6C])
  end;

procedure Main3;{算法1-3}
  var
    i,j           :Integer;
    x             :Comp;
  begin
    Time:=-MemL[$40:$6C];
    FillChar(F,Sizeof(F),0);
    F[0]:=1;
    for i:=1 to n do begin
      F[i]:=0;
      x:=1;
      for j:=1 to i do begin
        x:=x*(i-j+1)/j;
        F[i]:=F[i]+x*F[i-j]
      end
    end;
    Total:=F[n];
    Inc(Time,MemL[$40:$6C])
  end;

begin
  Write('Input N (1<=N<=',MaxN,'): ');Readln(N);

  Main1;
  Writeln('Algorithm 1 : ');
  Writeln('Total = ',Total:0:0,' Time = ',Time);

  Main2;
  Writeln('Algorithm 2 : ');
  Writeln('Total = ',Total:0:0,' Time = ',Time);

  Main3;
  Writeln('Algorithm 3 : ');
  Writeln('Total = ',Total:0:0,' Time = ',Time)

end.
