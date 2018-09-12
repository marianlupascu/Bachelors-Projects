is_var(a).
is_var(b).
is_var(c).

:- op(610, fy, nu).
:- op(620, yfx, si).
:- op(620, yfx, sau).
:- op(630, xfx, imp).

table_nu(0, 1).
table_nu(1, 0).

table_si(0, 0, 0).
table_si(0, 1, 0).
table_si(1, 0, 0).
table_si(1, 1, 1).

table_sau(0, 0, 0).
table_sau(0, 1, 1).
table_sau(1, 0, 1).
table_sau(1, 1, 1).

table_imp(0, 0, 1).
table_imp(0, 1, 1).
table_imp(1, 0, 0).
table_imp(1, 1, 1).

formula(X) :- is_var(X).
formula(nu X) :- formula(X).
formula(X si Y) :- formula(X), formula(Y).
formula(X sau Y) :- formula(X), formula(Y).
formula(X imp Y) :- formula(X), formula(Y).

test :- catch(read(X), _, false), X.

find_vars_helper(X, [X]) :- is_var(X).
find_vars_helper(nu X, V) :- find_vars_helper(X, V).
find_vars_helper(X si Y, Vfin) :- find_vars_helper(X, V1), find_vars_helper(Y, V2), append(V1, V2, Vfin).
find_vars_helper(X sau Y,Vfin) :- find_vars_helper(X, V1), find_vars_helper(Y, V2), append(V1, V2, Vfin).
find_vars_helper(X imp Y,Vfin) :- find_vars_helper(X, V1), find_vars_helper(Y, V2), append(V1, V2, Vfin).

find_vars(X, _, Vfin) :- find_vars_helper(X, Vaux), sort(Vaux, Vfin).

firstList(0, []) :- !.
firstList(N, [0 | List]) :- M is N - 1, firstList(M, List).

addOne([0 | L], [1 | L]).
addOne([1 | L], [0 | Res]) :- addOne(L, Res).

generate_all(0, _, []) :- !.
generate_all(N, L, [Laux | Res]) :- addOne(L, Laux), M is N - 1, generate_all(M, Laux, Res).

all_assigns(0, [[]]) :- !.
all_assigns(N, [FList | Res]) :- firstList(N, FList), M is 2**N - 1, generate_all(M, FList, Res).

var_value(Variable, [Variable | _], [TruthValue | _], TruthValue).
var_value(Variable, [_ | VarListRest], [_ | TruthValuesRest], TruthValue) :-
    var_value(Variable, VarListRest, TruthValuesRest, TruthValue).

truth_value(X, Var, A, Val) :- is_var(X), var_value(X, Var, A, Val).
truth_value(nu X, Var, A, Val) :- truth_value(X, Var, A, ValAux), table_nu(ValAux, Val).
truth_value(X si Y, Var, A, Val) :- truth_value(X, Var, A, ValAux1), truth_value(Y, Var, A, ValAux2), table_si(ValAux1, ValAux2, Val).
truth_value(X sau Y, Var, A, Val) :- truth_value(X, Var, A, ValAux1), truth_value(Y, Var, A, ValAux2), table_sau(ValAux1, ValAux2, Val).
truth_value(X imp Y, Var, A, Val) :- truth_value(X, Var, A, ValAux1), truth_value(Y, Var, A, ValAux2), table_imp(ValAux1, ValAux2, Val).

all_values(_, _, [], []).
all_values(X, Var, [LaHead | LaTail], [ValRes | LRec]) :- truth_value(X, Var, LaHead, ValRes), all_values(X, Var, LaTail, LRec).

values_all_assigns(X, LVal) :- find_vars(X, [], Var), length(Var, VarLength),
    all_assigns(VarLength, LA), all_values(X, Var, LA, LVal).

is_taut_helper([]) :- print('este tautologie').
is_taut_helper([0 | _]) :- print('nu este tautologie').
is_taut_helper([1 | Tail]) :- is_taut_helper(Tail).

is_taut(X) :- values_all_assigns(X, LVal), is_taut_helper(LVal).


