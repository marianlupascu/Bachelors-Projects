import Numeric.Natural
import Test.QuickCheck
import Data.List (genericIndex) 
import Data.List

produsRec :: [Integer] -> Integer
produsRec l = produsRecAux l 1 where 
  produsRecAux :: [Integer] -> Integer -> Integer
  produsRecAux [] n = n
  produsRecAux (h:t) n = produsRecAux t n*h

produsFold :: [Integer] -> Integer
produsFold l = foldr (*) 1 l

prop_produs :: [Integer] -> Bool
prop_produs i = produsRec i == produsFold i

andRec :: [Bool] -> Bool
andRec [] = True
andRec (False : _) = False
andRec (h:t) = andRec t

andFold :: [Bool] -> Bool
andFold l = foldr (&&) True l

prop_and :: [Bool] -> Bool
prop_and i = andFold i == andRec i

concatRec :: [[a]] -> [a]
concatRec l = concatRecAux l [] where
  concatRecAux :: [[a]] -> [a] -> [a]
  concatRecAux [] r = r 
  concatRecAux (h:t) r = concatRecAux t (r++h)

concatFold :: [[a]] -> [a]
concatFold l = foldr (++) [] l

prop_concat :: Eq a => [[a]] -> Bool
prop_concat i = concatRec i == concatFold i

rmChar :: Char -> String -> String
rmChar _ [] = []
rmChar c (h:t) = if c == h 
  then rmChar c t
  else [h] ++ (rmChar c t)

rmCharsRec :: String -> String -> String
rmCharsRec [] s = s
rmCharsRec (h:t) s = rmCharsRec t (rmChar h s)
 
test_rmchars :: Bool
test_rmchars = rmCharsRec ['a'..'l'] "fotbal" == "ot"

rmCharsFold :: String -> String -> String
rmCharsFold l s = foldr (rmChar) s l

prop_rmChars :: String -> String -> Bool
prop_rmChars s l = rmCharsFold s l == rmCharsRec s l

foldr_ :: (a -> b -> b) -> b -> ([a] -> b)
foldr_ op unit = f
  where
    f []     = unit
    f (a:as) = a `op` f as

-------------------------------------------------------------------------
--examen
takeUntil :: (a -> Bool) -> [a] -> [a]
takeUntil p [] = []
takeUntil p (h:t) 
    | p h == False = (h:takeUntil p t)
    | otherwise = []

takeUntilFoldr :: (a -> Bool) -> [a] -> [a]
takeUntilFoldr p = foldr op unit
  where
    unit = []
    a `op` rezultat
      | p a == False = (a:rezultat)
      | otherwise    = []
-------------------------------------------------------------------------

sumaPatrateImpare :: [Integer] -> Integer
sumaPatrateImpare []     = 0
sumaPatrateImpare (a:as)
  | odd a = a * a + sumaPatrateImpare as
  | otherwise = sumaPatrateImpare as

sumaPatrateImpareFold :: [Integer] -> Integer
sumaPatrateImpareFold = foldr op unit
  where
    unit = 0
    a `op` suma
      | odd a     = a * a + suma
      | otherwise = suma

map_ :: (a -> b) -> [a] -> [b]
map_ f []     = []
map_ f (a:as) = f a : map_ f as

mapFold :: (a -> b) -> [a] -> [b]
mapFold f = foldr op unit
  where
    unit = []
    a `op` l = f a : l

filter_ :: (a -> Bool) -> [a] -> [a]
filter_ p [] = []
filter_ p (a:as)
  | p a       = a : filter_ p as
  | otherwise = filter_ p as

filterFold :: (a -> Bool) -> [a] -> [a]
filterFold p = foldr op unit
  where
    unit = []
    a `op` filtered
      | p a       = a : filtered
      | otherwise = filtered

semn :: [Integer] -> String
semn [] = []
semn (h:t)
    | h < 10 && h > 0 = "+" ++ semn t
    | h < 0 && h > (-10) = "-" ++ semn t
    | h == 0 = "0" ++ semn t
    | otherwise = semn t

test_semn :: Bool
test_semn = semn [5, 10, -5, 0] == "+-0" -- 10 este ignorat

semnFold :: [Integer] -> String
semnFold = foldr op unit
  where
    unit = []
    a `op` string 
      | a < 10 && a > 0 = "+" ++ string
      | a > -10 && a < 0 = "-" ++ string
      | a ==0 =  "0" ++ string
      | otherwise = string

medie :: [Double] -> Double
medie l = f l 0 0
  where
    f :: [Double] -> Double -> Double-> Double
    f [] n suma = suma / n
    f (a:as) n suma = f as (n + 1) (suma + a)

medieFold :: [Double] -> Double
medieFold l = (foldr op unit l) 0 0  -- paranteze doar pentru claritate
  where
    unit :: Double -> Double -> Double
    unit n suma = suma / n
    op :: Double -> (Double -> Double -> Double) -> (Double -> Double -> Double)
    (a `op` r) n suma = r (n + 1) (suma + a)

pozitiiPare :: [Integer] -> [Int]
pozitiiPare l = pozPare l 0 -- al doilea argument tine minte pozitia curenta
  where
    pozPare [] _ = []
    pozPare (a:as) i
      | even a = i:pozPare as (i+1)
      | otherwise = pozPare as (i+1)

test_pozitiiPare :: Bool
test_pozitiiPare = pozitiiPare [5, 10, -5, 0] == [1,3]

pozitiiPareFold :: [Integer] -> [Int]
pozitiiPareFold l = (foldr op unit l) 0
  where
    unit :: Int -> [Int]
    unit _ = []
    op :: Integer -> (Int -> [Int]) -> (Int -> [Int])
    (a `op` r) p
      | even a = [p] ++ r (p+1)
      | otherwise = r (p+1)

zipFold :: [a] -> [b] -> [(a,b)]
zipFold as bs = (foldr op unit as) bs
  where
    unit :: [b] -> [(a,b)]
    unit _ = []
    op :: a -> ([b] -> [(a,b)]) -> ([b] -> [(a,b)])
    (a `op` r) [] = []
    (a `op` r) (h:t) = [(a, h)] ++ r t

logistic :: Num a => a -> a -> Natural -> a
logistic rate start = f
  where
    f 0 = start
    f n = rate * f (n - 1) * (1 - f (n - 1)) 

logistic0 :: Fractional a => Natural -> a
logistic0 = logistic 3.741 0.00079

ex1 :: Natural
ex1 = 20

ex20 :: Fractional a => [a]
ex20 = [1, logistic0 ex1, 3]
 
ex21 :: Fractional a => a
ex21 = head ex20
 
ex22 :: Fractional a => a
ex22 = ex20 !! 2
 
ex23 :: Fractional a => [a]
ex23 = drop 2 ex20
 
ex24 :: Fractional a => [a]
ex24 = tail ex20

ex31 :: Natural -> Bool
ex31 x = x < 7 || logistic0 (ex1 + x) > 2
 
ex32 :: Natural -> Bool
ex32 x = logistic0 (ex1 + x) > 2 || x < 7

ex33 :: Bool
ex33 = ex31 5
 
ex34 :: Bool
ex34 = ex31 7
 
ex35 :: Bool
ex35 = ex32 5
 
ex36 :: Bool
ex36 = ex32 7

findFirst :: (a -> Bool) -> [a] -> Maybe a
findFirst _ []= Nothing
findFirst p (h:t)
    | p h == True = Just h
    | otherwise = findFirst p t

findFirstNat :: (Natural -> Bool) -> Natural
findFirstNat p = n
  where Just n = findFirst p [0..]

ex4b :: Natural
ex4b = findFirstNat (\n -> n * n >= 12347)

inversa :: Ord a => (Natural -> a) -> (a -> Natural)
inversa f = (\y -> (findFirstNat(\x -> y <= f x)))

memoize :: (Natural -> a) -> (Natural -> a)
memoize f = genericIndex tabela
  where    
    tabela = map f [0..]

fibonacci :: Natural -> Natural
fibonacci 0 = 0
fibonacci 1 = 1
fibonacci n = fibonacci (n - 1) + fibonacci (n - 2)

fibonacciM :: Natural -> Natural
fibonacciM = memoize f
  where
    f 0 = 0
    f 1 = 1
    f n = fibonacciM (n - 1) + fibonacciM (n - 2)

catalan :: Natural -> Natural
catalan 0 = 1
catalan n = sum [catalan i * catalan (n - 1 - i) | i <- [0..n-1]]

catalanM :: Natural -> Natural
catalanM = memoize f
    where 
      f 0 = 1
      f n = sum [catalanM i * catalanM (n - 1 - i) | i <- [0..n-1]]

conway :: Natural -> Natural
conway 1 = 1
conway 2 = 1
conway n = conway (conway (n - 1)) + conway (n - conway (n - 1))

conwayM :: Natural -> Natural
conwayM = memoize f
      where
        f 1 = 1
        f 2 = 1
        f n = conwayM (conwayM (n - 1)) + conwayM (n - conwayM (n - 1))


