born(jan, date(20,3,1977)).
born(jeroen, date(2,2,1992)).
born(joris, date(17,3,1995)).
born(jelle, date(1,1,2004)).
born(joan, date(24,12,0)).
born(joop, date(30,4,1989)).
born(jannecke, date(17,3,1993)).
born(jaap, date(16,11,1995)).

year(An, P) :- born(P, date(_,_,An)).

before(date(_,_,A1), date(_,_,A2)) :- A1 < A2.
before(date(_,L1,A1), date(_,L2,A2)) :- A1 == A2, L1 < L2.
before(date(Z1,L1,A1), date(Z2,L2,A2)) :- A1 == A2, L1 == L2, Z1 < Z2.

older(X, R) :- born(X, date(Z1,L1,A1)),
               born(R, date(Z2,L2,A2)),
               before(date(Z1,L1,A1), date(Z2,L2,A2)).
			  
/* ?- year(1995, Person). */
% ?- before(date(31,1,1990), date(7,7,1990)).
% ?- older(jannecke,X).