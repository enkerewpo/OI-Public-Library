unit gomain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, jpeg, Menus, CheckLst;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    board: TImage;
    state: TPanel;
    PutBlack: TRadioButton;
    PutWhite: TRadioButton;
    Start: TButton;
    first: TComboBox;
    Panel4: TPanel;
    new: TButton;
    Save: TButton;
    load: TButton;
    OpenFile: TOpenDialog;
    SaveFile: TSaveDialog;
    BlackImage: TImage;
    WhiteImage: TImage;
    Panel1: TPanel;
    Timer1: TTimer;
    MainMenu1: TMainMenu;
    Game: TMenuItem;
    new1: TMenuItem;
    save1: TMenuItem;
    load1: TMenuItem;
    N1: TMenuItem;
    exit1: TMenuItem;
    help: TMenuItem;
    procedure boardMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure New1Click(Sender: TObject);
    procedure StartClick(Sender: TObject);
    procedure newClick(Sender: TObject);
    procedure SaveClick(Sender: TObject);
    procedure loadClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure save1Click(Sender: TObject);
    procedure load1Click(Sender: TObject);
    procedure helpClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
type boardtype = array [1..10,1..10] of char;
     valuetype = array [1..10,1..10] of integer;
     booltype = array [1..10,1..10] of boolean;
var
  Form1: TForm1;
  NowColor: char;
  m:integer;
  stone:array [1..10,1..10] of TImage;
  die,canplay:boolean;
  h:array [1..10,1..10] of boolean;
  g:array [1..10,1..10] of integer;
  f,f0:boardtype;
  v,sl:valuetype;
  rb,rw,wx,wy,lastx,lasty,time,qnum:integer;
  queue:array [1..100] of integer;
  aa,bb,cc,dd,ee,ff:shortint;
  num:array [1..100] of integer;
  n,sn:array [1..100] of integer;
  x0,y0:array [1..100,1..10] of shortint;
  ch:array [1..100,0..10] of char;

implementation

uses readme;

const dir     :      array [0..4,0..1] of shortint
              =      ((0,0),(0,1),(1,0),(0,-1),(-1,0));
      dir8    :      array [1..8,0..1] of shortint
              =      ((0,1),(1,0),(0,-1),(-1,0),(1,1),(-1,-1),(1,-1),(-1,1));
{$R *.DFM}

procedure Initialize; {初始化}
var       i,j                 :   integer;
begin
  Form1.first.enabled:=true;
  Form1.start.enabled:=true;
  Form1.putblack.enabled:=true;
  Form1.putwhite.enabled:=true;
  Form1.state.caption:='';
  canplay:=true;
  NowColor:=' ';
  m:=0;
  lastx:=0;lasty:=0;
  for i:=1 to 10 do
    for j:=1 to 10 do
      stone[i,j].visible:=false;
  fillchar(f,sizeof(f),' ');
end;
procedure search(f:boardtype;p,q:shortint);{寻找连片的棋子}
var       i   :    shortint;
begin
  h[p,q]:=true;
  for i:=1 to 4 do
    if ((p+dir[i,0]) in [1..10])and((q+dir[i,1]) in [1..10]) then
      if not h[p+dir[i,0],q+dir[i,1]] then
        if f[p+dir[i,0],q+dir[i,1]]=' ' then
          begin
            die:=false;
            exit;
          end
          else
            if f[p+dir[i,0],q+dir[i,1]]=f[p,q] then
              begin
                search(f,p+dir[i,0],q+dir[i,1]);
                if not die then exit;
              end;
end;
procedure Clear(var f:boardtype;p,q:shortint);            {提去一片棋子}
var       i,j,k               :      integer;
begin
  for i:=1 to 4 do
    if ((p+dir[i,0]) in [1..10])and((q+dir[i,1]) in [1..10]) then
      if (f[p+dir[i,0],q+dir[i,1]]<>' ')and(f[p+dir[i,0],q+dir[i,1]]<>f[p,q]) then
        begin
          fillchar(h,sizeof(h),false);
          die:=true;
          search(f,p+dir[i,0],q+dir[i,1]);
          if die then
            for j:=1 to 10 do
              for k:=1 to 10 do
                if h[j,k] then f[j,k]:=' ';
        end;
  for i:=0 to 4 do
    if ((p+dir[i,0]) in [1..10])and((q+dir[i,1]) in [1..10]) then
      if (f[p+dir[i,0],q+dir[i,1]]=f[p,q]) then
        begin
          fillchar(h,sizeof(h),false);
          die:=true;
          search(f,p+dir[i,0],q+dir[i,1]);
          if die then
            for j:=1 to 10 do
              for k:=1 to 10 do
                if h[j,k] then f[j,k]:=' ';
        end;
end;
procedure PutStone(var f:boardtype;p,q:integer;Color:char);   {在f中的(p,q)位落子}
begin
  f[p,q]:=Color;
  Clear(f,p,q);
end;
procedure SearchBlackBlocks(f:boardtype;var black:valuetype;x,y,no:shortint);
var       i   :    shortint;
begin
  Black[x,y]:=no;
  for i:=1 to 4 do
    if ((x+dir[i,0]) in [1..10])and((y+dir[i,1]) in [1..10]) then
      if (Black[x+dir[i,0],y+dir[i,1]]=0)and(f[x+dir[i,0],y+dir[i,1]]='B') then
        SearchBlackBlocks(f,black,x+dir[i,0],y+dir[i,1],no);
  for i:=5 to 8 do
    if ((x+dir8[i,0]) in [1..10])and((y+dir8[i,1]) in [1..10]) then
      if (Black[x+dir8[i,0],y+dir8[i,1]]=0)and(f[x+dir8[i,0],y+dir8[i,1]]='B')
        and(f[x+dir8[i,0],y]=' ')and(f[x,y+dir8[i,1]]=' ') then
        SearchBlackBlocks(f,black,x+dir8[i,0],y+dir8[i,1],no);
end;
procedure CheckBlack(f:boardtype;var black:valuetype;no:shortint);   {检查整片黑子死活}
var  f0,f1   :     boolean;
     i,j,x   :     shortint;
begin
  f0:=false;
  for i:=1 to 10 do
    begin
      for j:=1 to 10 do
        if black[i,j]=no then
          begin
            f1:=false;
            for x:=i+1 to 10 do
             if (sl[x,j]<0)or(f[x,j]<>' ') then begin f1:=true;break;end;
            if not f1 then
              begin
                f0:=true;
                break;
              end;
            f1:=false;
            for x:=j+1 to 10 do
              if (sl[i,x]<0)or(f[i,x]<>' ') then begin f1:=true;break;end;
            if not f1 then
              begin
                f0:=true;
                break;
              end;
          end;
      if f0 then break;
    end;
  if f0 then
    for i:=1 to 10 do
      for j:=1 to 10 do
        if black[i,j]=no then black[i,j]:=-black[i,j];
end;
procedure SearchInBlack(f:boardtype;black:valuetype;var InBlack:booltype;x,y:shortint);{搜索一片黑子}
var       i   :    shortint;
begin
  InBlack[x,y]:=true;
  for i:=1 to 4 do
    if ((x+dir[i,0]) in [1..10])and((y+dir[i,1]) in [1..10]) then
      if (not InBlack[x+dir[i,0],y+dir[i,1]])and
         (((black[x+dir[i,0],y+dir[i,1]]>=0)and(sl[x+dir[i,0],y+dir[i,1]]<=0))
         or((f[x+dir[i,0],y+dir[i,1]]='W')and(sl[x+dir[i,0],y+dir[i,1]]<=2))) then
        SearchInBlack(f,black,InBlack,x+dir[i,0],y+dir[i,1]);
end;
function ShowStone(var f:boardtype;p,q:integer;Color:char):boolean;{在f中落子,且显示}
var       i,j         :   shortint;
begin
  f0:=f;
  PutStone(f,p,q,Color);
  if f[p,q]=' ' then
    begin
      f:=f0;
      Form1.state.caption:='非法着点';
      ShowStone:=false;
      exit;
    end
    else
      for i:=1 to 10 do
        for j:=1 to 10 do
          if f0[i,j]<>f[i,j] then
            case f[i,j] of
              ' '  :  stone[i,j].visible:=false;
              'B'  :  begin
                        stone[i,j].picture:=Form1.BlackImage.Picture;
                        stone[i,j].visible:=true;
                      end;
              'W'  :  begin
                        stone[i,j].picture:=Form1.WhiteImage.Picture;
                        stone[i,j].visible:=true;
                      end;
            end;
  if Color='B' then
    stone[p,q].picture:=Form1.BlackImage.Picture
    else
      stone[p,q].picture:=Form1.WhiteImage.Picture;
  if NowColor='B' then NowColor:='W'
    else NowColor:='B';
  ShowStone:=true;
end;
function noroundblack(f:boardtype;black,v:valuetype;p,q:shortint):boolean;{(p,q)位周围有否黑子或黑势}
var      k                          :              shortint;
begin
  for k:=1 to 4 do
    if ((p+dir[k,0]) in [1..10])and((q+dir[k,1]) in [1..10]) then
      if ((v[p+dir[k,0],q+dir[k,1]]>0)and(f[p+dir[k,0],q+dir[k,1]]=' '))or
         ((v[p+dir[k,0],q+dir[k,1]]>=-6)and(f[p+dir[k,0],q+dir[k,1]]='B')and(black[p+dir[k,0],q+dir[k,1]]<0)) then
        begin
          noroundblack:=false;
          exit;
        end;
  noroundblack:=true;
end;
procedure findinwhite(f:boardtype;black,v:valuetype;p,q,no:shortint);  {寻找白子区域}
var       k                           :            shortint;
begin
  g[p,q]:=no;
  num[no]:=num[no]+1;
  k:=1;
  repeat
    if ((p+dir[k,0]) in [1..10])and((q+dir[k,1])in[1..10]) then
      begin
        if (f[p+dir[k,0],q+dir[k,1]]=' ')and
           ((v[p+dir[k,0],q+dir[k,1]]<0)or((v[p,q]=0)and(v[p+dir[k,0],q+dir[k,1]]=0)))
            and(g[p+dir[k,0],q+dir[k,1]]=0)and(noroundblack(f,black,v,p+dir[k,0],q+dir[k,1])) then
          findinwhite(f,black,v,p+dir[k,0],q+dir[k,1],no)
          else
            begin
              if f[p+dir[k,0],q+dir[k,1]]='W' then rw:=rw+1
                else
                  if v[p+dir[k,0],q+dir[k,1]]<0 then rw:=rw+1
                    else if v[p+dir[k,0],q+dir[k,1]]>0 then rb:=rb+1;

            end;
      end;
    k:=k+1;
  until k>4;
end;
function findjy(f:boardtype;black,v:valuetype;k:integer):integer;    {找假眼}
var     i,x,y,r,n0,n1,n2  :       integer;
        c                 :       boolean;
begin
  r:=0;
  for x:=1 to 10 do
    for y:=1 to 10 do
      if g[x,y]=k then
        begin
          c:=false;
          i:=1;
          while i<=4 do
            begin
              if (x+dir[i,0]>=1)and(x+dir[i,0]<=10)and(y+dir[i,1]>=1)and(y+dir[i,1]<=10) then
                if f[x+dir[i,0],y+dir[i,1]]=' ' then
                  begin
                    if not NoRoundBlack(f,black,v,x+dir[i,0],y+dir[i,1]) then
                      begin
                        c:=true;
                        break;
                      end;
                  end;
              i:=i+1;
            end;
          n0:=0;
          for i:=1 to 4 do
            if ((x+dir[i,0]) in [1..10])and((y+dir[i,1]) in [1..10]) then
              if g[x+dir[i,0],y+dir[i,1]]=k then n0:=n0+1;
          if n0<>1 then
            begin
              if c then r:=r+1;
              continue;
            end;
          n0:=0;n1:=0;n2:=0;
          for i:=5 to 8 do
            if ((x+dir8[i,0]) in [1..10])and((y+dir8[i,1]) in [1..10]) then
              begin
                n0:=n0+1;
                if (f[x+dir8[i,0],y+dir8[i,1]]='B')and(black[x+dir8[i,0],y+dir8[i,1]]<0) then n1:=n1+1;
                if (v[x+dir8[i,0],y+dir8[i,1]]<=-2)or(f[x+dir8[i,0],y+dir8[i,1]]='W') then n2:=n2+1;
              end;
          if n0=1 then continue;
          if ((n0=2)and(n1=1))or((n0=4)and(n1=2)) then r:=r+2
            else
              begin
                if c then r:=r+1;
                if n0=2 then
                  begin
                    if n2<2 then r:=r+1;
                  end
                  else
                    if (n2<2)or((n2=2)and(n1>0)) then r:=r+1;
              end;
        end;
  findjy:=r;
end;
function check(f:boardtype;k:integer;value:valuetype):boolean;       {检查某片是否真正为白子区域}                 
var      i,j   :  integer;
begin
  for i:=1 to 10 do
    for j:=1 to 10 do
      if g[i,j]=k then
        if value[i,j]<0 then
          begin
            check:=true;
            exit;
          end;
  check:=false;
end;
procedure ShiLi(f:boardtype;var value:valuetype);                    {按"气位"赋值}
var       i,j,k            :                integer;
          find             :                boolean;
begin
  for i:=1 to 10 do
    for j:=1 to 10 do
      begin
        find:=false;
        for k:=1 to 4 do
          if ((i+dir[k,0]) in [1..10])and((j+dir[k,1]) in [1..10]) then
            if (f[i+dir[k,0],j+dir[k,1]]='B') then
              begin
                find:=true;
                break;
              end;
        if find then
          begin
            value[i,j]:=value[i,j]+6;
            continue;
          end;
        for k:=5 to 8 do
          if ((i+dir8[k,0]) in [1..10])and((j+dir8[k,1]) in [1..10]) then
            if (f[i+dir8[k,0],j+dir8[k,1]]='B')
              and(f[i+dir8[k,0],j]=' ')and(f[i,j+dir8[k,1]]=' ') then
              begin
                find:=true;
                break;
              end;
        if find then
          begin
            value[i,j]:=value[i,j]+5;
            continue;
          end;
        for k:=5 to 8 do
          if ((i+dir8[k,0]) in [1..10])and((j+dir8[k,1]) in [1..10]) then
            if (f[i+dir8[k,0],j+dir8[k,1]]='B') then
              begin
                find:=true;
                break;
              end;
        if find then
          begin
            value[i,j]:=value[i,j]+3;
            continue;
          end;
        for k:=1 to 4 do
          if ((i+2*dir[k,0]) in [1..10])and((j+2*dir[k,1]) in [1..10]) then
            if (f[i+2*dir[k,0],j+2*dir[k,1]]='B')and(f[i+dir[k,0],j+dir[k,1]]=' ') then
              begin
                find:=true;
                break;
              end;
        if find then
          begin
            value[i,j]:=value[i,j]+3;
            continue;
          end;
        if ((i+1) in [1..10])and((j+1) in [1..10]) then
          if f[i+1,j+1]=' ' then
            begin
              if (f[i+1,j]=' ')and((i+2) in [1..10]) then
                if f[i+2,j+1]='B' then find:=true;
              if (f[i,j+1]=' ')and((j+2) in [1..10]) then
                if f[i+1,j+2]='B' then find:=true;
            end;
        if ((i+1) in [1..10])and((j-1) in [1..10]) then
          if f[i+1,j-1]=' ' then
            begin
              if (f[i+1,j]=' ')and((i+2) in [1..10]) then
                if f[i+2,j-1]='B' then find:=true;
              if (f[i,j-1]=' ')and((j-2) in [1..10]) then
                if f[i+1,j-2]='B' then find:=true;
            end;
        if ((i-1) in [1..10])and((j+1) in [1..10]) then
          if f[i-1,j+1]=' ' then
            begin
              if (f[i-1,j]=' ')and((i-2) in [1..10]) then
                if f[i-2,j+1]='B' then find:=true;
              if (f[i,j+1]=' ')and((j+2) in [1..10]) then
                if f[i-1,j+2]='B' then find:=true;
            end;
        if ((i-1) in [1..10])and((j-1) in [1..10]) then
          if f[i-1,j-1]=' ' then
            begin
              if (f[i-1,j]=' ')and((i-2) in [1..10]) then
                if f[i-2,j-1]='B' then find:=true;
              if (f[i,j-1]=' ')and((j-2) in [1..10]) then
                if f[i-1,j-2]='B' then find:=true;
            end;
        if find then value[i,j]:=value[i,j]+2;
      end;
  for i:=1 to 10 do
    for j:=1 to 10 do
      begin
        find:=false;
        for k:=1 to 4 do
          if ((i+dir[k,0]) in [1..10])and((j+dir[k,1]) in [1..10]) then
            if (f[i+dir[k,0],j+dir[k,1]]='W') then
              begin
                find:=true;
                break;
              end;
        if find then
          begin
            value[i,j]:=value[i,j]-6;
            continue;
          end;
        for k:=5 to 8 do
          if ((i+dir8[k,0]) in [1..10])and((j+dir8[k,1]) in [1..10]) then
            if (f[i+dir8[k,0],j+dir8[k,1]]='W')
              and(f[i+dir8[k,0],j]=' ')and(f[i,j+dir8[k,1]]=' ') then
              begin
                find:=true;
                break;
              end;
        if find then
          begin
            value[i,j]:=value[i,j]-5;
            continue;
          end;
        for k:=5 to 8 do
          if ((i+dir8[k,0]) in [1..10])and((j+dir8[k,1]) in [1..10]) then
            if (f[i+dir8[k,0],j+dir8[k,1]]='W') then
              begin
                find:=true;
                break;
              end;
        if find then
          begin
            value[i,j]:=value[i,j]-3;
            continue;
          end;
        for k:=1 to 4 do
          if ((i+2*dir[k,0]) in [1..10])and((j+2*dir[k,1]) in [1..10]) then
            if (f[i+2*dir[k,0],j+2*dir[k,1]]='W')and(f[i+dir[k,0],j+dir[k,1]]=' ') then
              begin
                find:=true;
                break;
              end;
        if find then
          begin
            value[i,j]:=value[i,j]-3;
            continue;
          end;
        if ((i+1) in [1..10])and((j+1) in [1..10]) then
          if f[i+1,j+1]=' ' then
            begin
              if (f[i+1,j]=' ')and((i+2) in [1..10]) then
                if f[i+2,j+1]='W' then find:=true;
              if (f[i,j+1]=' ')and((j+2) in [1..10]) then
                if f[i+1,j+2]='W' then find:=true;
            end;
        if ((i+1) in [1..10])and((j-1) in [1..10]) then
          if f[i+1,j-1]=' ' then
            begin
              if (f[i+1,j]=' ')and((i+2) in [1..10]) then
                if f[i+2,j-1]='W' then find:=true;
              if (f[i,j-1]=' ')and((j-2) in [1..10]) then
                if f[i+1,j-2]='W' then find:=true;
            end;
        if ((i-1) in [1..10])and((j+1) in [1..10]) then
          if f[i-1,j+1]=' ' then
            begin
              if (f[i-1,j]=' ')and((i-2) in [1..10]) then
                if f[i-2,j+1]='W' then find:=true;
              if (f[i,j+1]=' ')and((j+2) in [1..10]) then
                if f[i-1,j+2]='W' then find:=true;
            end;
        if ((i-1) in [1..10])and((j-1) in [1..10]) then
          if f[i-1,j-1]=' ' then
            begin
              if (f[i-1,j]=' ')and((i-2) in [1..10]) then
                if f[i-2,j-1]='W' then find:=true;
              if (f[i,j-1]=' ')and((j-2) in [1..10]) then
                if f[i-1,j-2]='W' then find:=true;
            end;
        if find then value[i,j]:=value[i,j]-2;
      end;
end;
procedure QiWei(f:boardtype;var black,value:valuetype;var InBlack:booltype);                   {按"气位"赋值}
var i,j,no,xx,yy     :                     integer;
begin
  ShiLi(f,value);
  fillchar(black,sizeof(black),0);
  no:=0;
  for i:=1 to 10 do
    for j:=1 to 10 do
      if (black[i,j]=0)and(f[i,j]='B') then
        begin
          no:=no+1;
          SearchBlackBlocks(f,black,i,j,no);
          CheckBlack(f,black,no);
        end;  for i:=1 to 10 do
    for j:=1 to 10 do
      if (f[i,j]='B')and(black[i,j]>=0) then f[i,j]:=' ';
  ShiLi(f,value);
  xx:=1;yy:=1;
  while (xx<=10)and(f[xx,yy]<>'W') do
    begin
      yy:=yy+1;
      if yy>10 then
        begin
          yy:=1;
          xx:=xx+1;
        end;
    end;
  fillchar(InBlack,sizeof(InBlack),false);
  if xx<=10 then SearchInBlack(f,Black,InBlack,xx,yy);
end;
procedure calc(f:boardtype;var black,value:valuetype;var InBlack:booltype;var aa,bb,cc,dd,ee,ff:shortint);{计算各种眼位数}
var       i,j,k,t,no,p,q,x,y,sb,sw      :     integer;
          a0,b0,jy,p0,q0,u              :     integer;
          pn                            :     real;
          c,same,found,find             :     boolean;
          f0                            :     boardtype;
begin
  fillchar(value,sizeof(value),0);
  fillchar(h,sizeof(h),true);
  QiWei(f,black,value,InBlack);
  f0:=f;
  for i:=1 to 10 do
    for j:=1 to 10 do
      if (f[i,j]='B')and(Black[i,j]>=0) then f[i,j]:=' ';
  fillchar(g,sizeof(g),0);
  no:=0;m:=0;
  fillchar(num,sizeof(num),0);
  for i:=1 to 10 do
    for j:=1 to 10 do
      if (f[i,j]=' ')and(g[i,j]=0)and(value[i,j]<=0) then
        begin
          no:=no+1;
          rb:=0;rw:=0;
          FindInWhite(f,black,value,i,j,no);
          if ((rb=0)or(rw/rb>4))and(rw>0)and(check(f,no,value)) then
            begin
              m:=m+1;
              queue[m]:=no;
            end;
        end;
  aa:=0;bb:=0;cc:=0;dd:=0;ee:=0;ff:=0;
  f:=f0;
  for i:=1 to m do
    if num[queue[i]]=1 then
      begin
        a0:=aa;b0:=bb;
        x:=1;y:=1;
        while g[x,y]<>queue[i] do
          begin
            y:=y+1;
            if y>10 then
              begin
                x:=x+1;
                y:=1;
              end;
          end;
        if (x=10)or(y=10) then continue;
        if (x=1)and(y=1) then
          begin
            if ((value[2,2]<=-2)and(noroundblack(f,black,value,2,2)))or(f[2,2]='W') then aa:=aa+1;
          end
          else
            if x=1 then
              begin
                sw:=0;sb:=0;
                if ((value[2,y-1]<=-2)and(noroundblack(f,black,value,2,y-1)))or(f[2,y-1]='W') then sw:=sw+1
                  else if (value[2,y-1]>=0)and(f[2,y-1]='B') then sb:=sb+1;
                if ((value[2,y+1]<=-2)and(noroundblack(f,black,value,2,y+1)))or(f[2,y+1]='W') then sw:=sw+1
                  else if (value[2,y+1]>=0)and(f[2,y+1]='B') then sb:=sb+1;
                if sw=2 then aa:=aa+1
                  else if (sw=1)and(sb=0) then bb:=bb+1;
              end
              else
                if y=1 then
                  begin
                    sw:=0;sb:=0;
                    if ((value[x-1,2]<=-2)and(noroundblack(f,black,value,x-1,2)))or(f[x-1,2]='W') then sw:=sw+1
                      else if (value[x-1,2]>=0)and(f[x-1,2]='B') then sb:=sb+1;
                    if ((value[x+1,2]<=-2)and(noroundblack(f,black,value,x+1,2)))or(f[x+1,2]='W') then sw:=sw+1
                      else if (value[x+1,2]>=0)and(f[x+1,2]='B') then sb:=sb+1;
                    if sw=2 then aa:=aa+1
                      else if (sw=1)and(sb=0) then bb:=bb+1;
                  end
                  else
                begin
                  sb:=0;sw:=0;
                  if (value[x+1,y+1]>=0)and(f[x+1,y+1]='B') then sb:=sb+1
                    else if ((value[x+1,y+1]<=-2){and(noroundblack(f,value,x+1,y+1))})or(f[x+1,y+1]='W') then sw:=sw+1;
                  if (value[x-1,y+1]>=0)and(f[x-1,y+1]='B') then sb:=sb+1
                    else if ((value[x-1,y+1]<=-2){and(noroundblack(f,value,x-1,y+1))})or(f[x-1,y+1]='W') then sw:=sw+1;
                  if (value[x+1,y-1]>=0)and(f[x+1,y-1]='B') then sb:=sb+1
                    else if ((value[x+1,y-1]<=-2){and(noroundblack(f,value,x+1,y-1))})or(f[x+1,y-1]='W') then sw:=sw+1;
                  if (value[x-1,y-1]>=0)and(f[x-1,y-1]='B') then sb:=sb+1
                    else if ((value[x-1,y-1]<=-2){and(noroundblack(f,value,x-1,y-1))})or(f[x-1,y-1]='W') then sw:=sw+1;
                  if sb=1 then
                    begin
                      case sw of
                        2  :  bb:=bb+1;
                        3  :  aa:=aa+1;
                      end;
                    end
                    else
                      if sb=0 then
                        case sw of
                          1          :  bb:=bb+1;
                          2,3,4      :  aa:=aa+1;
                        end;
                end;
        if (aa<>a0)or(bb<>b0) then
          begin
            c:=false;
            for j:=1 to 4 do
              if ((x+dir[j,0]) in [1..10])and((y+dir[j,1]) in [1..10]) then
                if f[x+dir[j,0],y+dir[j,1]]=' ' then
                  begin
                    c:=not noroundblack(f,black,value,x+dir[j,0],y+dir[j,1]);
                    if c then break;
                  end;
            if c then
              if aa<>a0 then
                begin
                  aa:=a0;
                  bb:=bb+1;
                end
                else  bb:=b0;
          end;
      end;
  for k:=1 to m do
    if num[queue[k]] in [2..5] then
      begin
        found:=false;
        for u:=1 to qnum do
          begin
            if n[u]=num[queue[k]] then
              begin
                x:=1;y:=1;
                while g[x,y]<>queue[k] do
                  begin
                    y:=y+1;
                    if y>10 then
                      begin
                        x:=x+1;
                        y:=1;
                      end;
                  end;
                x:=x-x0[u,1];y:=y-y0[u,1];
                same:=true;
                for i:=2 to n[u] do
                  begin
                    if (x0[u,i]+x<1)or(x0[u,i]+x>10)or(y0[u,i]+y<1)or(y0[u,i]+y>10) then
                      begin
                        same:=false;
                        break;
                      end;
                    if g[x0[u,i]+x,y0[u,i]+y]<>queue[k] then
                      begin
                        same:=false;
                        break;
                      end;
                  end;
                if same then
                  begin
                    jy:=findjy(f,black,value,queue[k]);
                    found:=true;
                    c:=true;
                    if ch[u,jy]>'d' then
                      begin
                        i:=1;j:=1;
                        while i<=10 do
                          begin
                            if (g[i,j]=queue[k])and(f0[i,j]='B') then
                              begin
                                dd:=dd+1;
                                c:=false;
                                break;
                              end;
                            j:=j+1;
                            if j>10 then
                              begin
                                j:=1;
                                i:=i+1;
                              end;
                          end;
                      end;
                    if not c then break;
                    case ch[u,jy] of
                      'a'  :  aa:=aa+1;
                      'b'  :  bb:=bb+1;
                      'c'  :  cc:=cc+1;
                      'd'  :  dd:=dd+1;
                      'e'  :  ee:=ee+1;
                      'f'  :  ff:=ff+1;
                    end;
                    break;
                  end;
              end;
            readln;
          end;
        close(input);
        if (num[queue[k]]=5)and(not found) then
          begin
            jy:=findjy(f,black,value,queue[k]);
            case jy of
              0,1  :  ff:=ff+1;
              2    :  ee:=ee+1;
              3,4  :  dd:=dd+1;
              5    :  cc:=cc+1;
            end;
          end;
      end
      else
        if num[queue[k]]>5 then
          begin
            i:=1;j:=1;c:=true;
            while i<=10 do
              begin
                if (g[i,j]=queue[k])and(f0[i,j]='B') then
                  begin
                    dd:=dd+1;
                    c:=false;
                    break;
                  end;
                j:=j+1;
                if j>10 then
                  begin
                    j:=1;
                    i:=i+1;
                  end;
              end;
            if not c then continue;
            jy:=findjy(f,black,value,queue[k]);
            if num[queue[k]]-jy>=4 then ff:=ff+1
              else
                case num[queue[k]]-jy of
                  3  :  ee:=ee+1;
                  2  :  dd:=dd+1;
                  1  :  cc:=cc+1;
                end;
          end;
end;
function RoundWhite(f:boardtype;x,y:integer):boolean;    {判断某位置是否与白子或白势相邻}
var  i  :  integer;
begin
  for i:=1 to 4 do
    if ((x+dir[i,0]) in [1..10])and((y+dir[i,1]) in [1..10]) then
      if f[x+dir[i,0],y+dir[i,1]]='W' then
        begin
          RoundWhite:=true;
          exit;
        end;
  RoundWhite:=false;
end;
function WhiteSearch(l:integer;f:boardtype):real;   {博弈搜索}
var  i,j,s,t           :  integer;
     f0,f1             :  boardtype;
     live,minlive,temp :  real;
     black             :  valuetype;
     InBlack           :  booltype;
begin
  if l>2 then
    begin
      WhiteSearch:=0;
      exit;
    end;
  WhiteSearch:=1;
  minlive:=1;
  for i:=10 downto 1 do
    for j:=10 downto 1 do
      if (f[i,j]=' ')and((roundwhite(f,i,j)) or (v[i,j]<0)) then
        begin
          f0:=f;
          putstone(f0,i,j,'B');
          if f0[i,j]=' ' then continue;
          calc(f0,black,v,InBlack,aa,bb,cc,dd,ee,ff);
          if (ee>0)or(aa+dd+2*ff>=2)or((aa+dd=1)and(bb+cc>=2))or(bb+cc>=4) then continue;
          f1:=f0;
          s:=10;t:=10;
          live:=0;
          while s>0 do
            begin
              f0:=f1;
              if (f0[s,t]=' ')and(InBlack[s,t]) then
                begin
                  putstone(f0,s,t,'W');
                  if f0[s,t]='W' then
                    begin
                      calc(f0,black,v,InBlack,aa,bb,cc,dd,ee,ff);
                      if aa+dd+2*ff+ee*1.5+(bb+cc)/2>=2 then live:=1
                        else
                          begin
                            temp:=WhiteSearch(l+1,f0);
                            if temp>live then live:=temp;
                          end;
                    end;
                end;
              if live=1 then break;
              t:=t-1;
              if t<1 then
                begin
                  t:=10;
                  s:=s-1;
                end;
            end;
          if live<minlive then minlive:=live;
          if minlive=0 then break;
        end;
  WhiteSearch:=minlive;
end;
procedure WhiteTurn;                         {考虑白棋策略}
var  c,i,j,k,xx,yy,n,min,no,count,t :       integer;
     w,maxw                         :       real;
     lst                            :       array [1..100,0..1] of shortint;
     black                          :       valuetype;
     InBlack                        :       booltype;
begin
  count:=0;
  if lastx>0 then
    for i:=1 to 10 do
      for j:=1 to 10 do
        if f[i,j]=' ' then
          begin
            f0:=f;
            PutStone(f0,i,j,'W');
            if f0[lastx,lasty]=' ' then
              begin
                ShowStone(f,i,j,'W');
                exit;
              end;
          end;
  fillchar(InBlack,sizeof(InBlack),false);
  QiWei(f,black,sl,InBlack);
  calc(f,black,sl,InBlack,aa,bb,cc,dd,ee,ff);
  if aa+dd+2*ff+ee*1.5+(bb+cc)/2>=2 then
    begin
      c:=0;
      for i:=1 to 10 do
        for j:=1 to 10 do
          if (f[i,j]=' ')and(InBlack[i,j]) then c:=c+1;
      if c=2 then
        begin
          Form1.state.caption:='白棋活';
          canplay:=false;
          exit;
        end;
    end;
  for i:=10 downto 1 do
    for j:=10 downto 1 do
      if (f[i,j]=' ')and(InBlack[i,j]) then
        begin
          f0:=f;
          PutStone(f0,i,j,'W');
          if f0[i,j]=' ' then continue;
          calc(f0,black,v,InBlack,aa,bb,cc,dd,ee,ff);
          if aa+dd+2*ff+ee*1.5+(bb+cc)/2>=2 then
            begin
              count:=count+1;
              lst[count,0]:=i;
              lst[count,1]:=j;
            end;
        end;
  if count=0 then
    begin
      for i:=10 downto 1 do
        for j:=10 downto 1 do
          if (f[i,j]=' ')and(Inblack[i,j]) then
            begin
              f0:=f;
              PutStone(f0,i,j,'W');
              if f0[i,j]=' ' then continue;
              count:=count+1;
              lst[count,0]:=i;
              lst[count,1]:=j;
            end;
    end;
  j:=1;
  if lastx=1 then
    begin
      i:=j+1;
      while (i<=count)and((lst[i,0]<>lastx)or(lst[i,1]<>lasty+1)) do i:=i+1;
      if i<=count then
        begin
          t:=lst[i,0];lst[i,0]:=lst[j,0];lst[j,0]:=t;
          t:=lst[i,1];lst[i,1]:=lst[j,1];lst[j,1]:=t;
        end;
      j:=j+1;
      i:=j+1;
      while (i<=count)and((lst[i,0]<>lastx)or(lst[i,1]<>lasty-1)) do i:=i+1;
      if i<=count then
        begin
          t:=lst[i,0];lst[i,0]:=lst[j,0];lst[j,0]:=t;
          t:=lst[i,1];lst[i,1]:=lst[j,1];lst[j,1]:=t;
        end;
      j:=j+1;
    end
    else
      if lasty=1 then
        begin
          i:=j+1;
          while (i<=count)and((lst[i,0]<>lastx+1)or(lst[i,1]<>lasty)) do i:=i+1;
          if i<=count then
            begin
              t:=lst[i,0];lst[i,0]:=lst[j,0];lst[j,0]:=t;
              t:=lst[i,1];lst[i,1]:=lst[j,1];lst[j,1]:=t;
            end;
          j:=j+1;
          i:=j+1;
          while (i<=count)and((lst[i,0]<>lastx-1)or(lst[i,1]<>lasty)) do i:=i+1;
          if i<=count then
            begin
              t:=lst[i,0];lst[i,0]:=lst[j,0];lst[j,0]:=t;
              t:=lst[i,1];lst[i,1]:=lst[j,1];lst[j,1]:=t;
            end;
          j:=j+1;
        end;
  xx:=0;yy:=0;
  maxw:=0;
  for i:=1 to count do
    begin
      f0:=f;
      PutStone(f0,lst[i,0],lst[i,1],'W');
      if f0[lst[i,0],lst[i,1]]=' ' then continue;
      calc(f0,black,v,InBlack,aa,bb,cc,dd,ee,ff);
      w:=WhiteSearch(1,f0);
      if w>maxw then
        begin
          maxw:=w;
          xx:=lst[i,0];
          yy:=lst[i,1];
        end;
      if maxw=1 then break;
    end;
  if maxw>0.3 then ShowStone(f,xx,yy,'W')
    else
      begin
        Form1.state.caption:='白棋死';
        canplay:=false;
        exit;
      end;
end;
procedure TForm1.boardMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var      p,q          :  shortint;
begin
  if not canplay then exit;
  if timer1.enabled then exit;
  q:=x div 38+1;
  p:=y div 38+1;
  if (p<1)or(p>10)or(q<1)or(q>10) then exit;
  if f[p,q] in ['B','W'] then
    begin
      Form1.state.caption:='非法着点';
      exit;
    end;
  if Start.Enabled then
    begin
      if PutBlack.Checked then ShowStone(f,p,q,'B')
        else ShowStone(f,p,q,'W');
      NowColor:=' ';
      exit;
    end;
  if ShowStone(f,p,q,NowColor) then
    begin
      lastx:=p;
      lasty:=q;
      WhiteTurn;
    end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var       i,j       :        integer;
          temp      :        char;
begin
  AssignFile(input,'shape.dat');
  reset(input);
  qnum:=0;
  while not eof (input) do
    begin
      qnum:=qnum+1;
      read(n[qnum],sn[qnum]);
      for i:=0 to sn[qnum] do read(temp,ch[qnum,i]);
      for i:=1 to n[qnum] do read(x0[qnum,i],y0[qnum,i]);
      readln;
    end;
  CloseFile(input);
  for i:=1 to 10 do
    for j:=1 to 10 do
    begin
      stone[i,j]:=TImage.Create(Form1.Board);
      stone[i,j].parent:=Form1.GroupBox1;
      stone[i,j].enabled:=false;
      stone[i,j].autosize:=true;
      stone[i,j].left:=j*38-32;
      stone[i,j].top:=i*38-20;
    end;
  Initialize;
end;

procedure TForm1.Exit1Click(Sender: TObject);
begin
  Form1.close;
end;

procedure TForm1.New1Click(Sender: TObject);
begin
  initialize;
end;

procedure TForm1.StartClick(Sender: TObject);
begin
  if first.text='黑方' then NowColor:='B'
    else NowColor:='W';
  state.caption:='';
  first.enabled:=false;
  start.enabled:=false;
  putblack.enabled:=false;
  putwhite.enabled:=false;
  if first.text='白方' then WhiteTurn;
end;
procedure TForm1.newClick(Sender: TObject);
begin
  Initialize;
end;
procedure savegame;
var     i,j,n   :    shortint;
begin
  if form1.SaveFile.Execute then
    begin
      AssignFile(output,form1.SaveFile.Filename);
      rewrite(output);
      n:=0;
      for i:=1 to 10 do
        for j:=1 to 10 do
          if f[i,j]<>' ' then n:=n+1;
      write(n,' ');
      for i:=1 to 10 do
        for j:=1 to 10 do
          if f[i,j]<>' ' then
            begin
              if f[i,j]='B' then write('0 ')
                else write('1 ');
              write(i,' ',j,' ');
            end;
      CloseFile(output);
      form1.timer1.enabled:=true;
      time:=0;
    end;
end;

procedure TForm1.SaveClick(Sender: TObject);
begin
  savegame;
end;
procedure loadgame;
var       i,k,n,x,y   :   integer;
begin
  if form1.OpenFile.Execute then
    begin
      Initialize;
      AssignFile(input,form1.OpenFile.Filename);
      reset(input);
      read(n);
      for i:=1 to n do
        begin
          read(k,x,y);
          if k=0 then ShowStone(f,x,y,'B')
            else ShowStone(f,x,y,'W');
        end;
      CloseFile(input);
      form1.timer1.enabled:=true;
      time:=0;
    end;
end;
procedure TForm1.loadClick(Sender: TObject);
begin
  loadgame;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  time:=time+1;
  if time>10 then timer1.enabled:=false;
end;

procedure TForm1.save1Click(Sender: TObject);
begin
  savegame;
end;

procedure TForm1.load1Click(Sender: TObject);
begin
  loadgame;
end;

procedure TForm1.helpClick(Sender: TObject);
begin
  Form2.Show;
end;

end.

