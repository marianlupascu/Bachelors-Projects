all_a([]).
all_a([X|Tail]) :- all_a(Tail), X = 'a'.
/* all_a([a,A,a,a,B]).*/

all_b([]).
all_b([X|Tail]) :- all_b(Tail), X = 'b'.

%trans_a_b(X, Y) :- all_a(X), all_b(Y), length(X, Z), length(Y, Z).
trans_a_b([],[]).
trans_a_b(['a'|H1], ['b'|H2]) :- trans_a_b(H1, H2).

/*trans_a_b([a,a,a],L).*/
/* trans_a_b([a,a,a],[b]).*/
/* trans_a_b(L,[b,b]).*/