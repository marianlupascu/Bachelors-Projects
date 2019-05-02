-- Informatics 1 - Functional Programming 
-- http://www.inf.ed.ac.uk/teaching/courses/inf1/fp/


import PicturesSVG
import Test.QuickCheck
import Data.Char



-- Exercise 8:

pic1 :: Picture
pic1 = above (beside knight (invert knight)) (beside (invert knight) knight)

pic2 :: Picture
pic2 = above (beside knight (invert knight)) (beside (invert (flipV knight)) (flipV knight))


-- Exercise 9:
-- a)

emptyRow :: Picture
emptyRow = repeatH 4 (beside whiteSquare blackSquare)

-- b)

otherEmptyRow :: Picture
otherEmptyRow = repeatH 4 (beside blackSquare whiteSquare)

-- c)

middleBoard :: Picture
middleBoard = repeatV 2 (above emptyRow otherEmptyRow)

-- d)

whiteRow :: Picture
whiteRow = over (beside rook (beside knight (beside bishop (beside queen (beside king (beside bishop (beside knight rook))))))) otherEmptyRow

blackRow :: Picture
blackRow = over (invert (beside rook (beside knight (beside bishop (beside queen (beside king (beside bishop (beside knight rook)))))))) emptyRow

-- e)

populatedBoard :: Picture
populatedBoard = above (above (above blackRow (over (repeatH 8 (invert pawn)) otherEmptyRow)) middleBoard) (above (over (repeatH 8 pawn) emptyRow) whiteRow )



-- Functions --

twoBeside :: Picture -> Picture
twoBeside x = beside x (invert x)


-- Exercise 10:

twoAbove :: Picture -> Picture
twoAbove x = above x (invert x)

fourPictures :: Picture -> Picture
fourPictures x = twoBeside(twoAbove x)

emptyBoard :: Picture
emptyBoard = repeatV 4 (above emptyRow otherEmptyRow)