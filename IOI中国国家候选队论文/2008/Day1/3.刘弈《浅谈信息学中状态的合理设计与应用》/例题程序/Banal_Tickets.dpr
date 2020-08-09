program doshide;

const
    maxn = 18;
    base = 9;
    maxm = 50000;
    sum : array [ 1..9, 1..4 ] of longint =
        ( ( 0, 0, 0, 0 ), ( 1, 0, 0, 0 ), ( 0, 1, 0 ,0 ), ( 2, 0, 0, 0 ), ( 0, 0, 1, 0 ), ( 1, 1, 0, 0 ), ( 0, 0, 0, 1 ), ( 3, 0, 0, 0 ), ( 0, 2, 0, 0 ) );

type
    Tnumber = array [ 0..6 ] of longint;
    ArrayType = array [ 0..1, 1..maxm ] of TNumber;
    NumberType = array [ 1..maxn ] of char;

var
    dpa, dpb : ArrayType;
    a, b : NumberType;
    d : array [ 0..base ] of longint;
    queue : array [ 1..maxm, 1..4 ] of longint;
    dist : array [ 1..maxm ] of longint;
    p : array [ -1..maxn * 3, 0..maxn * 2, 0..maxn, 0..maxn ] of longint;
    n, final, node : longint;
    ans, m : array [ 0..10 ] of longint;

procedure ReadData;

var
    i : longint;

begin
    readln( n );
    for i := 1 to n do
        read( a[ i ] );
    for i := 1 to n do
        read( b[ i ] );
end;

procedure PreWork;

var
    h, t, i : longint;

begin
    h := 0;
    t := 1;
    queue[ 1 ][ 1 ] := 0;
    queue[ 1 ][ 2 ] := 0;
    queue[ 1 ][ 3 ] := 0;
    queue[ 1 ][ 4 ] := 0;
    dist[ 1 ] := 0;
    p[ 0 ][ 0 ][ 0 ][ 0 ] := 1;
    repeat
        inc( h );
        if ( dist[ h ] = n ) then
            continue;
        for i := 1 to 9 do
            if ( p[ queue[ h ][ 1 ] + sum[ i ][ 1 ] ][ queue[ h ][ 2 ] + sum[ i ][ 2 ] ][ queue[ h ][ 3 ] + sum[ i ][ 3 ] ][ queue[ h ][ 4 ] + sum[ i ][ 4 ] ] = 0 ) then
                begin
                    inc( t );
                    queue[ t ][ 1 ] := queue[ h ][ 1 ] + sum[ i ][ 1 ];
                    queue[ t ][ 2 ] := queue[ h ][ 2 ] + sum[ i ][ 2 ];
                    queue[ t ][ 3 ] := queue[ h ][ 3 ] + sum[ i ][ 3 ];
                    queue[ t ][ 4 ] := queue[ h ][ 4 ] + sum[ i ][ 4 ];
                    dist[ t ] := dist[ h ] + 1;
                    p[ queue[ t ][ 1 ] ][ queue[ t ][ 2 ] ][ queue[ t ][ 3 ] ][ queue[ t ][ 4 ] ] := t;
                end;
    until ( h >= t );
    inc( t );
    queue[ t ][ 1 ] := - 1;
    queue[ t ][ 2 ] := 0;
    queue[ t ][ 3 ] := 0;
    queue[ t ][ 4 ] := 0;
    node := t;
end;

procedure Plus( var a, b : TNumber );

var
    i, k : longint;

begin
    if ( a[ 0 ] = 0 ) then
        a[ 0 ] := 1;
    k := a[ 0 ];
    if ( b[ 0 ] > k ) then
        k := b[ 0 ];
    for i := 1 to k do
        inc( a[ i ], b[ i ] );
    for i := 1 to k do
        if ( a[ i ] >= d[ base ] ) then
            begin
                inc( a[ i + 1 ] );
                dec( a[ i ], d[ base ] );
            end;
    if ( a[ a[ 0 ] + 1 ] > 0 ) then
        inc( a[ 0 ] );
end;

procedure Mul( var a, b : TNumber );

var
    i, j : longint;
    w : int64;

begin
    if ( a[ 0 ] = 0 ) then
        a[ 0 ] := 1;
    if ( b[ 0 ] = 0 ) then
        b[ 0 ] := 1;
    for i := 1 to a[ 0 ] do
        for j := 1 to b[ 0 ] do
            begin
                w := int64( a[ i ] ) * b[ j ] + ans[ i + j - 1 ];
                ans[ i + j - 1 ] := w mod d[ base ];
                inc( ans[ i + j ], w div d[ base ] );
            end;
    i := a[ 0 ] + b[ 0 ] - 1;
    while ( ans[ i + 1 ] >= d[ base ] ) do
        begin
            inc( i );
            inc( ans[ i + 1 ], ans[ i ] div d[ base ] );
            ans[ i ] := ans[ i ] mod d[ base ];
        end;
    while ( ans[ i + 1 ] > 0 ) do
        inc( i );
    while ( i > 1 ) and ( ans[ i ] = 0 ) do
        dec( i );
    if ( i > ans[ 0 ] ) then
        ans[ 0 ] := i;
end;

procedure Minus( k : longint );

var
    i : longint;

begin
    m[ 0 ] := 1;
    m[ 1 ] := 1;
    for i := 1 to k do
        if ( int64( m[ m[ 0 ] ] ) * 10 < d[ base ] ) then
            m[ m[ 0 ] ] := m[ m[ 0 ] ] * 10
        else
            begin
                m[ m[ 0 ] ] := 0;
                inc( m[ 0 ] );
                m[ m[ 0 ] ] := 1;
            end;
    for i := 1 to m[ 0 ] do
        begin
            ans[ i ] := m[ i ] - ans[ i ];
            if ( ans[ i ] < 0 ) then
                begin
                    inc( ans[ i ], d[ base ] );
                    dec( m[ i + 1 ] );
                end;
        end;
    ans[ 0 ] := m[ 0 ];
    while ( ans[ 0 ] > 1 ) and ( ans[ ans[ 0 ] ] = 0 ) do
        dec( ans[ 0 ] );
end;

procedure Print;

var
    i, j : longint;

begin
    write( ans[ ans[ 0 ] ] );
    for i := ans[ 0 ] - 1 downto 1 do
        for j := base - 1 downto 0 do
            write( ans[ i ] div d[ j ] mod 10 );
    writeln;
end;

procedure Calculate( var m : NumberType; var dp : ArrayType );

var
    now, i, j, num : longint;

begin
    dp[ 0 ][ 1 ][ 0 ] := 1;
    dp[ 0 ][ 1 ][ 1 ] := 1;
    i := 0;
    for now := 1 to n do
        begin
            i := i xor 1;
            fillchar( dp[ i ], sizeof( dp[ i ] ), 0 );
            for j := 1 to node - 1 do
                if not ( ( dp[ i xor 1 ][ j ][ 0 ] = 0 ) or ( ( dp[ i xor 1 ][ j ][ 0 ] = 1 ) and ( dp[ i xor 1 ][ j ][ 1 ] = 0 ) ) ) then
                    if ( m[ now ] = '?' ) then
                        begin
                            Plus( dp[ i ][ node ], dp[ i xor 1 ][ j ] );
                            for num := 1 to 9 do
                                Plus( dp[ i ][ p[ queue[ j ][ 1 ] + sum[ num ][ 1 ] ][ queue[ j ][ 2 ] + sum[ num ][ 2 ] ][ queue[ j ][ 3 ] + sum[ num ][ 3 ] ][ queue[ j ][ 4 ] + sum[ num ][ 4 ] ] ], dp[ i xor 1 ][ j ] );
                        end
                    else
                        if ( m[ now ] = '0' ) then
                            Plus( dp[ i ][ node ], dp[ i xor 1 ][ j ] )
                        else
                            begin
                                num := ord( m[ now ] ) - ord( '0' );
                                Plus( dp[ i ][ p[ queue[ j ][ 1 ] + sum[ num ][ 1 ] ][ queue[ j ][ 2 ] + sum[ num ][ 2 ] ][ queue[ j ][ 3 ] + sum[ num ][ 3 ] ][ queue[ j ][ 4 ] + sum[ num ][ 4 ] ] ], dp[ i xor 1 ][ j ] );
                            end;
            if ( m[ now ] = '?' ) then
                for j := 1 to 10 do
                    Plus( dp[ i ][ node ], dp[ i xor 1 ][ node ] )
            else
                Plus( dp[ i ][ node ], dp[ i xor 1 ][ node ] );
        end;
    final := i;
end;

procedure Work;

var
    i, w : longint;

begin
    d[ 0 ] := 1;
    for i := 1 to base do
        d[ i ] := d[ i - 1 ] * 10;
    Calculate( a, dpa );
    Calculate( b, dpb );
    ans[ 0 ] := 1;
    ans[ 1 ] := 0;
    Mul( dpa[ final ][ node ], dpb[ final ][ node ] );
    for i := 1 to node - 1 do
        Mul( dpa[ final ][ i ], dpb[ final ][ i ] );
    Print;
    w := 0;
    for i := 1 to n do
        inc( w, ord( a[ i ] = '?' ) + ord( b[ i ] = '?' ) );
    Minus( w );
    Print;
end;

begin
    assign( input, 'pku1608.in' );
    reset( input );
    assign( output, 'pku.out' );
                    {36.out}
    rewrite( output );

    ReadData;
    PreWork;
    Work;

    close( input );
    close( output );
end.
