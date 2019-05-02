

data Alegere = Piatra | Foarfeca | Hartie
               deriving (Eq, Show)

data Rezultat = Victorie | Infrangere | Egalitate
                deriving (Show, Eq)

partida :: Alegere -> Alegere -> Rezultat
partida Piatra Piatra = Egalitate
partida Foarfeca Foarfeca = Egalitate
partida Hartie Hartie = Egalitate
partida Piatra Foarfeca = Victorie
partida Piatra Hartie = Infrangere
partida Foarfeca Piatra = Infrangere
partida Foarfeca Hartie = Victorie
partida Hartie Piatra = Victorie
partida Hartie Foarfeca = Infrangere
