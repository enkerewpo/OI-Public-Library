{
ID:asiapea1
PROB:milk6
LANG:PASCAL
}
const

  fin='milk6.in';

  fout='milk6.out';

type

  node=record

    s,t,c,num:longint;

   end;

var

  tempmap,map:array[1..32,1..32]of longint;

  vex:array[1..10000]of node;

  put:array[1..10000]of longint;

  n,e:longint;

procedure qsort(s,t:longint);

  var

    i,j:longint;

    x:node;

  begin

    i:=s;j:=t;x:=vex[i];

    while i<j do

      begin

        while (i<j)and(vex[j].c<x.c) do dec(j);

        vex[i]:=vex[j];

        if i<j then inc(i);

        while (i<j)and(vex[i].c>x.c) do inc(i);

        vex[j]:=vex[i];

        if i<j then dec(j);

      end;

    vex[i]:=x;

    if s<i-1 then qsort(s,i-1);

    if i+1<t then qsort(i+1,t);

  end;

procedure init;

  var

    i,v1,v2,f:longint;

  begin

    assign(input,fin);assign(output,fout);

    reset(input);rewrite(output);

    readln(n,e);

    for i:=1 to e do

      begin

        readln(v1,v2,f);

        inc(map[v1,v2],f);

        vex[i].s:=v1;vex[i].t:=v2;vex[i].c:=f;vex[i].num:=i;

      end;

    qsort(1,e);

  end;

function maxstream:longint;

  var

    f,c:longint;

  procedure findstream;

    var

      flag:array[1..32]of boolean;

      have,pr:array[1..32]of longint;

      mi,i,max:longint;

    begin

      fillchar(flag,sizeof(flag),false);

      fillchar(have,sizeof(have),0);

      have[1]:=2000000000;pr[1]:=0;

      while true do

        begin

          max:=0;mi:=-1;

          for i:=1 to n do

            if (not flag[i])and(have[i]>max) then

              begin max:=have[i];mi:=i;end;

          if mi=-1 then exit;

          if mi=n then break;

          flag[mi]:=true;

          for i:=1 to n do

            if (not flag[i])and(map[mi,i]>=have[i])and(max>=have[i]) then

              begin

                have[i]:=map[mi,i];

                if have[i]>max then have[i]:=max;

                pr[i]:=mi;

              end;

        end;

      f:=have[n];i:=n;

      while pr[i]<>0 do

        begin

          dec(map[pr[i],i],f);

          inc(map[i,pr[i]],f);

          i:=pr[i];

        end;

    end;

  begin

    f:=0;findstream;c:=0;

    while f<>0 do begin inc(c,f);f:=0;findstream;end;

    maxstream:=c;

  end;

procedure calc;

  var

    temp,f,i,total,j:longint;

  begin

    tempmap:=map;total:=0;

    f:=maxstream;write(f,' ');

    for i:=1 to e do

      if map[vex[i].s,vex[i].t]=0 then

        begin

          temp:=f;dec(tempmap[vex[i].s,vex[i].t],vex[i].c);map:=tempmap;

          f:=maxstream;

          if temp=f+vex[i].c then

            begin

              inc(total);

              put[total]:=vex[i].num;

              if f=0 then break;

            end

           else inc(tempmap[vex[i].s,vex[i].t],vex[i].c);

        end;

    writeln(total);

    for i:=1 to total do

      begin

        for j:=i+1 to total do

          if put[i]>put[j] then

            begin temp:=put[i];put[i]:=put[j];put[j]:=temp;end;

        writeln(put[i]);

      end;

    close(input);close(output);

  end;

begin

  init;

  calc;

end.

