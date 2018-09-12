inverseaza(L,Linv)	:- inv1(L,[],Linv).
inv1([],L,L).
inv1([X|Rest],Ltemp,Linv):- inv1(Rest,[X|Ltemp],Linv).

verificare([], []).
verificare([T1|L1], [T2|L2]) :- T1 == T2, verificare(L1, L2).
    
palindrome([]).
palindrome(L) :- inverseaza(L, A), verificare(L, A).

/* palindrome([r,e,d,i,v,i,d,e,r]).*/