module Nondet where
import Data.Complex
import Test.QuickCheck

type Nondet a = [a]

sqrts :: Floating a => a -> Nondet a
sqrts x = [y, negate y]
  where
    y = sqrt x


-- Exercise Four:  Apply the function on all input values and aggregate the results
bind :: (a -> Nondet b) -> (Nondet a -> Nondet b)
bind f a = concat (map f a)

-- Using # instead of * for composition to avoid ambiguities
(#) :: (b -> Nondet c) -> (a -> Nondet b) -> (a -> Nondet c)
g' # f' = bind g' . f'

-- Exercise Five: Provide minimal context for the given value
unit :: a -> Nondet a
unit a = [a]

-- lift --- lifting functions
lift :: (a -> b) -> (a -> Nondet b)
lift f = unit . f


-- Solution to the quadratic equation a*x^2 + b * y + c = 0
-- delta = b^2 - 4*a*c
-- x = (-b ­+- sqrt delta) / (2*a)
solveQuadratic :: Floating a  => a -> a -> a -> Nondet a
solveQuadratic a b c = lift (/(2*a)) # lift (b+) # sqrts $ delta
  where
    delta = b*b - 4*a*c


-- Exercise Six:  Test that (for a given value x)
-- (a) f # unit = unit # f = f 
-- (b) lift g # lift f = lift (g.f)
check_unit :: (Complex Float -> Nondet (Complex Float)) -> Complex Float -> Bool
check_unit f x = (f # unit) x == (unit # f) x

test_unit:: IO ()
test_unit = quickCheck $ check_unit sqrts  

check_lift :: (Float -> Float) -> (Float -> Float) -> Float -> Bool
check_lift f g x = (lift g # lift f) x == lift (g.f) x

test_lift :: IO ()
test_lift = quickCheck $ check_lift (+2) (*3)


-- Exercise Ten(b): Rewrite the module to make Nondet instance of 
-- the Monad typeclass
-- Note: You first need to make it an instance of Functor and Applicative


-- Exercise Twelve:  Write the solution to the quadratic equation in do notation

