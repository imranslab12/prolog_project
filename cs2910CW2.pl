%% CS2910 Assessed Coursework 2
%% Optimized Prolog Implementation

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

%% 3.2 Rules - Defining Relationships

father_of(X, Y) :- male(X), child_of(Y, X), !.
mother_of(X, Y) :- female(X), child_of(Y, X), !.
sibling_of(X, Y) :- child_of(X, P), child_of(Y, P), X \= Y, !.
grandfather_of(X, Y) :- male(X), child_of(Z, X), child_of(Y, Z).
daughter_of(X, Y) :- female(X), child_of(X, Y).

older_than(X, Y) :- age_is(X, AgeX), age_is(Y, AgeY), AgeX > AgeY.
younger_than(X, Y) :- age_is(X, AgeX), age_is(Y, AgeY), AgeX < AgeY.
twin_of(X, Y) :- sibling_of(X, Y), age_is(X, Age), age_is(Y, Age), !.
baby(X) :- age_is(X, Age), Age < 2.
senior_citizen(X) :- age_is(X, Age), Age > 75.

%% Find all parents using findall/3
parents(Parents) :-
    findall(X, child_of(_, X), AllParents),
    list_to_set(AllParents, Parents).

%% Find all parents using setof/3
parents_set(ParentsSet) :-
    setof(X, Y^child_of(Y, X), ParentsSet).

%% House Navigation System

connected(outside, porch1).
connected(porch1, kitchen).
connected(outside, porch2).
connected(porch2, living_room).
connected(kitchen, living_room).
connected(living_room, corridor).
connected(corridor, wc).
connected(corridor, bathroom).
connected(corridor, bedroom1).
connected(corridor, bedroom2).

connected(porch1, outside).
connected(kitchen, porch1).
connected(porch2, outside).
connected(living_room, kitchen).
connected(living_room, porch2).
connected(corridor, living_room).
connected(wc, corridor).
connected(bathroom, corridor).
connected(bedroom1, corridor).
connected(bedroom2, corridor).

% Define bidirectional paths
path(A, B) :- connected(A, B).
path(A, B) :- connected(B, A).

% Reverse a list efficiently
reverse_list(List, Reversed) :- reverse_acc(List, [], Reversed).
reverse_acc([], Acc, Acc).
reverse_acc([H|T], Acc, Reversed) :- reverse_acc(T, [H|Acc], Reversed).

% Depth-first search for pathfinding with cycle avoidance
find_path(O, D, Path) :-
    search(O, D, [O], RevPath),
    reverse_list(RevPath, Path).

search(D, D, Path, Path).
search(Current, Destination, Visited, Path) :-
    path(Current, Next),
    \+ member(Next, Visited), % Avoid loops
    search(Next, Destination, [Next|Visited], Path).

% Find all possible paths
all_paths(O, D, Paths) :-
    findall(P, find_path(O, D, P), Paths).

% Error handling
find_path_safe(O, D, Path) :-
    ( path(O, _) -> 
    ( path(D, _) -> find_path(O, D, Path)
    ; write('Error: Invalid destination.'), nl, fail )
    ; write('Error: Invalid origin.'), nl, fail ).

% Bi-directional path search
bidirectional_path(O1, O2, D, Path1, Path2) :-
    find_path(O1, D, Path1),
    find_path(O2, D, Path2).

% Find shortest paths to common destination
shortest_meeting_path(O1, O2, D, ShortestPath1, ShortestPath2) :-
    findall((P1, P2), bidirectional_path(O1, O2, D, P1, P2), Paths),
    sort(2, @=<, Paths, Sorted),
    nth0(0, Sorted, (ShortestPath1, ShortestPath2)).
