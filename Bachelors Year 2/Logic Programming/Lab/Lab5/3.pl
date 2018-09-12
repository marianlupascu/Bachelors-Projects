symbol('I', 1).
symbol('V', 5).
symbol("IV", 4).
symbol('X', 10).
symbol("IX", 9).
symbol('L', 50).
symbol("XL", 40).
symbol('C', 100).
symbol("XC", 90).
symbol('D', 500).
symbol("CD", 400).
symbol('M', 1000).
symbol("CM", 900).

symbols2numbers([], []).
symbols2numbers([H1, H2|T], [Aux|Res]) :- string_concat(H1, H2, Sim),
    symbol(Sim, Aux), symbols2numbers(T, Res), !.
symbols2numbers([H|T], [Aux|Res]) :- symbol(H, Aux), symbols2numbers(T, Res).
%?- symbols2numbers(['M', 'M', 'X', 'V'], Values).
%?- symbols2numbers(['X', 'L', 'I', 'I'], Values).

sum([], 0) :- !.
sum([H|T], Rez) :- sum(T, Aux), Rez is Aux + H.

roman2arabic(L, Rez) :- atom_chars(L, Aux),
    symbols2numbers(Aux, Laux), sum(Laux, Rez).
%roman2arabic('MMXVIII',Result).
%roman2arabic('MCMXC',Result).
%roman2arabic('MCMLIV',Result).
%roman2arabic('MDCCLXXVI',Result).