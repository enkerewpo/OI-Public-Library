{
id:asiapea1
PROG:frameup
LANG:PASCAL
}
program frameup;
  type
    ty=array[1..30]of char;
  var
    l,r,u,d:array['A'..'Z']of integer;{存储字母的上下左右边界}
    bb:array['A'..'Z','A'..'Z']of boolean;{字母之间的联系}
    du:array['A'..'Z']of longint;{字母的入度}
    w:array[1..100,1..100]of char;{读入数据}
    have:array['A'..'Z']of boolean;{字母是否出现过}
    used:array[1..26]of boolean;{拓扑排序时回溯时用到}
    ch:array[1..26]of char;{将出现的字母存入数组中}
    n,m,n1,len:longint;
    aa:array[1..10000]of string[30];{存储结果}
    a1:ty;
    ch1:char;
  procedure  int;
    var i,j:integer;
    begin
      assign(input,'frameup.in');reset(input);
      for ch1:='A' to 'Z' do
        begin
          l[ch1]:=100;r[ch1]:=-100;u[ch1]:=100;d[ch1]:=-100;
        end;
      readln(n,m);
      for i:=1 to n do
        begin
          for j:=1 to m do
           begin
            read(w[i,j]); ch1:=w[i,j];
            if (ord(w[i,j])>=ord('A'))and(ord(w[i,j])<=ord('Z')) then begin{计算上下左右边界}
            if j<l[w[i,j]] then l[w[i,j]]:=j;
            if j>r[w[i,j]] then r[w[i,j]]:=j;
            if i<u[w[i,j]] then u[w[i,j]]:=i;
            if i>d[w[i,j]] then d[w[i,j]]:=i;
            if have[w[i,j]]=false then
              begin
                have[w[i,j]]:=true;
                inc(n1);ch[n1]:=w[i,j];{将出现的字母存入ch数组}
              end; end;
           end;
          readln;
        end;
    end;
  procedure  try1(step:integer);{拓扑回溯过程}
    var
      i,j:integer;
      ch3:char;
    begin
      if step>n1 then begin inc(len);aa[len]:=a1;exit;end;
      for i:=1 to n1 do
        if (used[i]=false)and(du[ch[i]]=0) then
          begin
            ch3:=ch[i];
            for j:=1 to n1 do
              if bb[ch3,ch[j]]=true then dec(du[ch[j]]);
            a1[n1-step+1]:=ch3; used[i]:=true;
            try1(step+1);
            used[i]:=false;
            for j:=1 to n1 do
              if bb[ch3,ch[j]]=true then inc(du[ch[j]]);
          end;
    end;
  procedure  main;{先建立图形，再进行拓扑}
    var
      i,j:integer;
    begin
      for i:=1 to n1 do{建立图形的主过程}
        begin
          ch1:=ch[i];
          for j:=l[ch1] to r[ch1] do{扫描上下边界}
           begin
            if (w[u[ch1],j]<>ch1)and(w[u[ch1],j]<>'.') then{扫描上边界}
              if bb[w[u[ch1],j],ch1]=false then
                begin
                  inc(du[ch1]);
                  bb[w[u[ch1],j],ch1]:=true;
                end;
            if (w[d[ch1],j]<>ch1)and(w[d[ch1],j]<>'.') then{扫描下边界}
              if bb[w[d[ch1],j],ch1]=false then
                begin
                  inc(du[ch1]);
                  bb[w[d[ch1],j],ch1]:=true;
                end;
            end;
          for j:=u[ch1] to d[ch1] do{扫描左右边界}
            begin
              if (w[j,l[ch1]]<>ch1)and(w[j,l[ch1]]<>'.') then{扫描左边界}
                if bb[w[j,l[ch1]],ch1]=false then
                  begin
                    inc(du[ch1]);
                    bb[w[j,l[ch1]],ch1]:=true;
                  end;
              if (w[j,r[ch1]]<>ch1)and(w[j,r[ch1]]<>'.') then{扫描右边界}
                if bb[w[j,r[ch1]],ch1]=false then
                  begin
                    inc(du[ch1]);
                    bb[w[j,r[ch1]],ch1]:=true;
                  end;
            end;
        end;
      try1(1);
    end;
 { procedure  pai;{没用快排9，10个测试数据超时}
    var
      i,j,num:longint;
    begin
      for i:=1 to len-1 do
        begin
          num:=i;
          for j:=i+1 to len do
            if aa[j]<aa[num] then num:=j;
          a1:=aa[i];
          aa[i]:=aa[num];
          aa[num]:=a1;
        end;
    end;  }
  procedure  kuai(s,t:longint;var k:longint);{快排过程}
    var
      i,j:integer;
      temp:ty;
    begin
      i:=s;j:=t;temp:=aa[s];
      while i<j do
        begin
          while (i<j)and(aa[j]>temp) do dec(j);
          aa[i]:=aa[j];
          while (i<j)and(aa[i]<temp) do inc(i);
          aa[j]:=aa[i];
        end;
      aa[i]:=temp;
      k:=i;
    end;
  procedure  pai(s,t:longint);
    var k:longint;
    begin
      if s<t then
        begin
          kuai(s,t,k);
          pai(s,k-1);
          pai(k+1,t);
        end;
    end;
  procedure  out1;{输出过程}
    var
      i,j:longint;
    begin
      assign(output,'frameup.out');rewrite(output);
      for i:=1 to len do
        begin
          for j:=1 to n1 do
            write(aa[i][j]);
          writeln;
        end;
      close(output);
    end;
begin
  int;
  main;
  pai(1,len);
  out1;
end.