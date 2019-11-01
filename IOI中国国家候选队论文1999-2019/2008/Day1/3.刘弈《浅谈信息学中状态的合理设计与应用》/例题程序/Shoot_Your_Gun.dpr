program doshide;

{$R-,Q-,S-}

const
    dir : array [ 1..4, 1..2 ] of longint = ( ( - 1, - 1 ), ( 1, - 1 ), ( 1, 1 ), ( - 1, 1 ) );
    opp : array [ 1..4, 1..4 ] of longint = ( ( 2, 1, 4, 3 ), ( 4, 3, 2, 1 ), ( 2, 1, 4, 3 ), ( 4, 3, 2, 1 ) );
    op : array [ 1..4 ] of longint = ( 3, 4, 1, 2 );
    maxn = 50 + 1;
    maxm = 2000000;
    infinity = 100000000;

type
    Point = array [ 1..3 ] of longint;

var
    m : array [ 1..3, 1..maxn ] of Point;
    turn : array [ 1..3, 1..maxn ] of longint;
    visit : array [ 0..maxm, 1..4 ] of boolean;
    first : array [ 1..maxn ] of longint;
    n : array [ 1..3 ] of longint;
    ans, task : longint;

procedure ReadData;

var
    i : longint;

    procedure GetInf( k : longint );

    var
        i, j : longint;

    begin
        for i := 1 to n[ k ] do
            begin
                read( m[ k ][ i ][ 1 ], m[ k ][ i ][ 2 ] );
                m[ k ][ i ][ 1 ] := m[ k ][ i ][ 1 ] * 2;
                m[ k ][ i ][ 2 ] := m[ k ][ i ][ 2 ] * 2;
            end;
        m[ k ][ n[ k ] + 1 ] := m[ k ][ 1 ];
        for i := 1 to n[ k ] do
            begin
                if ( m[ k ][ i + 1 ][ 2 ] - m[ k ][ i ][ 2 ] < 0 ) then
                    m[ k ][ i ][ 3 ] := 1;
                if ( m[ k ][ i + 1 ][ 1 ] - m[ k ][ i ][ 1 ] > 0 ) then
                    m[ k ][ i ][ 3 ] := 2;
                if ( m[ k ][ i + 1 ][ 2 ] - m[ k ][ i ][ 2 ] > 0 ) then
                    m[ k ][ i ][ 3 ] := 3;
                if ( m[ k ][ i + 1 ][ 1 ] - m[ k ][ i ][ 1 ] < 0 ) then
                    m[ k ][ i ][ 3 ] := 4;
            end;
        for i := 1 to n[ k ] do
            begin
                j := i + 1;
                if ( j > n[ k ] ) then
                    j := 1;
                if ( m[ k ][ i ][ 3 ] = 1 ) and ( m[ k ][ j ][ 3 ] = 2 ) then
                    turn[ k ][ i + 1 ] := 3;
                if ( m[ k ][ i ][ 3 ] = 1 ) and ( m[ k ][ j ][ 3 ] = 4 ) then
                    turn[ k ][ i + 1 ] := 4;
                if ( m[ k ][ i ][ 3 ] = 2 ) and ( m[ k ][ j ][ 3 ] = 1 ) then
                    turn[ k ][ i + 1 ] := 4;
                if ( m[ k ][ i ][ 3 ] = 2 ) and ( m[ k ][ j ][ 3 ] = 3 ) then
                    turn[ k ][ i + 1 ] := 1;
                if ( m[ k ][ i ][ 3 ] = 3 ) and ( m[ k ][ j ][ 3 ] = 2 ) then
                    turn[ k ][ i + 1 ] := 2;
                if ( m[ k ][ i ][ 3 ] = 3 ) and ( m[ k ][ j ][ 3 ] = 4 ) then
                    turn[ k ][ i + 1 ] := 1;
                if ( m[ k ][ i ][ 3 ] = 4 ) and ( m[ k ][ j ][ 3 ] = 1 ) then
                    turn[ k ][ i + 1 ] := 2;
                if ( m[ k ][ i ][ 3 ] = 4 ) and ( m[ k ][ j ][ 3 ] = 3 ) then
                    turn[ k ][ i + 1 ] := 3;
            end;
        turn[ k ][ 1 ] := turn[ k ][ n[ k ] + 1 ];
    end;

begin
    read( n[ 1 ] );
    if ( n[ 1 ] = 0 ) then
        exit;
    read( n[ 2 ], n[ 3 ] );
    for i := 1 to 3 do
        GetInf( i );
end;

procedure Walk( x, y, d : longint );

var
    min, a, b, id : longint;
    times, num : longint;

    function Area( x, y : longint; p1, p2 : Point ) : longint;

    begin
        Area := ( x - p2[ 1 ] ) * ( p1[ 2 ] - p2[ 2 ] ) - ( p1[ 1 ] - p2[ 1 ] ) * ( y - p2[ 2 ] );
    end;

    function Dot( p1, p2 : Point; x, y : longint ) : longint;

    begin
        Dot := ( p1[ 1 ] - x ) * ( p2[ 1 ] - x ) + ( p1[ 2 ] - y ) * ( p2[ 2 ] - y );
    end;

    function Cross( var x1, y1, dist : longint; p1, p2 : Point ) : boolean;

    begin
        x1 := x + dist * dir[ d ][ 1 ];
        y1 := y + dist * dir[ d ][ 2 ];
        Cross := ( ( Area( x1, y1, p1, p2 ) = 0 ) and ( dot( p1, p2, x1, y1 ) < 0 ) ) or ( ( p1[ 1 ] = x1 ) and ( p1[ 2 ] = y1 ) );
    end;

    function Dist( p1, p2 : Point ) : longint;

    begin
        if ( p1[ 1 ] = p2[ 1 ] ) then
            Dist := abs( x - p1[ 1 ] )
        else
            Dist := abs( y - p1[ 2 ] );
    end;

    procedure Process;

    var
        k, i, x1, y1, distance : longint;

    begin
        min := infinity;
        a := 0;
        b := 0;
        id := 0;
        num := 0;
        for k := 1 to 3 do
            for i := 1 to n[ k ] do
                begin
                    distance := dist( m[ k ][ i ], m[ k ][ i + 1 ] );
                    if ( distance > 0 ) and ( distance < min ) and ( Cross( x1, y1, distance, m[ k ][ i ], m[ k ][ i + 1 ] ) ) then
                        begin
                            min := distance;
                            a := x1;
                            b := y1;
                            num := i;
                            id := k;
                        end;
                end;
    end;

begin
    times := 0;
    inc( times );
    repeat
        if ( times - 2 > ans ) then
            exit;
        Process;
        if ( min = infinity ) or ( id = 1 ) then
            begin
                if ( id = 1 ) then
                    visit[ first[ num ] + 1 + abs( a - m[ 1 ][ num ][ 1 ] ) + abs( b - m[ 1 ][ num ][ 2 ] ) ][ op[ d ] ] := true;
                exit;
            end;
        if ( id = 2 ) then
            break;
        if ( a = m[ id ][ num ][ 1 ] ) and ( b = m[ id ][ num ][ 2 ] ) then
            begin
                if ( turn[ id ][ num ] = d ) or ( turn[ id ][ num ] = op[ d ] ) then
                    exit; 
                dec( times );
            end
        else
            d := opp[ m[ id ][ num ][ 3 ] ][ d ];
        x := a;
        y := b;
    until ( false );
    if ( times - 1 < ans ) then
        ans := times - 1;
end;

procedure Work;

var
    i, k, x, y, a, b, l : longint;

begin
    ans := infinity;
    l := 0;
    for i := 1 to n[ 1 ] do
        begin
            x := ( m[ 1 ][ i + 1 ][ 1 ] - m[ 1 ][ i ][ 1 ] );
            y := ( m[ 1 ][ i + 1 ][ 2 ] - m[ 1 ][ i ][ 2 ] );
            if ( x <> 0 ) then
                x := x div abs( x );
            if ( y <> 0 ) then
                y := y div abs( y );
            a := m[ 1 ][ i ][ 1 ];
            b := m[ 1 ][ i ][ 2 ];
            first[ i ] := l;
            while ( a <> m[ 1 ][ i + 1 ][ 1 ] ) or ( b <> m[ 1 ][ i + 1 ][ 2 ] ) do
                begin
                    inc( l );
                    inc( a, x );
                    inc( b, y );
                end;
        end;    
    for i := 1 to n[ 1 ] do
        begin
            x := ( m[ 1 ][ i + 1 ][ 1 ] - m[ 1 ][ i ][ 1 ] );
            y := ( m[ 1 ][ i + 1 ][ 2 ] - m[ 1 ][ i ][ 2 ] );
            if ( x <> 0 ) then
                x := x div abs( x );
            if ( y <> 0 ) then
                y := y div abs( y );
            a := m[ 1 ][ i ][ 1 ];
            b := m[ 1 ][ i ][ 2 ];
            while ( a <> m[ 1 ][ i + 1 ][ 1 ] ) or ( b <> m[ 1 ][ i + 1 ][ 2 ] ) do
                begin
                    for k := 1 to 4 do
                        if ( not visit[ first[ i ] + 1 + abs( a - m[ 1 ][ i ][ 1 ] ) + abs( b - m[ 1 ][ i ][ 2 ] ) ][ k ] ) then
                            Walk( a, b, k );
                    inc( a, x );
                    inc( b, y );
                end;
        end;
    if ( ans = infinity ) then
        ans := - 1;
    writeln( 'Case ', task, ': ', ans );
end;

begin
    assign( input, 'gun.in' );
    reset( input );
    assign( output, 'gun.out' );
                    {gun.ans}
    rewrite( output );

    task := 0;
    repeat
        fillchar( visit, sizeof( visit ), 0 );
        inc( task );
        ReadData;
        if ( n[ 1 ] = 0 ) then
            break;
        Work;
    until ( false );

    close( input );
    close( output );
end.
