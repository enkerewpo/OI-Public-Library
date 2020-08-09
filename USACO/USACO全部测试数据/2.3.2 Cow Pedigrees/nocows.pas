{
ID:asiapea1
PROG:nocows
LANG:PASCAL
}
const
   kkk = 9901;
var
   i , j , k , n : longint;
   tree : array[ 0 .. 200 , 0 .. 200 ]of longint;
   left , right : array[ 0 .. 200 ]of longint;
procedure try( n : longint );
   var
     i , j : longint;
   begin
     i := 1;
     repeat
       if tree[ i , 0 ] = 0 then
         try( i );
       if tree[ n - i - 1 , 0 ] = 0 then
         try( n - i - 1 );
       for j := 1 to k do
         left[ j ] := ( left[ j - 1 ] + tree[ i , j ] ) mod kkk;
       for j := 1 to k do
         right[ j ] := ( right[ j - 1 ] + tree[ n - i - 1 , j ] ) mod kkk;
       for j := 2 to k do begin
         tree[ n , j ] := ( tree[ n , j ] + left[ j - 2 ] * tree[ n - i - 1 , j - 1 ] ) mod kkk;
         tree[ n , j ] := ( tree[ n , j ] + tree[ i , j - 1 ] * right[ j - 2 ] ) mod kkk;
         tree[ n , j ] := ( tree[ n , j ] + tree[ i , j - 1 ] * tree[ n - i - 1 , j - 1 ] ) mod kkk;
       end;
       i := i + 2;
     until i > n - 1 ;
     tree[ n , 0 ] := 1;
   end;
begin
   assign( input , 'nocows.in' );
   reset( input );
   assign( output , 'nocows.out' );
   rewrite( output );
   readln( n , k );
   if n mod 2 = 0 then begin
     writeln( 0 );
     close( output );
     halt;
   end;
   fillchar( tree , sizeof( tree ) , 0 );
   tree[ 1 , 0 ] := 1;
   tree[ 1 , 1 ] := 1;
   try( n );
   writeln( tree[ n , k ] mod kkk );
   close( output );
end.
