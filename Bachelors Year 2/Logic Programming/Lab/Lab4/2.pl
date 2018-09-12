successor(L, ['x'|L]).

plus([], L, L).
plus(L, [], L).
plus([_|A1], [_|A2], ['x', 'x'|R]) :- plus(A1, A2, R).

times([], _, []).
times(_, [], []).
times([_|A], L, R) :- times(A, L, Aux), plus(Aux, L, R).

/*?- successor([],Result). */
/*?- plus([x, x], [x, x, x, x], Result). */
/*?- times([x, x], [x, x, x, x], Result). */