/*A*/
scalarMult(_, [], []).
scalarMult(S, [X|Tail], [Z|Rez]) :- Z is X * S, 
    scalarMult(S, Tail, Rez).
/* scalarMult(3,[2,7,4],Result).*/

/*B*/
dot([], [], 0).
dot([X1|L1], [X2|L2], Result) :- Prod is X1 * X2,
  dot(L1, L2, Remaining), Result is Prod + Remaining.
/* dot([2,5,6],[3,4,1],Result).*/

/*C*/
maxim([X|[]], X).
maxim([X|L], Result) :- 
	maxim(L, Remaining), Result is max(X, Remaining).
/* maxim([4,2,6,8,1],Result).*/