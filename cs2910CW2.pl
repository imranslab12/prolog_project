%% CS2910 Assessed Coursework 2
%% This file contains the Prolog implementation for the coursework.
%% Ensure to test each predicate in SWI-Prolog using the queries provided in the comments.

%% 3.1 Facts - Representing the Family Tree

child_of(bart, homer).
child_of(lisa, homer).
child_of(maggie, homer).
child_of(bart, marge).
child_of(lisa, marge).
child_of(maggie, marge).
child_of(marge, jacqueline).
child_of(patty, jacqueline).
child_of(selma, jacqueline).
child_of(homer, abe).
child_of(homer, mona).

male(abe).
male(homer).
male(bart).

female(jacqueline).
female(mona).
female(marge).
female(patty).
female(selma).
female(lisa).
female(maggie).

age_is(jacqueline, 90).
age_is(abe, 87).
age_is(mona, 64).
age_is(homer, 38).
age_is(marge, 40).
age_is(patty, 46).
age_is(selma, 46).
age_is(bart, 10).
age_is(lisa, 8).
age_is(maggie, 1).

%% TEST: Run the following queries in SWI-Prolog to verify correctness:
%% ?- child_of(bart, homer).
%% ?- male(homer).
%% ?- female(marge).
%% ?- age_is(abe, X).

%% 3.2 Rules - Defining Relationships

father_of(X, Y) :- male(X), child_of(Y, X).
mother_of(X, Y) :- female(X), child_of(Y, X).
sibling_of(X, Y) :- child_of(X, P), child_of(Y, P), X \= Y.

older_than(X, Y) :- age_is(X, AgeX), age_is(Y, AgeY), AgeX > AgeY.
younger_than(X, Y) :- age_is(X, AgeX), age_is(Y, AgeY), AgeX < AgeY.

twin_of(X, Y) :- sibling_of(X, Y), age_is(X, Age), age_is(Y, Age).

baby(X) :- age_is(X, Age), Age < 2.
senior_citizen(X) :- age_is(X, Age), Age > 75.

%% Find all parents using findall/3
parents(Parents) :-
    findall(X, child_of(_, X), AllParents),
    list_to_set(AllParents, Parents).
%% Find all parents using setof/3
parents_set(ParentsSet) :-
    setof(X, (child_of(_, X), (male(X); female(X))), ParentsSet).

%% TEST: Run the following queries in SWI-Prolog to verify correctness:
%% ?- father_of(homer, bart).
%% ?- mother_of(marge, bart).
%% ?- sibling_of(lisa, bart).
%% ?- older_than(marge, homer).
%% ?- younger_than(maggie, lisa).
%% ?- twin_of(patty, selma).
%% ?- baby(maggie).
%% ?- senior_citizen(abe).
%% ?- parents(Parents).
%% ?- parents_set(ParentsSet).
