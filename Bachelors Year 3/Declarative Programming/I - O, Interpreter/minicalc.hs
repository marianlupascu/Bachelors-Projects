data Prog  = On Instr                
data Instr  = Off | Expr :> Instr | Expr :>> Instr  
data Expr  =  Mem | V Int | Expr :+ Expr  | Expr :* Expr



infixl 6 :+   
infixl 5 :*


type Env = Int
type DomInstr = Env -> [Int]
type DomProg = [Int]
type DomExpr = Env -> Int
type DomExpr2 = Int

prog :: Prog -> DomProg
prog (On instr) = stmt instr 0 

stmt :: Instr -> DomInstr
stmt  (e :> i) m = let v = expr e m in  (v : (stmt i v))
stmt  (e :>> i) m = let v = expr e m in  (v : (stmt i m))
stmt Off _ = []


expr ::  Expr -> DomExpr
expr (e1 :+  e2) m = (expr  e1 m) + (expr  e2 m)
expr (e1 :*  e2) m = (expr  e1 m) * (expr  e2 m)
expr (V n) _  =  n
expr  Mem m  = m

val = On ((V 3) :> (( Mem :+ (V 5)) :> Off))
val2 = On ((V 3) :> (( Mem :* (V 5)) :> Off))
val3 = On ((V 3) :>> (( Mem :+ (V 5)) :> Off))
