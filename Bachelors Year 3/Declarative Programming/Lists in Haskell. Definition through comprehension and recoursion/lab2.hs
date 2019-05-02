import           Test.QuickCheck


---------------------------------------------
-------RECURSIE: FIBONACCI-------------------
---------------------------------------------

fibonacciCazuri :: Integer -> Integer
fibonacciCazuri n
  | n < 2     = n
  | otherwise = fibonacciCazuri (n - 1) + fibonacciCazuri (n - 2)

fibonacciEcuational :: Integer -> Integer
fibonacciEcuational 0 = 0
fibonacciEcuational 1 = 1
fibonacciEcuational n =
    fibonacciEcuational (n - 1) + fibonacciEcuational (n - 2)

{-| @fibonacciLiniar@ calculeaza @F(n)@, al @n@-lea element din secvența
Fibonacci în timp liniar, folosind funcția auxiliară @fibonacciPereche@ care,
dat fiind @n >= 1@ calculează perechea @(F(n-1), F(n))@, evitănd astfel dubla
recursie. Completați definiția funcției fibonacciPereche.

Indicație:  folosiți matching pe perechea calculată de apelul recursiv.
-}
fibonacciLiniar :: Integer -> Integer
fibonacciLiniar 0 = 0
fibonacciLiniar n = snd (fibonacciPereche n)
  where
    fibonacciPereche :: Integer -> (Integer, Integer)
    fibonacciPereche 1 = (0, 1)
    fibonacciPereche n = 
      ((snd prevfibo), (fst prevfibo) + ((snd prevfibo))) 
      where prevfibo = (fibonacciPereche(n-1))

prop_fib :: Integer -> Property
prop_fib x = (x >= 0 && x <= 20) ==> fibonacciEcuational x == fibonacciLiniar x

---------------------------------------------
----------RECURSIE PE LISTE -----------------
---------------------------------------------
semiPareRecDestr :: [Int] -> [Int]
semiPareRecDestr l
  | null l    = l
  | even h    = h `div` 2 : t'
  | otherwise = t'
  where
    h = head l
    t = tail l
    t' = semiPareRecDestr t

semiPareRecEq :: [Int] -> [Int]
semiPareRecEq [] = []
semiPareRecEq (h:t)
  | even h    = h `div` 2 : t'
  | otherwise = t'
  where t' = semiPareRecEq t

inInterval :: Integer -> Integer -> [Integer] -> [Integer]
inInterval _ _ [] = []
inInterval a b (h:t)
  | (h>=a && h<=b) = h:t'
  | otherwise = t'
  where t' = inInterval a b t

---------------------------------------------
----------DESCRIERI DE LISTE ----------------
---------------------------------------------
semiPareComp :: [Int] -> [Int]
semiPareComp l = [ x `div` 2 | x <- l, even x ]

prop_semiPare :: [Int] -> Bool
prop_semiPare l = semiPareRecEq l == semiPareComp l

inInterval2 :: Integer -> Integer -> [Integer] -> [Integer]
inInterval2 a b l = [ x | x <- l, (x>=a && x<=b) ]

pozitive :: [Integer] -> Int
pozitive [] = 0;
pozitive (h:t) = if(h >= 0) then (1 + aux) else aux where aux = pozitive t

pozitive2 :: [Integer] -> Int
pozitive2 l = length l2 where l2 = [ x | x <- l, x >= 0 ]

testInInterval :: Integer -> Integer -> [Integer] -> Bool
testInInterval min max l = cmp (inInterval min max l)  (inInterval2 min max l) 
    where
        cmp :: [Integer] -> [Integer] -> Bool
        cmp [] [] = True
        cmp (h1:t1) (h2:t2) 
            | h1 == h2 = cmp t1 t2
            | otherwise = False
    
testPozitive :: [Integer] -> Bool
testPozitive l = (pozitive l) == (pozitive2 l)

fibs = 0:1:[a+b|(a, b)<- zip fibs(tail fibs)]
--take 10 fibs

pozitiiImpareRec :: [Integer] -> [Integer]
pozitiiImpareRec l = pozitiiImpareRecAux l 0
        where
            pozitiiImpareRecAux :: [Integer] -> Integer -> [Integer]
            pozitiiImpareRecAux [] _ = []
            pozitiiImpareRecAux (h:t) i
                | odd h = (i:(pozitiiImpareRecAux t (i+1)))
                | otherwise = (pozitiiImpareRecAux t (i+1))

pozitiiImpare2 :: [Integer] -> [Integer]
pozitiiImpare2 l = [ (snd x) | x <- (zip l [0..]), odd (fst x) ]

testPozitiiImpare :: [Integer] -> Bool
testPozitiiImpare l = cmp (pozitiiImpareRec l)  (pozitiiImpare2 l) 
    where
        cmp :: [Integer] -> [Integer] -> Bool
        cmp [] [] = True
        cmp (h1:t1) (h2:t2) 
            | h1 == h2 = cmp t1 t2
            | otherwise = False

---------------------------------------------
--------------- DRUMURI ---------------------
---------------------------------------------
data Directie = Nord | Sud | Est | Vest
                deriving (Eq, Show)

type Punct = (Integer, Integer)

origine :: Punct
origine = (0, 0)

type Drum = [Directie]

miscare :: Punct -> Drum -> Punct
miscare p [] = p
miscare p (h:t) = miscare (miscarePunct p h) t
  where miscarePunct :: Punct -> Directie -> Punct
        miscarePunct (a, b) Nord = (a, b + 1)
        miscarePunct (a, b) Sud = (a, b - 1)
        miscarePunct (a, b) Est = (a - 1, b)
        miscarePunct (a, b) Vest = (a + 1, b)

eqDrum :: Drum -> Drum -> Bool
eqDrum d1 d2
      | miscare origine d1 == miscare origine d2 = True
      | otherwise = False

