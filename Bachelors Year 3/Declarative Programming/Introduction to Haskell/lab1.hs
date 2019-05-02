import Test.QuickCheck

myInt = 5555555555555555555555555555555555555555555555555555555555555555555555555555555555555

double :: Integer -> Integer
double x = x+x

triple :: Integer -> Integer
triple x = 3*x

penta :: Integer -> Integer
penta x = 5*x

test :: Integer -> Bool
test x = (double x + triple x) == (penta x)

maxim :: Integer -> Integer -> Integer
maxim x y =
    if ( x > y )
        then x
        else y

maxim3 :: Integer -> Integer -> Integer -> Integer
maxim3 x y z =
    if ( x > y )
        then 
            if ( x > z)
                then x
                else z
        else 
            if ( y > z)
                then y
                else z

maxim4 :: Integer -> Integer -> Integer -> Integer -> Integer
maxim4 x y z w =
    let
        u = maxim x y
    in
        let
            v = maxim u z
        in
            maxim v w

testMaxim4 :: Integer -> Integer -> Integer -> Integer -> Bool
testMaxim4 x y z w = maxim4 x y z w >= x && maxim4 x y z w >= y && maxim4 x y z w >= z && maxim4 x y z w >= w

