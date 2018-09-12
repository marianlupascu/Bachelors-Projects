element_at([], _, _) :- 1 > 2.

element_at([X|_], 1, X).

element_at([_|L], N, R) :- Aux is N-1 ,element_at(L, Aux, R).