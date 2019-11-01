unit Prime;

interface

  function isPrime(X : Longint) : Boolean;
  function isPrimeQ(X : Longint) : Boolean;
  {
    History :
      Created : Dec. 2004, Weidong Hu
  }

implementation

  function isPrime(X : Longint) : Boolean;
  var
    i : longint;
  begin
    isPrime := false;
    if x < 2 then exit;
    for i := 2 to trunc(sqrt(x)) do
      if x mod i = 0 then
        exit;
    isPrime := true;
  end;

  function getExpMod(base, exp, _mod : longint) : longint;
  var
    tmp : int64;
  begin
    if exp = 0 then getExpMod := 1 else
    begin
      tmp := getExpMod(base, exp shr 1, _mod);
      tmp := tmp * tmp mod _mod;
      if odd(exp) then
        tmp := tmp * base mod _mod;
      getExpMod := tmp;
    end;
  end;

  function isPrimeQ(X : Longint) : Boolean;
  { Rabin-Miller Strong Pseudoprime Test }
  const
    S : array[1..4] of longint = (2, 3, 5, 7{, 11});
  var
    d, m : longint;
    tmp : int64;
    a : longint;
    i : integer;
    OK : boolean;
  begin
    isPrimeQ := false;
    if x < 2 then exit;
    d := X - 1;
    while d and 1 = 0 do
      d := d shr 1;
    for i := Low(S) to High(S) do
    begin
      OK := false;
      a := S[i];
      if a >= X then break;
      tmp := getExpMod(a, d, X);
      if (tmp = 1) or (tmp = x - 1) then OK := true else
      begin
        m := d shl 1;
        while m < X do
        begin
          tmp := tmp * tmp mod x;
          if tmp = x - 1 then
          begin
            OK := true;
            break;
          end;
          m := m shl 1;
        end;
      end;
      if not OK then exit;
    end;
    isPrimeQ := true;
  end;

end.
