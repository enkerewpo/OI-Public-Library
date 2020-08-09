{

ID:asiapea1

PROB:betsy

LANG:PASCAL

}

program betsy;

const

 fin='betsy.in';

 fout='betsy.out';

// act:array[1..8,1..2] of longint=((-1,-1),(0,-1),(1,-1),(1,0),(1,1),(0,1),(-1,1),(-1,0));

// nearby:array[1..4,1..2] of longint=((-1,0),(1,0),(0,-1),(0,1));

var

 used:array[0..8,0..8] of boolean;

 beside:array[0..8,0..8] of longint;

 n:longint;

 total:longint;

 way:longint;

// xx,yy:longint;

 i:longint;

procedure put(x,y:longint);

 var

  {i,}j,{k,l,}willgox,willgoy:longint;

 begin

  if (x=1) and (y=n)

   then

    begin

     if way+1=n*n then inc(total);

     exit;

    end;

  {with all cuts}

  begin

   if (x=2) and (y=n-1) and not used[2,n] and not used[1,n-1] then

    exit;

//   if (used[x-1,y]=used[x+1,y]) and (used[x,y-1]=used[x,y+1]) and (used[x-1,y]<>used[x,y-1]) then exit;

   {quick test before cut1,in fact contained by cut1}

   begin

    if ((x=1) or (x=n))  and (not used[x,y-1]) and (y>1) then exit;

    if (y=1) and (not used[x-1,y])  and (x>1)  then exit;

    if (y=n) and (not used[x+1,y]) and (x<n)  then exit;

   end;

   {cut1}{if the graph is separated into completely two or more untouchable parts}{it makes the program slower}

{

   begin

    j:=0;

    i:=2;

     if not used[x+act[i-1,1],y+act[i-1,2]] and used[x+act[i,1],y+act[i,2]] then

      begin

       inc(j);

       if j>1 then exit;

      end;

    i:=3;

     if not used[x+act[i-1,1],y+act[i-1,2]] and used[x+act[i,1],y+act[i,2]] then

      begin

       inc(j);

       if j>1 then exit;

      end;

    i:=4;

     if not used[x+act[i-1,1],y+act[i-1,2]] and used[x+act[i,1],y+act[i,2]] then

      begin

       inc(j);

       if j>1 then exit;

      end;

    i:=5;

     if not used[x+act[i-1,1],y+act[i-1,2]] and used[x+act[i,1],y+act[i,2]] then

      begin

       inc(j);

       if j>1 then exit;

      end;

    i:=6;

     if not used[x+act[i-1,1],y+act[i-1,2]] and used[x+act[i,1],y+act[i,2]] then

      begin

       inc(j);

       if j>1 then exit;

      end;

    i:=7;

     if not used[x+act[i-1,1],y+act[i-1,2]] and used[x+act[i,1],y+act[i,2]] then

      begin

       inc(j);

       if j>1 then exit;

      end;

    i:=8;

     if not used[x+act[i-1,1],y+act[i-1,2]] and used[x+act[i,1],y+act[i,2]] then

      begin

       inc(j);

       if j>1 then exit;

      end;

   end;

}

   {cut2}{if the point makes a blind alley}

   begin

    j:=0;

     repeat

      if (beside[x-1,y]=3) and not used[x-1,y] then

       begin

             inc(j);

             if j>1 then

               exit;

             willgox:=x-1;

             willgoy:=y;

             break;

       end;

      if (beside[x+1,y]=3) and not used[x+1,y] then

       begin

             inc(j);

             if j>1 then

               exit;

             willgox:=x+1;

             willgoy:=y;

             break;

       end;

      if (beside[x,y-1]=3) and not used[x,y-1] then

       begin

             inc(j);

             if j>1 then

               exit;

             willgox:=x;

             willgoy:=y-1;

             break;

       end;

      if (beside[x,y+1]=3) and not used[x,y+1] then

       begin

             inc(j);

             if j>1 then

               exit;

             willgox:=x;

             willgoy:=y+1;

             break;

       end;

     until true;

   end;

  end;

  used[x,y]:=true;

  inc(way);

  if j=1 then

   put(willgox,willgoy)

  else

   begin

    if x<>1 then

     if (not used[x-1,y]) or ((x-1=1) and (y=n)) then

      begin

       inc(beside[x-2,y]);

       inc(beside[x-1,y+1]);

       inc(beside[x,y]);

       inc(beside[x-1,y-1]);

       if not ((used[x-2,y] or used[x-2,y-1] or used[x-2,y+1]) and not used[x-1,y-1] and not used[x-1,y+1]) then

        put(x-1,y);

       dec(beside[x-2,y]);

       dec(beside[x-1,y+1]);

       dec(beside[x,y]);

       dec(beside[x-1,y-1]);

      end;

    if y<>1 then

     if not used[x,y-1]  then

      begin

       inc(beside[x-1,y-1]);

       inc(beside[x,y]);

       inc(beside[x+1,y-1]);

       inc(beside[x,y-2]);

       if not ((used[x,y-2] {or used[x-1,y-2] or used[x+1,y-2]}) and not used[x-1,y-1] and not used[x-1,y+1]) then

       put(x,y-1);

       dec(beside[x-1,y-1]);

       dec(beside[x,y]);

       dec(beside[x+1,y-1]);

       dec(beside[x,y-2]);

      end;

    if x<>n then

     if not used[x+1,y] then

      begin

       inc(beside[x,y]);

       inc(beside[x+1,y+1]);

       inc(beside[x+2,y]);

       inc(beside[x+1,y-1]);

       if not ((used[x+2,y] or used[x+2,y-1] or used[x+2,y+1]) and not used[x+1,y-1] and not used[x+1,y+1]) then

       put(x+1,y);

       dec(beside[x,y]);

       dec(beside[x+1,y+1]);

       dec(beside[x+2,y]);

       dec(beside[x+1,y-1]);

      end;

    if y<>n then

     if not used[x,y+1] or ((x=1) and (y=n-1)) then

      begin

       inc(beside[x-1,y+1]);

       inc(beside[x,y+2]);

       inc(beside[x+1,y+1]);

       inc(beside[x,y]);

       if not ((used[x,y+2] or used[x-1,y+2] or used[x+1,y+2]) and not used[x+1,y+1] and not used[x-1,y+1]) then

       put(x,y+1);

       dec(beside[x-1,y+1]);

       dec(beside[x,y+2]);

       dec(beside[x+1,y+1]);

       dec(beside[x,y]);

      end;

   end;

  used[x,y]:=false;

  dec(way);

 end;

procedure init;

 begin

  assign(input,fin);

  assign(output,fout);

  reset(input);

  rewrite(output);

  readln(n);

  close(input);

 end;

procedure outp;

 begin

  writeln(total);

  close(output);

 end;

begin

 init;

  used[1,n]:=true;

  for i:=0 to n+1 do

   begin

    used[0,i]:=true;

    used[n+1,i]:=true;

    used[i,0]:=true;

    used[i,n+1]:=true;

   end;

  for i:=1 to n do

   begin

    inc(beside[i,1]);

    inc(beside[i,n]);

    inc(beside[1,i]);

    inc(beside[n,i]);

   end;

  put(1,1);

 outp;

end.

