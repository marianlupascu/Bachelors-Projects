male(rickard).
male(eddard).
male(brandon).
male(benjen).
male(robb).
male(bran).
male(rickon).
male(john).
male(aerys).
male(rahaegar).
male(viserys).
male(aergon).

female(lyarra).
female(catelyn).
female(lyanna).
female(sansa).
female(arya).
female(rhaella).
female(elia).
female(daenerys).
female(rhaenys).

parent_of(rickard, eddard).
parent_of(rickard, brandon).
parent_of(rickard, benjen).
parent_of(rickard, lyanna).
parent_of(lyarra, eddard).
parent_of(lyarra, brandon).
parent_of(lyarra, benjen).
parent_of(lyarra, lyanna).
parent_of(catelyn, robb).
parent_of(catelyn, sansa).
parent_of(catelyn, arya).
parent_of(catelyn, bran).
parent_of(catelyn, rickon).
parent_of(eddard, robb).
parent_of(eddard, sansa).
parent_of(eddard, arya).
parent_of(eddard, bran).
parent_of(eddard, rickon).
parent_of(lyanna, john).
parent_of(rahaegar, john).
parent_of(aerys, rahaegar).
parent_of(aerys, viserys).
parent_of(aerys, daenerys).
parent_of(rhaella, rahaegar).
parent_of(rhaella, viserys).
parent_of(rhaella, daenerys).
parent_of(rahaegar, rhaenys).
parent_of(rahaegar, aergon).
parent_of(elia, rhaenys).
parent_of(elia, aergon).

father_of(X, Y) :- parent_of(X, Y),
					male(X).

mother_of(X, Y) :- parent_of(X, Y),
					female(X).

grandfather_of(X, Y) :- father_of(X, Z),
    					parent_of(Z, Y).

grandmother_of(X, Y) :- mother_of(X, Z),
    					parent_of(Z, Y).

sister_of(X, Y) :- parent_of(Z, X),
    			   parent_of(Z, Y),
    			   X \== Y,
    			   female(X).

brother_of(X, Y) :- parent_of(Z, X),
    			    parent_of(Z, Y),
    				X \== Y,
    			    male(X).

aunt_of(X, Y) :- parent_of(Z, Y),
    			 sister_of(X, Z).

uncle_of(X, Y) :- parent_of(Z, Y),
    			  brother_of(X, Z).
				  
%?-aunt_of(daenerys, john).

