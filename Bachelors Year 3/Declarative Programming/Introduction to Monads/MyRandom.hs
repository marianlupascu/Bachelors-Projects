module MyRandom where

import System.Random
import Test.QuickCheck

type MyRandom a = StdGen -> (a,StdGen)

-- Standard Random Number Generator seeded with 0
zeroSeed :: StdGen
zeroSeed = mkStdGen 0

-- System.Random.random is of type MyRandom a 
--    - if a implements the Random type class
-- For example, try
-- :t random::MyRandom Int


-- Random value in interval [0,n]
uniformNat :: Int -> MyRandom Int
uniformNat n = uint
  where 
    uint gen = let (m,gen') = random gen
               in (m `mod` n, gen')

-- fst $ uniformNat 100 zeroSeed   ==  41

-- Exercise Seven:  implement bind
bind :: (a -> MyRandom b) -> (MyRandom a -> MyRandom b)
bind f x seed = let (x',seed') = x seed in f x' seed'

-- Using # instead of * for composition to avoid ambiguities
(#) :: (b -> MyRandom c) -> (a -> MyRandom b) -> (a -> MyRandom c)
g' # f' = bind g' . f'

-- random of random :-)
doubleRandom :: Int -> MyRandom Int
doubleRandom = uniformNat # uniformNat

-- Exercise Eight: implement unit -- leave the generator unmodified
unit :: a -> MyRandom a
unit = (,)

-- lift --- lifting functions
lift :: (a -> b) -> (a -> MyRandom b)
lift f = unit . f

-- Random value in a given interval 
--    - uniformFromTo m n = m + uniformNat (n-m)
uniformFromTo :: Int -> Int -> MyRandom Int
uniformFromTo m n = lift (m+) # uniformNat $ (n-m)

-- Exercise Nine:  Test that (for a given value x)
-- (a) f # unit = unit # f = f 
-- (b) lift g # lift f = lift (g.f)
check_unit :: (Int -> MyRandom Int) -> Int -> StdGen -> Bool
check_unit f x seed = ((f # unit) x seed == (unit # f) x seed)

test_unit:: IO ()
test_unit = quickCheck $ check_unit uniformNat 

check_lift :: (Int -> Int) -> (Int -> Int) -> Int -> StdGen -> Bool
check_lift f g x seed = (lift g # lift f) x seed == lift (g.f) x seed

test_lift :: IO ()
test_lift = quickCheck $ check_lift (+2) (*3)

-- Exercise Ten(c): Rewrite the module to make MyRandom instance of 
-- the Monad typeclass
-- Note: You first need to make it an instance of Functor and Applicative


-- Exercise Eleven(c):  Write the uniformFromTo function in do notation
-- Questions:
-- * Do you really need the full power of the monad?  
-- * Could you have solved the problem using just the Functor or Applicative capabilities?

