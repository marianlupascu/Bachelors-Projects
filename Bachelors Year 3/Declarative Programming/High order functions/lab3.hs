import   Data.List
import   Test.QuickCheck

--L3.1 - 1
factori :: Int -> [Int]
factori i = [ x | x <- [ 1..i ], i `mod` x == 0 ]

--L3.1 - 2
prim :: Int -> Bool
prim n = if length (factori n) == 2
    then True
    else False

--L3.1 - 3
numerePrime :: Int -> [Int]
numerePrime n = [ x | x <- [ 2..n ], prim x ]

--L3.1 - 4
--Input: an integer n > 1.
--
-- Let A be an array of Boolean values, indexed by integers 2 to n,
-- initially all set to true.
-- 
-- for i = 2, 3, 4, ..., not exceeding √n:
--   if A[i] is true:
--     for j = i2, i2+i, i2+2i, i2+3i, ..., not exceeding n:
--       A[j] := false.
-- 
-- Output: all i such that A[i] is true.

numerePrimeCiur :: Int -> [Int]
numerePrimeCiur n = []

--L3.2
myzip3 :: [Integer] -> [Integer] -> [Integer] -> [(Integer, Integer, Integer)]
myzip3 [] _ _ = []
myzip3 _ [] _ = []
myzip3 _ _ [] = []
myzip3 (h1:t1) (h2:t2) (h3:t3) = (h1, h2, h3) : (myzip3 t1 t2 t3)

--L3.3 - 1
ordonataNat :: [a] -> ( a -> a -> Bool ) -> Bool
ordonataNat [] _ = True
ordonataNat (_:[]) _ = True
ordonataNat l c = and [ c x y | (x, y) <- zip l (tail l)]

--L3.3 - 2
ordonataNat1 :: [a] -> ( a -> a -> Bool ) -> Bool
ordonataNat1 [] _ = True
ordonataNat1 (_:[]) _ = True
ordonataNat1 (x:y:t) f = (f x y) && (ordonataNat1 (y:t) f)

testOrdonataNat :: [Integer] -> Bool
testOrdonataNat l = ordonataNat l (\x y -> x < y) == ordonataNat1 l (\x y -> x < y)

--L3.4 - 1
-- deja scris la L3.3 - 1

--L3.4 - 2
----ordonataNat [1, 2, 5, 10] (\x y -> x < y)
----ordonataNat [8,4,2,1] (\x y -> y `mod` x == 0)
----ordonataNat [[1,2,3],[1,5,6],[2,8,9,10]] (\x y -> x < y)

--L3.4 - 3
(*<*) :: ( Integer , Integer ) -> ( Integer , Integer ) -> Bool
(*<*) (a, b) (c, d) = if a < c && b < d
    then True
    else False

----ordonataNat [(1, 2), (5, 77), (6, 100)] (\x y -> x *<* y)

--L3.5 - 1
firstEl :: [(a, b)] -> [a]
firstEl l = map fst l
--L3.5 - 2
sumList :: [[Integer]] -> [Integer]
sumList l = map sum l

--L3.5 - 3
prel2 :: [Integer] -> [Integer]
prel2 l = map (\x -> if odd x then x * 2 else x `div` 2) l

--L3.5 - 4
compuneList :: (b -> c) -> [(a -> b)] -> [(a -> c)]
compuneList f l = map (f.) l

aplicaList :: a -> [(a -> b)] -> [b]
aplicaList e l = map ($e) l

--L3.5 - 5
myzip3Aux :: [Integer] -> [Integer] -> [Integer] -> [(Integer, Integer, Integer)]
myzip3Aux l1 l2 l3 = map (\x -> (fst x, fst (snd x), snd (snd x))) (zip l1 (zip l2 l3))

--L3.6 - 1
contineCaracter :: Char -> [String] -> [String]
contineCaracter c l = filter (elem c) l

--L3.6 - 2
patrateNrImpare :: [Integer] -> [Integer]
patrateNrImpare l = map (^2) (filter odd l)

--L3.6 - 3
patratePozImpare :: [Integer] -> [Integer]
patratePozImpare l = map ((^2).fst) (filter (\x -> if odd (snd x) then True else False) (zip l [1..]))

--L3.6 - 4
numaiVocale :: [String] -> [String]
numaiVocale l = map (\x -> filter(\y -> if y == 'a' || y == 'e' || y == 'i' || y == 'o' || y == 'u' then True else False) x) l

--L3.7
myfilter :: (a -> Bool) -> [a] -> [a]
myfilter _ [] = []
myfilter f (h:t)
    | f h == True = h:(myfilter f t)
    | otherwise = myfilter f t

mymap :: (a -> b) -> [a] -> [b]
mymap _ [] = []
mymap f (h:t) = (f h):(mymap f t)

mycontineCaracter :: Char -> [String] -> [String]
mycontineCaracter c l = myfilter (elem c) l

testcontineCaracter :: Char -> [String] -> Bool
testcontineCaracter c l = (contineCaracter c l) == (mycontineCaracter c l)
-- quickCheck testcontineCaracter

mypatrateNrImpare :: [Integer] -> [Integer]
mypatrateNrImpare l = mymap (^2) (myfilter odd l)

testpatrateNrImpare :: [Integer] -> Bool
testpatrateNrImpare l = (patrateNrImpare l) == (mypatrateNrImpare l)
-- quickCheck testpatrateNrImpare

