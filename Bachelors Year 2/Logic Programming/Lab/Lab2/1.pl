distance((X1, Y1), (X2, Y2), X) :- X is sqrt((X2 - X1) ** 2 + 
                                            (Y2 - Y1) ** 2).
/* ?- distance((-2.5,1), (3.5,-4), X). */