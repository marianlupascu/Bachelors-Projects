-- http://www.inf.ed.ac.uk/teaching/courses/inf1/fp/



import Data.Char
import Data.List
import Test.QuickCheck


-- 1.
rotate :: Int -> [Char] -> [Char]
rotate n (h:t)
      | n == 0 = (h:t)
      | n < 0 = "Numar negativ"
      | otherwise = rotate (n-1) (t++[h])

-- 2.
prop_rotate :: Int -> String -> Bool
prop_rotate k str = rotate (l - m) (rotate m str) == str
                        where l = length str
                              m = if l == 0 then 0 else k `mod` l
-- testeaza daca fac rotatia bine

-- 3. 
makeKey :: Int -> [(Char, Char)]
makeKey n = zip ['A'..'Z'] (rotate n ['A'..'Z'])

-- 4.
lookUp :: Char -> [(Char, Char)] -> Char
lookUp c [] = c
lookUp c (h:t)
      | c == fst h = snd h 
      | otherwise = lookUp c t

-- 5.
encipher :: Int -> Char -> Char
encipher n c = lookUp c (makeKey n)

-- 6.
normalize :: String -> String
normalize [] = []
normalize (h:t)
      | h >= 'a' && h <='z' = toUpper h:(normalize t)
      | h >= 'A' && h <='Z' = h:(normalize t)
      | h >= '0' && h <='9' = h:(normalize t)
      | otherwise  = normalize t

-- 7.
encipherStr :: Int -> String -> String
encipherStr _ [] = []
encipherStr n (h:t) 
      | normalize [h] == [] = (encipherStr n t)
      | otherwise = (encipher n ((normalize [h])!!0)) : (encipherStr n t)

-- 8.
reverseKey :: [(Char, Char)] -> [(Char, Char)]
reverseKey [] = []
reverseKey (h:t) = (snd h, fst h) : reverseKey t

-- 9.
decipher :: Int -> Char -> Char
decipher n c = lookUp c (reverseKey (makeKey n))

decipherStr :: Int -> String -> String
decipherStr _ [] = []
decipherStr n (h:t) = (decipher n h) : (decipherStr n t)

-- 10.
prop_cipher :: Int -> String -> Bool
prop_cipher n s 
      | n >= 0 = (normalize s) \\ decipherStr n (encipherStr n (normalize s)) == [] && decipherStr n (encipherStr n (normalize s)) \\ (normalize s) == []
      | otherwise = True

-- 11.

operatorEgal :: String -> String -> Bool
operatorEgal [] [] = True
operatorEgal [] _ = False
operatorEgal _ [] = False
operatorEgal (h1:t1) (h2:t2) = h1 == h2 && (operatorEgal t1 t2)

contains :: String -> String -> Bool
contains [] _ = False
contains (h:t) s = operatorEgal (take (length s) (h:t)) s || contains t s

-- 12.
candidatesAux :: Int -> String -> [(Int, String)]
candidatesAux 27 _ = []
candidatesAux n s = if (contains (decipherStr n s) "AND") || (contains (decipherStr n s) "THE")
      then (n, (decipherStr n s)):(candidatesAux (n+1) s)
      else (candidatesAux (n+1) s)

candidates :: String -> [(Int, String)]
candidates s = candidatesAux 1 s

