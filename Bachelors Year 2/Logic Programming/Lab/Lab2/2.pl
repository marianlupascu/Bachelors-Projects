linie(N, C) :- N > 0, write(C), I is N - 1, linie(I, C).
linie(0, _) :- nl.

coloana(N, I, C) :- I > 0, linie(N, C), J is I - 1, coloana(N, J, C).
coloana(_, 0, _) :- nl.

square(N, C) :- coloana(N, N, C).

/* ?- square(10, '* '). */