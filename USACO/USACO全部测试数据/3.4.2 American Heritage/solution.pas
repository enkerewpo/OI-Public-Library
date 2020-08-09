{
ID: asiapea1
PROG: heritage
LANG: PASCAL
}
var
  inorder,preorder,postorder:string[26];
  l:byte;
//
function getpost (f1,e1,f2,e2:byte):string[26];
var
  p1,p2:byte;
begin
  if f1>e1 then
    exit('');
  p2:=pos(preorder[f1],inorder);
  p1:=p2-f2+f1;
  getpost:=getpost(f1+1,p1,f2,p2-1)+getpost(p1+1,e1,p2+1,e2)+preorder[f1];
end;
//
begin
  assign(input,'heritage.in');
  assign(output,'heritage.out');
  reset(input);
  rewrite(output);
  readln(inorder);
  readln(preorder);
  l:=length(preorder);
  postorder:=getpost(1,l,1,l);
  writeln(postorder);
  close(output);
end.