--examen
import Data.List (splitAt)

type MIndex = Int

data Prog = On Stmt
data Stmt = Off | Expr :> Stmt
data Expr = V Int | Expr :+ Expr | M MIndex | MIndex := Expr
 
type Mem = [Int]
initMem = [0 | x <- [1..]]
 
prog :: Prog -> [Int]
prog (On s) = stmt s initMem
 
stmt :: Stmt -> Mem -> [Int]
stmt Off _ = []
stmt (e :> s) memi =(v : (stmt s memf))
    where
        v = expr e memi
        memf = changeMem e memi
       
expr :: Expr -> Mem -> Int
expr (e1 :+ e2) mem = (expr e1 mem) + (expr e2 mem)
expr (V n) _ = n
expr (M i) mem = mem !! i
expr (i := e) mem = expr e mem
 
changeMem :: Expr -> Mem -> Mem
changeMem (i := e) mem = mem1 ++ (v:mem2)
    where
        v = expr e mem
        (mem1, (_:mem2)) = splitAt i mem
changeMem _ m = m
 
test0 = prog (On ( (V 3) :> ( ( (V 4) :+ (V 5) ) :> Off ) ))
test1 = prog (On ((1 := (V 3)) :> ( (2 := (V 4)) :> ( ((M 1) :+ (M 2)) :> Off ) )))

-----------------------------------------------------------------------------------
--State
import Data.List (splitAt)
 
type MIndex = Int
 
data Prog = On Stmt
data Stmt = Off | Expr :> Stmt
data Expr = V Int | Expr :+ Expr | M MIndex | MIndex := Expr
 
type Mem = [Int]
initMem = [0 | x <- [1..]]
 
prog :: Prog -> M [Int]
prog (On s) = stmt s
 
stmt :: Stmt -> M [Int]
stmt Off = return []
stmt (e :> s) =
    do
        v <- expr e
        changeMem e
        rez <- stmt s
        return (v : rez)
       
expr :: Expr -> M Int
expr (e1 :+ e2) =
    do
        e1_eval <- expr e1
        e2_eval <- expr e2
        return (e1_eval + e2_eval)
 
expr (V n) = return n
 
expr (M i) =
    do
        mem <- get
        return (mem !! i)
 
expr (i := e) =
    do
        mem <- get
        expr e
 
changeMem :: Expr -> M ()
changeMem (i := e) =
    do
        mem <- get
        v <- expr e
        let
            (mem1, (_:mem2)) = splitAt i mem
        do
            put (mem1 ++ (v:mem2))      
changeMem _ = return ()
 
test0 = prog (On ( (V 3) :> ( ( (V 4) :+ (V 5) ) :> Off ) ))
test1 = prog (On ((1 := (V 3)) :> ( (2 := (V 4)) :> ( ((M 1) :+ (M 2)) :> Off ) )))
test2 = prog (On ((1 := (V 3)) :> ( (M 1) :> Off)))
 
newtype State state a = State { runState :: state -> (a, state) }
 
instance Monad (State state) where
    return a = State (\ s -> (a, s))
    ma >>= k = State g
        where g state = let (a, aState) = runState ma state
                        in runState (k a) aState
 
instance Applicative (State state) where
  pure = return
  mf <*> ma = do
    f <- mf
    a <- ma
    return (f a)
 
instance Functor (State state) where
  fmap f ma = pure f <*> ma
 
-- functii ajutatoare
get :: State state state
get = State (\s -> (s, s)) -- intoarce starea curenta
 
put s = State (\_ ->((), s)) -- schimba starea curenta
 
modify :: (state -> state) -> State state ()
modify f = State (\s -> ((), f s))
 
type M a = State Mem a
 
showM :: Show a => M a -> String
showM ma = show a
    where
        (a, s) = runState ma initMem
       
test = showM test1


-------------------------------------------------------------------------------
--Reader
import Data.List (splitAt)
 
type MIndex = Int
 
data Prog = On Stmt
data Stmt = Off | Expr :> Stmt
data Expr = V Int | Expr :+ Expr | M MIndex | MIndex := Expr
 
type Mem = [Int]
initMem = [0 | x <- [1..]]
 
prog :: Prog -> M [Int]
prog (On s) = stmt s
 
stmt :: Stmt -> M [Int]
stmt Off = return []
stmt ((i := e) :> s) =
    do
        mem <- ask
        v <- expr e
        let
            (mem1, (_:mem2)) = splitAt i mem
        do
            rez <- local (const (mem1 ++ (v:mem2))) (stmt s)
            return (v : rez)
stmt (e :> s) =
    do
        v <- expr e
        rez <- stmt s
        return (v : rez)
       
expr :: Expr -> M Int
expr (e1 :+ e2) =
    do
        e1_eval <- expr e1
        e2_eval <- expr e2
        return (e1_eval + e2_eval)
 
expr (V n) = return n
 
expr (M i) =
    do
        mem <- ask
        return (mem !! i)
 
expr (i := e) =
    do
        mem <- ask
        expr e
 
test0 = prog (On ( (V 3) :> ( ( (V 4) :+ (V 5) ) :> Off ) ))
test1 = prog (On ((1 := (V 3)) :> ( (2 := (V 4)) :> ( ((M 1) :+ (M 2)) :> Off ) )))
test2 = prog (On ((1 := (V 3)) :> ( (M 1) :> Off)))
 
newtype Reader env a = Reader { runReader :: env -> a }
 
instance Monad (Reader env) where
    return x = Reader (\_ -> x)
    ma >>= k = Reader f
        where f env = let a = runReader ma env
                      in runReader (k a) env
 
instance Applicative (Reader env) where
  pure = return
  mf <*> ma = do
    f <- mf
    a <- ma
    return (f a)
 
instance Functor (Reader env) where
  fmap f ma = pure f <*> ma
 
-- functii ajutatoare
-- obtine memoria
ask :: Reader r r
ask = Reader id -- Reader (\r -> r)
 
-- modifica local memoria
local :: (r -> r) -> Reader r a -> Reader r a
local f ma = Reader (\r -> (runReader ma)(f r))
 
type M a = Reader Mem a
 
showM :: Show a => M a -> String
showM ma = show (runReader ma initMem)
       
test = showM test1