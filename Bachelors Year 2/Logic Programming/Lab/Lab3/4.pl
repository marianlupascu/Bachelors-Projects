remove_duplicates([], []).
remove_duplicates([X|[]], [X]).
remove_duplicates([X|L], [X|Res]) :- not(member(X, L)), remove_duplicates(L, Res).
remove_duplicates([X|L], Res) :- member(X, L), remove_duplicates(L, Res).

/*remove_duplicates(L, Res) :- sort(L, Res).*/

/* ?- remove_duplicates([], []).*/