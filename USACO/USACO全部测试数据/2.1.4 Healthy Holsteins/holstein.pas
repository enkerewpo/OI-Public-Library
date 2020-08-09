{
ID:asiapea1
PROG:holstein
LANG:PASCAL
}
 program holstein;
 type integer=longint;
      ttp=array[0..25]of integer;
 var v,g,min,i,k:integer;
     VC,b,c,bb,num:ttp;
     a:array[1..15,0..25]of integer;
   procedure Init;
   var i,j,k,w:integer;
   begin
     assign(input,'holstein.in');reset(input);
     assign(output,'holstein.out');rewrite(output);
     read(v);
     for i:=1 to v do read(VC[i]);
     read(g);
     fillchar(a,sizeof(A),0);
     for i:=1 to g do
       for j:=1 to v do
         begin read(a[i,j]);inc(a[i,0],a[i,j]); end;
     for i:=1 to g do num[i]:=i;
     for i:=1 to g-1 do
       for j:=i+1 to g do
         if a[i,0]<a[j,0] then begin
             for k:=0 to v do
               begin w:=a[i,k];a[i,k]:=a[j,k];a[j,k]:=w; end;
             k:=num[i];num[i]:=num[j];num[j]:=k;
             end;
     min:=g+1;b[0]:=0;
     fillchar(c,sizeof(c),0);
   end;
   procedure Main(l:integer;c:ttp);
   var F:boolean;
       i,j:integer;
       d:ttp;
   begin
     if l-1>min then exit;
     f:=true;
     for i:=1 to v do
       if c[i]<VC[i] then begin f:=false;break; end;
     if f then begin
                 for i:=1 to l-1 do d[i]:=num[b[i]];
                 for i:=1 to l-2 do
                   for j:=i+1 to l-1 do
                     if d[i]>d[j] then
                         begin k:=d[i];d[i]:=d[j];d[j]:=k; end;
                 if l-1<min then begin min:=l-1;bb:=d;exit; end;
                 i:=1;
                 while d[i]=bb[i] do inc(i);
                 if d[i]<bb[i] then bb:=d;
                 exit;
               end;
     if l>min then exit;
     for i:=b[l-1]+1 to g do
       begin
         for j:=1 to v do d[j]:=c[j]+a[i,j];
         b[l]:=i;Main(l+1,d);
       end;
   end;
 begin
   Init;
   Main(1,c);
   write(min);
   for i:=1 to min do write(' ',bb[i]);
   writeln;close(output);
 end.