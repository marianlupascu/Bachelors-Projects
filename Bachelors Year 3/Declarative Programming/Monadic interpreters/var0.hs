import Data.List
import Data.Maybe

type Name = String
 
data Term = Var Name
          | Con Integer
          | Term :+: Term
          | Lam Name Term
          | App Term Term
  deriving (Show)

term0 = (App (Lam "x" (Var "x" :+: Var "x")) (Con 10 :+: Con 11))
twice = Lam "f" (Lam "x" (App (Var "f") (App (Var "f") (Var "x"))))
applyThreeTimes = Lam "f" (App (App (App (Var "f") (Var "f")) (Var "f")) (Var "f"))
incr = Lam "x" ((Var "x") :+: (Con 1))
threeTwice = App (App (App applyThreeTimes twice) incr) (Con 0)

data Value = Num Integer
           | Fun (Value -> M Value) 
 
instance Show Value where
  show (Num x) = show x
  show (Fun _) = "<function>"

type Environment = [(Name, Value)]


add :: Value -> Value -> M Value
add (Num a) (Num b) = Right (Num (a + b))
add _ _ = Left "can only add two nums"

apply :: Value -> Value -> M Value
apply (Fun fun) val = fun val
apply _ _ =  Left "first arg must be fun"

eitherFromMaybe :: String -> Maybe a -> Either String a
eitherFromMaybe message Nothing = Left message
eitherFromMaybe _ (Just x) = Right x

interp :: Term -> Environment -> M Value

interp (Var x) env = eitherFromMaybe "could not find var in env" (lookup x env) 

interp (Con i) _ = return (Num i)

interp (t1 :+: t2) env = do
   v1 <- interp t1 env
   v2 <- interp t2 env
   add v1 v2

interp (Lam n t) env = 
  return (Fun (\v -> interp t ((n, v):env)))

interp (App lam arg) env = do
  val <- interp arg env
  fun <- interp lam env
  apply fun val



type M = Either String

