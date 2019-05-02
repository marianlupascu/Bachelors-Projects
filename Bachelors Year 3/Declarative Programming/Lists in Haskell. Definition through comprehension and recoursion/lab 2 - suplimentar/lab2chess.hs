-- Informatics 1 - Functional Programming
-- Lab week tutorial part II
--
--

import           Data.Char
import           PicturesSVG
import           Test.QuickCheck
import           Data.List
import  Data.List.Split


-- Exercise 1
-- write the correct type and the definition for
isFENChar :: Char -> Bool
isFENChar c = elem (toLower c) "rnbqkp/" || isDigit c

-- Exercise 2.a
-- write a recursive definition for
besideList :: [Picture] -> Picture
besideList = foldl beside Empty

-- Exercise 2.c
-- write the correct type and the definition for
toClear :: Int -> Picture
toClear n = besideList (replicate n clear)

-- Exercise 3
-- write the correct type and the definition for
fenCharToPicture :: Char -> Picture
fenCharToPicture c | isDigit c = toClear (digitToInt c)
fenCharToPicture c =
  if isUpper c
    then invert (fenCharToPicture (toLower c))
    else case c of
      'r' -> rook
      'n' -> knight
      'b' -> bishop
      'q' -> queen
      'k' -> king
      'p' -> pawn
      otherwise -> Empty

-- Exercise 4
-- write the correct type and the definition for
isFenRow :: String -> Bool
isFenRow [] = True 
isFenRow (h:t) = isFENChar h && isFenRow t

-- Exercise 6.a
-- write a recursive definition for
fenCharsToPictures :: String -> [Picture]
fenCharsToPictures [] = []
fenCharsToPictures (h:t) = fenCharToPicture(h):fenCharsToPictures(t)

-- Exercise 6.b
-- write the correct type and the definition of
fenRowToPicture :: String -> Picture
fenRowToPicture l = besideList (fenCharsToPictures l)

-- Exercise 7
-- write the correct type and the definition of
findPosAuxChar :: Char -> String -> Int -> Int 
findPosAuxChar _ [] _ = -1
findPosAuxChar c (h:t) n
    | h == c = n
    | otherwise = findPosAuxChar c t (n+1)

findPosAux :: String -> String -> Int -> Int 
findPosAux (h:[]) s n = findPosAuxChar h s n
findPosAux (h:t) s n = if findPosAuxChar h s n == -1 
    then findPosAux t s n
    else findPosAuxChar h s n

findPos :: String -> String -> Int 
findPos c s = findPosAux c s 0

mySplitOn :: String -> String -> [String]
mySplitOn _ [] = [""]
mySplitOn c s = case (findPos c s) of
    -1 -> [s]
    otherwise -> (take (findPos c s) s):(mySplitOn c (drop ((findPos c s) + 1) s))

-- Exercise 8.a
-- write a recursive definition for
fenRowsToPictures :: [String] -> [Picture]
fenRowsToPictures [] = []
fenRowsToPictures (h:t) = (fenRowToPicture h):(fenRowsToPictures t)

-- Exercise 8.b
-- write the correct type and the definition of
aboveList :: [Picture] -> Picture
aboveList [] = Empty
aboveList (h:t) = above h (aboveList t)


-- Exercise 8.c
-- write the correct type and the definition of
fenToPicture :: [String] -> Picture
fenToPicture s = aboveList (fenRowsToPictures s)

-- Exercise 9
-- write the correct type and the definition of
emptyRow :: Picture
emptyRow = repeatH 4 (beside whiteSquare blackSquare)

otherEmptyRow :: Picture
otherEmptyRow = repeatH 4 (beside blackSquare whiteSquare)

emptyBoard :: Picture
emptyBoard = repeatV 4 (above emptyRow otherEmptyRow)

chessBoard :: [String] -> Picture
chessBoard s = over (fenToPicture s) emptyBoard



f :: String -> [String]
f s = splitOn  "/" s

-- Exercise 10
-- write the correct type and definition of
deleteAllInstances :: Eq a => a -> [a] -> [a]
deleteAllInstances a (x:xs)
    | a == x    = rest
    | otherwise = x : rest
      where
        rest = deleteAllInstances a xs
deleteAllInstances _ _ = []

allowedMovedR1 :: (Char, Int) -> [(Char, Int)]
allowedMovedR1 (l, c) | c > 8 || c < 1 || l > 'h' || l < 'a'= []
allowedMovedR1 (l, c) = (l, c):(allowedMovedR1 ((succ l), c))

allowedMovedR2 :: (Char, Int) -> [(Char, Int)]
allowedMovedR2 (l, c) | c > 8 || c < 1 || l > 'h' || l < 'a'= []
allowedMovedR2 (l, c) = (l, c):(allowedMovedR2 ((pred l), c))

allowedMovedR3 :: (Char, Int) -> [(Char, Int)]
allowedMovedR3 (l, c) | c > 8 || c < 1 || l > 'h' || l < 'a'= []
allowedMovedR3 (l, c) = (l, c):(allowedMovedR3 (l, (pred c)))

allowedMovedR4 :: (Char, Int) -> [(Char, Int)]
allowedMovedR4 (l, c) | c > 8 || c < 1 || l > 'h' || l < 'a'= []
allowedMovedR4 (l, c) = (l, c):(allowedMovedR4 (l, (succ c)))

allowedMovedB1 :: (Char, Int) -> [(Char, Int)]
allowedMovedB1 (l, c) | c > 8 || c < 1 || l > 'h' || l < 'a'= []
allowedMovedB1 (l, c) = (l, c):(allowedMovedB1 ((succ l), (succ c)))

allowedMovedB2 :: (Char, Int) -> [(Char, Int)]
allowedMovedB2 (l, c) | c > 8 || c < 1 || l > 'h' || l < 'a'= []
allowedMovedB2 (l, c) = (l, c):(allowedMovedB2 ((succ l), (pred c)))

allowedMovedB3 :: (Char, Int) -> [(Char, Int)]
allowedMovedB3 (l, c) | c > 8 || c < 1 || l > 'h' || l < 'a'= []
allowedMovedB3 (l, c) = (l, c):(allowedMovedB3 ((pred l), (succ c)))

allowedMovedB4 :: (Char, Int) -> [(Char, Int)]
allowedMovedB4 (l, c) | c > 8 || c < 1 || l > 'h' || l < 'a'= []
allowedMovedB4 (l, c) = (l, c):(allowedMovedB4 ((pred l), (pred c)))

allowedMoved :: Char -> (Char, Int) -> [(Char, Int)]
allowedMoved _ (l, c) | c > 8 || c < 1 || l > 'h' || l < 'a'= []
allowedMoved p (l, c) = case p of
  'r' -> deleteAllInstances (l,c) ((allowedMovedR1 (l, c))++(allowedMovedR2 (l, c))++(allowedMovedR3 (l, c))++(allowedMovedR4 (l, c)))
  'R' -> deleteAllInstances (l,c) ((allowedMovedR1 (l, c))++(allowedMovedR2 (l, c))++(allowedMovedR3 (l, c))++(allowedMovedR4 (l, c)))
  'n' -> deleteAllInstances (l,c) ((max 'a' (pred (pred l)), max 1 (pred c)):(max 'a' (pred (pred l)), min 8 (succ c)):(min 'h' (succ (succ l)), max 1 (pred c)):(min 'h' (succ (succ l)), min 8 (succ c)):(min 'h' (succ l), min 8 (succ (succ c))):(min 'h' (succ l), max 1 (pred (pred c))):(max 'a' (pred l), min 8 (succ (succ c))):(max 'a' (pred l), max 1 (pred (pred c))):[])
  'N' -> deleteAllInstances (l,c) ((max 'a' (pred (pred l)), max 1 (pred c)):(max 'a' (pred (pred l)), min 8 (succ c)):(min 'h' (succ (succ l)), max 1 (pred c)):(min 'h' (succ (succ l)), min 8 (succ c)):(min 'h' (succ l), min 8 (succ (succ c))):(min 'h' (succ l), max 1 (pred (pred c))):(max 'a' (pred l), min 8 (succ (succ c))):(max 'a' (pred l), max 1 (pred (pred c))):[])
  'b' -> deleteAllInstances (l,c) ((allowedMovedB1 (l, c))++(allowedMovedB2 (l, c))++(allowedMovedB3 (l, c))++(allowedMovedB4 (l, c)))
  'B' -> deleteAllInstances (l,c) ((allowedMovedB1 (l, c))++(allowedMovedB2 (l, c))++(allowedMovedB3 (l, c))++(allowedMovedB4 (l, c)))
  'q' -> deleteAllInstances (l,c) ((allowedMovedB1 (l, c))++(allowedMovedB2 (l, c))++(allowedMovedB3 (l, c))++(allowedMovedB4 (l, c))++(allowedMovedR1 (l, c))++(allowedMovedR2 (l, c))++(allowedMovedR3 (l, c))++(allowedMovedR4 (l, c)))
  'Q' -> deleteAllInstances (l,c) ((allowedMovedB1 (l, c))++(allowedMovedB2 (l, c))++(allowedMovedB3 (l, c))++(allowedMovedB4 (l, c))++(allowedMovedR1 (l, c))++(allowedMovedR2 (l, c))++(allowedMovedR3 (l, c))++(allowedMovedR4 (l, c)))
  'k' -> deleteAllInstances (l,c) ((max 'a' (pred l), c):(min 'h' (succ l), c):(l, max 1 (pred c)):(l, min 8 (succ c)):(max 'a' (pred l), max 1 (pred c)):(min 'h' (succ l), min 8 (succ c)):(max 'a' (pred l), min 8 (succ c)):(min 'h' (succ l), max 1 (pred c)):[])
  'K' -> deleteAllInstances (l,c) ((max 'a' (pred l), c):(min 'h' (succ l), c):(l, max 1 (pred c)):(l, min 8 (succ c)):(max 'a' (pred l), max 1 (pred c)):(min 'h' (succ l), min 8 (succ c)):(max 'a' (pred l), min 8 (succ c)):(min 'h' (succ l), max 1 (pred c)):[])
  otherwise -> []
