program doshide;

const
    maxn = 100000;

var
    m : array [ 0..maxn, 1..2 ] of longint;
    p, value, times, ans : array [ 0..maxn ] of longint;
    n : longint;

procedure Swap( var a, b : longint );

var
    tmp : longint;

begin
    tmp := a;
    a := b;
    b := tmp;
end;

procedure Qsort( s, t : longint );

var
    i, j, x : longint;

begin
    i := s;
    j := t;
    x := p[ ( s + t ) shr 1 ];
    repeat
        while ( m[ p[ i ] ][ 2 ] < m[ x ][ 2 ] ) do
            inc( i );
        while ( m[ p[ j ] ][ 2 ] > m[ x ][ 2 ] ) do
            dec( j );
        if ( i <= j ) then
            begin
                Swap( p[ i ], p[ j ] );
                inc( i );
                dec( j );
            end;
    until ( i > j );
    if ( s < j ) then
        Qsort( s, j );
    if ( i < t ) then
        Qsort( i, t );
end;

procedure ReadData;

var
    i : longint;

begin
    read( n );
    for i := 1 to n do
        begin
            read( m[ i ][ 1 ], m[ i ][ 2 ] );
            p[ i ] := i;
        end;
    Qsort( 1, n );
end;

procedure Work;

var
    i, id : longint;

    procedure GetValue( x : longint );

    var
        i : longint;

    begin
        inc( id );
        for i := 0 to x shr 1 do
            begin
                times[ i * i mod x ] := id;
                value[ i * i mod x ] := i;
            end;
    end;

begin
    id := 0;
    for i := 1 to n do
        begin
            if ( m[ p[ i ] ][ 2 ] <> m[ p[ i - 1 ] ][ 2 ] ) then
                GetValue( m[ p[ i ] ][ 2 ] );
            if ( times[ m[ p[ i ] ][ 1 ] ] <> id ) then
                ans[ p[ i ] ] := - 1
            else
                ans[ p[ i ] ] := value[ m[ p[ i ] ][ 1 ] ];
        end;
    for i := 1 to n do
        if ( ans[ i ] = - 1 ) then
            writeln( 'No root' )
        else
            writeln( ans[ i ], ' ', m[ i ][ 2 ] - ans[ i ] );
end;

begin
    assign( input, 'ural1132.in' );
    reset( input );
    assign( output, 'ural1132.out' );
    rewrite( output );

    ReadData;
    Work;

    close( input );
    close( output );
end.
