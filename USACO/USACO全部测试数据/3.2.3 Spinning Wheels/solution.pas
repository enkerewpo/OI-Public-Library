{
ID:asiapea1
PROG:spin
LANG:PASCAL
}
program spin;
var
  i,j,k,s:word;
  wheel:array[1..5,1..5,1..2]of word;
  speed:array[1..5]of word;
  num:array[1..5]of word;
  found:boolean;
  hash:array[0..359]of byte;
begin
  assign(input,'spin.in');
  assign(output,'spin.out');
  reset(input);
  rewrite(output);
  for i:=1 to 5 do
  begin
    read(speed[i]);
    read(num[i]);
    for j:=1 to num[i] do
      read(wheel[i,j,1],wheel[i,j,2]);
    readln;
  end;
  found:=false;
  for i:=0 to 359 do
  begin
    fillchar(hash,sizeof(hash),0);
    for j:=1 to 5 do
      for k:=1 to num[j] do
        for s:=wheel[j,k,1] to wheel[j,k,1]+wheel[j,k,2] do
          inc(hash[s mod 360]);
    for s:=0 to 359 do
      if hash[s]=5 then
      begin
        writeln(i);
        found:=true;
        break;
      end;
    if found then
      break;
    for j:=1 to 5 do
      for k:=1 to num[j] do
        wheel[j,k,1]:=(wheel[j,k,1]+speed[j]) mod 360;
  end;
  if not found then
    writeln('none');
  close(output);
end.