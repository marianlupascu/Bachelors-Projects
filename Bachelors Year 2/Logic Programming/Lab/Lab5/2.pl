:- include('words.pl').

word_letters(L,X) :- atom_chars(L,X).
%word_letters(hello,X).

selection(E, [E|Ls], Ls).
selection(E, [L|Ls], [L|Rest]) :- selection(E, Ls, Rest).

cover([], _).
cover([L|Ls], Cs0) :- selection(L, Cs0, Cs), cover(Ls, Cs).
%?- cover([a,e,i,o], [m,o,n,k,e,y,b,r,a,i,n]).
%?- cover([e,e,l], [h,e,l,l,o]).

solution(L, Word, Len) :- word(Word), word_letters(Word, List), 
						cover(List, L), length(List, Len).
%?- solution([g,i,g,c,n,o,a,s,t], Word, 3).

topsolution(L, Word, Scor) :- topsolution_aux(L, Word, Scor, 45).
topsolution_aux(L, Word, Scor, Scor) :- solution(L, Word, Scor), !.
topsolution_aux(L, Word, Scor, Current) :- Nscor is Current - 1, topsolution_aux(L, Word, Scor, Nscor).
%?- topsolution([y,c,a,l,b,e,o,s,x], Word, Score).