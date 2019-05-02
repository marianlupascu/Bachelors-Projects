module Lab7 where

import Data.Char (toUpper)
import Data.Char (digitToInt)
import Data.List.Split (splitOn)
import Data.List (intercalate)
import Data.List.Split

prelStr :: String -> String
prelStr strin = map toUpper strin

ioString :: IO ()
ioString = do
           strin <- getLine
           putStrLn $ "Intrare\n" ++ strin
           let strout = prelStr strin
           putStrLn $ "Iesire\n" ++ strout

prelNo :: Double -> Double
prelNo noin = sqrt noin

ioNumber :: IO ()
ioNumber = do
           noin <- readLn :: IO Double
           putStrLn $ "Intrare\n" ++ (show noin)
           let  noout = prelNo noin
           putStrLn $ "Iesire"
           print noout

inoutFile :: IO ()
inoutFile = do
              sin <- readFile "Input.txt"
              putStrLn $ "Intrare\n" ++ sin
              let sout = prelStr sin
              putStrLn $ "Iesire\n" ++ sout
              writeFile "Output.txt" sout
-- 1 
data Person = Person { name :: String
                     , age :: Int
                     } deriving Show

ioPerson :: IO Person
ioPerson = do 
    n <- getLine 
    v <- readLn :: IO Int
    return (Person {name = n, age = v})

ioPersons :: Int -> IO [Person]
ioPersons 0 = return []
ioPersons n = do 
                pers <- ioPerson
                l <- ioPersons (n-1)
                return (pers:l)

getOldestPeople :: [Person] -> [Person]
getOldestPeople persons = let maxAge = maximum $ map age persons in [x | x <- persons, age x == maxAge]

main :: IO()
main = do
            n <- readLn :: IO Int
            persons <- ioPersons n
            --putStrLn persons
            --let pensonsStr = intercalate ", " $ map show persons
            --putStrLn pensonsStr
            let pensonsStr2 = intercalate ", " $ map name (getOldestPeople persons)
            putStrLn $ "Cele mai invarsta persoane sunt: " ++ pensonsStr2

getPers :: [String] -> [Person]
getPers [] = []
getPers (h:t) = let info = splitOn "," h 
                in let a = foldr (\a b -> b * 10 + (digitToInt a) ) 0 $ tail (info !! 1)
                   in (Person {name = info !! 0, age = a}):(getPers t)

main2 :: IO()
main2 = do
            content<- readFile "ex2.in"
            let lines = splitOn "\n" content
            let pers = getPers lines
            let pensonsStr2 = intercalate ", " $ map name (getOldestPeople pers)
            putStrLn $ "Cele mai invarsta persoane sunt: " ++ pensonsStr2

