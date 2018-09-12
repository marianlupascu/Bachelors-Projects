la_dreapta(X,Y) :- X =:= Y + 1.

la_stanga(X,Y) :- X =:= Y - 1.

langa(X, Y) :- la_dreapta(X,Y).
langa(X, Y) :- la_stanga(X,Y).

%casa(Numar,Nationalitate,Culoare,AnimalCompanie,Bautura,Tigari)

solutie(Strada,PosesorZebra, BeaApa) :- Strada = [
casa(1,_,_,_,_,_),
casa(2,_,_,_,_,_),
casa(3,_,_,_,_,_),
casa(4,_,_,_,_,_),
casa(5,_,_,_,_,_)],

member(casa(_,englez,rosie,_,_,_), Strada),
member(casa(_,spaniol,_,caine,_,_), Strada),
member(casa(_,_,verde,_,cafea,_), Strada),
member(casa(_,ucrainian,_,_,ceai,_), Strada),

member(casa(X,_,bej,_,_,_), Strada),
member(casa(Y,_,verde,_,_,_), Strada),
la_dreapta(Y, X),
    
member(casa(_,_,_,melci,_,'Old Gold'), Strada),
member(casa(_,_,galben,_,_,'Kools'), Strada),
member(casa(3,_,_,_,lapte,_), Strada),
member(casa(1,norvegian,_,_,_,_), Strada),

member(casa(Z,_,_,vulpe,_,_), Strada),
member(casa(T,_,_,_,_,'Chesterfields'), Strada),
langa(Z, T),
    
member(casa(U,_,_,cal,_,_), Strada),
member(casa(V,_,_,_,_,'Kools'), Strada),
langa(U, V),
    
member(casa(_,_,_,_,sucPortocale,'Lucky Strike'), Strada),
member(casa(_,japonez,_,_,_,'Parliaments'), Strada),

member(casa(S,_,albastru,_,_,_), Strada),
member(casa(P,norvegian,_,_,_,_), Strada),
langa(S, P),

member(casa(_,PosesorZebra,_,zebra,_,_), Strada),
member(casa(_,BeaApa,_,_,apa,_), Strada).

% ?- solutie(Strada,PosesorZebra, BeaApa).