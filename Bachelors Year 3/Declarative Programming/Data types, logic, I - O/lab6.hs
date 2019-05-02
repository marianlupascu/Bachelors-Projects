module Lab6 where
import Data.List (nub)
import Data.Maybe (fromJust)
import Test.QuickCheck

data Fruct
  = Mar String Bool
  | Portocala String Int

ionatanFaraVierme = Mar "Ionatan" False
goldenCuVierme = Mar "Golden Delicious" True
portocalaSicilia10 = Portocala "Sanguinello" 10

ePortocalaDeSicilia :: Fruct -> Bool
ePortocalaDeSicilia (Portocala "Tarocco" _) = True
ePortocalaDeSicilia (Portocala "Moro" _) = True
ePortocalaDeSicilia (Portocala "Sanguinello" _) = True
ePortocalaDeSicilia f = False

test_ePortocalaDeSicilia1 =
    ePortocalaDeSicilia (Portocala "Moro" 12) == True
test_ePortocalaDeSicilia2 =
    ePortocalaDeSicilia (Mar "Ionatan" True) == False

type Nume = String
data Prop
  = Var Nume
  | F
  | T
  | Not Prop
  | Prop :|: Prop
  | Prop :&: Prop
  | Prop :->: Prop
  | Prop :<->: Prop
  deriving (Eq, Read)
infixr 2 :|:
infixr 3 :&:
infixr 4 :->:
infixr 5 :<->:

-- (P | Q) ^ (P ^ Q)
p1 :: Prop
p1 = (Var("p1") :|: Var("p2")) :&: (Var("p1") :&: Var("p2"))

-- (P | Q) ^ (¬P ^ ¬Q)
p2 :: Prop
p2 = (Var("p1") :|: Var("p2")) :&: (Not(Var("p1")) :&: Not(Var("p2")))

-- (P ^ (Q | R)) ^ ((¬P | ¬Q) ^ (¬P | ¬R))
p3 :: Prop
p3 = (Var("p1") :&: (Var("p2") :|: Var("p3"))) :&: ((Not(Var("p1")) :|: Not(Var("p2"))) :&: (Not(Var("p2")) :|: Not(Var("p3"))))

instance Show Prop where
  show T = "T"
  show F = "F"
  show (Var s) = s
  show (Not p) = "(~" ++ show p ++ ")"
  show (p1 :|: p2) = "(" ++ show p1 ++ "|" ++ show p2 ++ ")"
  show (p1 :&: p2) = "(" ++ show p1 ++ "&" ++ show p2 ++ ")"
  show (p1 :->: p2) = "(" ++ show p1 ++ "->" ++ show p2 ++ ")"
  show (p1 :<->: p2) = "(" ++ show p1 ++ "<->" ++ show p2 ++ ")"
 
test_ShowProp :: Bool
test_ShowProp =
    show (Not (Var "P") :&: Var "Q") == "((~P)&Q)"

type Env = [(Nume, Bool)]

impureLookup :: Eq a => a -> [(a,b)] -> b
impureLookup a = fromJust . lookup a

eval :: Prop -> Env -> Bool
eval T _ = True
eval F _ = False
eval (Var s) env = impureLookup s env
eval (Not p) env = not (eval p env)
eval (p1 :|: p2) env = (eval p1 env) || (eval p2 env)
eval (p1 :&: p2) env = (eval p1 env) && (eval p2 env)
eval (p1 :->: p2) env
  |(eval p1 env) == False = True
  |(eval p1 env) == True && (eval p2 env) == True = True
  |otherwise = False
eval (p1 :<->: p2) env = (eval p1 env) == (eval p2 env)
 
test_eval = eval  (Var "P" :|: Var "Q") [("P", True), ("Q", False)] == True

eval2 :: Prop -> Env -> Maybe Bool
eval2 T _ = Just True
eval2 F _ = Just False
eval2 (Var s) env = lookup s env
eval2 (Not p) env 
  | (eval2 p env) == Nothing = Nothing
  | otherwise = Just $ not $ fromJust(eval2 p env)
eval2 (p1 :|: p2) env 
  | (eval2 p1 env) == Nothing || (eval2 p2 env) == Nothing = Nothing
  | otherwise = Just $ fromJust(eval2 p1 env) || fromJust(eval2 p2 env)
eval2 (p1 :&: p2) env
  | (eval2 p1 env) == Nothing || (eval2 p2 env) == Nothing = Nothing
  | otherwise = Just $ fromJust(eval2 p1 env) && fromJust(eval2 p2 env)
eval2 (p1 :->: p2) env
  | (eval2 p1 env) == Nothing || (eval2 p2 env) == Nothing = Nothing
  | (eval2 p1 env) == Just False = Just True
  | (eval2 p1 env) == Just True && (eval2 p2 env) == Just True = Just True
  | otherwise = Just False
eval2 (p1 :<->: p2) env 
  | (eval2 p1 env) == Nothing || (eval2 p2 env) == Nothing = Nothing
  | otherwise = Just $ fromJust(eval2 p1 env) == fromJust(eval2 p2 env)

variabileAux :: Prop -> [Nume]
variabileAux T = []
variabileAux F = []
variabileAux (Var s) = [s]
variabileAux (Not p) = variabileAux p
variabileAux (p1 :|: p2) = (variabileAux p1) ++ (variabileAux p2)
variabileAux (p1 :&: p2) = (variabileAux p1) ++ (variabileAux p2)
variabileAux (p1 :->: p2) = (variabileAux p1) ++ (variabileAux p2)
variabileAux (p1 :<->: p2) = (variabileAux p1) ++ (variabileAux p2)

variabile :: Prop -> [Nume]
variabile p = nub (variabileAux p)
 
test_variabile =
  variabile (Not (Var "P") :&: Var "Q") == ["P", "Q"]

subsets :: [Bool] -> [[Bool]]
subsets []  = [[]]
subsets (x:xs) = subsets xs ++ map (x:) (subsets xs)

subsetsn :: [[Bool]] -> Int -> [[Bool]]
subsetsn [] _ = []
subsetsn (h:t) n
  | length(h) == n = h:(subsetsn t n)
  | otherwise = subsetsn t n

costructList :: Int -> [Bool]
costructList 0 = []
costructList n = [True, False] ++ costructList (n-1)

getLista :: Int -> [[Bool]]
getLista n = nub (subsetsn (subsets (costructList n)) n)

envsPair :: [Nume] -> [Bool] -> [(Nume, Bool)]
envsPair [] [] = []
envsPair (h1:t1) (h2:t2) = (h1, h2) : (envsPair t1 t2)

envsAux :: [Nume] -> [[Bool]] -> [[(Nume, Bool)]]
envsAux _ [] = []
envsAux n (h:t) = (envsPair n h) : (envsAux n t)

envs :: [Nume] -> [[(Nume, Bool)]]
envs n = envsAux n (getLista (length n))
 
test_envs = 
    envs ["P", "Q"]
    ==
    [ [ ("P",False)
      , ("Q",False)
      ]
    , [ ("P",False)
      , ("Q",True)
      ]
    , [ ("P",True)
      , ("Q",False)
      ]
    , [ ("P",True)
      , ("Q",True)
      ]
    ]

satisfiabilaAux :: Prop -> [Env] -> Bool
satisfiabilaAux _ [] = False
satisfiabilaAux p (h:t) 
      | eval p h == True = True
      | otherwise = satisfiabilaAux p t

satisfiabila :: Prop -> Bool
satisfiabila p = satisfiabilaAux p (envs (variabile p))
 
test_satisfiabila1 = satisfiabila (Not (Var "P") :&: Var "Q") == True
test_satisfiabila2 = satisfiabila (Not (Var "P") :&: Var "P") == False

valida :: Prop -> Bool
valida p = ((satisfiabila (Not p)) == False)

test_valida1 = valida (Not (Var "P") :&: Var "Q") == False
test_valida2 = valida (Not (Var "P") :|: Var "P") == True

showAux :: Bool -> String
showAux True = "T"
showAux False = "F"

tabelaAdevarAux :: Prop -> [Env] -> String
tabelaAdevarAux _ [] = ""
tabelaAdevarAux p (h:t) = foldr (++) "" (map (\x -> (showAux(snd x)) ++ " ") h) ++ "|      " ++ (showAux (eval p h)) ++ "\n" ++ (tabelaAdevarAux p t)

tabelaAdevar :: Prop -> IO ()
tabelaAdevar p = putStr((foldr (++) "" (map (\x -> x ++ " ") (variabile p))) ++ "| " ++ (show p) ++ "\n" ++ 
                        (foldr (++) "" (map (\x -> x ++ " ") (replicate (length (variabile p)) "_"))) ++ "| " ++ (foldr (++) "" (replicate (length (show p)) "_")) ++ "\n" ++
                        (tabelaAdevarAux p (envs (variabile p))))

echivalentaAux :: Prop -> Prop -> [Env] -> Bool
echivalentaAux _ _ [] = True;
echivalentaAux p1 p2 (h:t)
  | (eval2 p1 h) == Nothing || (eval2 p2 h) == Nothing = False
  | otherwise = fromJust(eval2 p1 h) == fromJust(eval2 p2 h) && (echivalentaAux p1 p2 t)

echivalenta :: Prop -> Prop -> Bool
echivalenta p1 p2 = echivalentaAux p1 p2 (envs (variabile p1))
 
test_echivalenta1 =
  True
  ==
  (Var "P" :&: Var "Q") `echivalenta` (Not (Not (Var "P") :|: Not (Var "Q")))
test_echivalenta2 =
  False
  ==
  (Var "P") `echivalenta` (Var "Q")
test_echivalenta3 =
  True
  ==
  (Var "R" :|: Not (Var "R")) `echivalenta` (Var "Q" :|: Not (Var "Q"))

