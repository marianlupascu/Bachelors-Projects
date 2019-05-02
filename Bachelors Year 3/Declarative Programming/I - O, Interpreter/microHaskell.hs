import Data.List
import Data.Maybe

type Name = String

data  Value  =  VBool Bool
              | VInt Int
              | VFun (Value -> Value)
              | VError String
               
data  Hask  = HTrue | HFalse
            | HIf Hask Hask Hask
            | HLit Int
            | Hask :==: Hask
            | Hask :+:  Hask
            | Hask :*:  Hask
            | HVar Name
            | HLam Name Hask
            | HLet Name Hask Hask
            | Hask :$: Hask
            deriving (Read, Show)

infix 4 :==:
infixl 6 :+:
infixl 5 :*:
infixl 9 :$:

type  HEnv  =  [(Name, Value)]

showV :: Value -> String
showV (VBool b)   =  show b
showV (VInt i)    =  show i
showV (VFun _)    =  "<function>"
showV (VError s)  =  s

eqV :: Value -> Value -> Bool
eqV (VBool b) (VBool c)    =  b == c
eqV (VInt i) (VInt j)      =  i == j
eqV (VFun _) (VFun _)      =  error "Unknown"
eqV (VError _) (VError _)  =  error "Unknown"
eqV _ _                    = False

hEval :: Hask -> HEnv -> Value
hEval HTrue _         =  VBool True
hEval HFalse _        =  VBool False

hEval (HIf c d e) r   =
  hif (hEval c r) (hEval d r) (hEval e r)
  where  hif (VBool b) v w  =  if b then v else w
         hif _ _ _ = VError "Eroare la Hif"
  
hEval (HLit i) r      =  VInt i

hEval (d :==: e) r     =  heq (hEval d r) (hEval e r)
  where  heq (VInt i) (VInt j) = VBool (i == j)
         heq  _ _ = VError "Eroare la :==:"
  
hEval (d :+: e) r    =  hadd (hEval d r) (hEval e r)
  where  hadd (VInt i) (VInt j) = VInt (i + j)
         hadd _ _  = VError "Eroare la :+:"
         
hEval (d :*: e) r    =  hadd (hEval d r) (hEval e r)
  where  hadd (VInt i) (VInt j) = VInt (i * j)
         hadd _ _  = VError "Eroare la :*:"
  
hEval (HVar x) r      =  fromMaybe (VError "Hvar") (lookup x r)

hEval (HLam x e) r    =  VFun (\v -> hEval e ((x,v):r))


hEval (d :$: e) r    =  happ (hEval d r) (hEval e r)
  where  happ (VFun f) v  =  f v
         happ _ _ = VError "Eroare la :$:"

hEval (HLet n h1 h2) r = let r2 = (n,(hEval h1 r)):r in (hEval h2 r2)

run :: Hask -> String
run pg = showV (hEval pg [])

h0 =  (HLam "x" (HLam "y" ((HVar "x") :+: (HVar "y")))) 
      :$: (HLit 3)
      :$: (HLit 4)
      
h1 =  (HLam "x" (HLam "y" ((HVar "x") :+: (HVar "y")))) 
      :$: (HIf (HLit 1) (HLit 4) (HLit 44))
      :$: (HLit 4)

h2 = HLet "x" (HLit 3) ((HLit 4) :+: HVar "x")

test_h0 = eqV (hEval h0 []) (VInt 7)
