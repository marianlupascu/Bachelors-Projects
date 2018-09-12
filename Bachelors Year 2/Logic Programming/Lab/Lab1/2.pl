sits_right_of('Grand Maester Pycelle', 'Tyrilon Lannister').
sits_right_of('Varys', 'Grand Maester Pycelle').
sits_right_of('Petyr Baelish', 'Varys').
sits_right_of('Tywin Lannister', 'Petyr Baelish').
sits_right_of('Cersei Baratheon', 'Tywin Lannister').
sits_right_of('Janos Slynt', 'Cersei Baratheon').
sits_right_of('Tyrilon Lannister', 'Janos Slynt').

sits_left_of(X,Y) :- sits_right_of(Y, X).

are_neighbors_of(X,Y,Z) :- sits_right_of(Y, Z), 
    					   sits_left_of(X, Z).

next_to_each_other(X,Y) :- sits_right_of(Y, X).
next_to_each_other(X,Y) :- sits_left_of(Y, X).

/*?- sits_right_of('Petyr Baelish', 'Cersei Baratheon').*/
/*?- sits_right_of('Petyr Baelish', 'Varys').*/
/*?- sits_right_of(X, 'Janos Slynt').*/
/*?- sits_right_of(Y, X), sits_right_of(X, 'Cersei Baratheon').*/
/*?- next_to_each_other(X, 'Petyr Baelish'),
next_to_each_other(X, 'Grand Maester Pycelle').*/