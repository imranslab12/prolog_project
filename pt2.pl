%% 4.1 Finding a Path in a House

connected(outside, porch1).
connected(porch1, kitchen).
connected(kitchen, living_room).
connected(living_room, corridor).
connected(corridor, wc).

path(X, X, [X]).
path(X, Y, [X|P]) :- connected(X, Z), path(Z, Y, P).

%% TEST: Run the following queries in SWI-Prolog to verify correctness:
%% ?- path(outside, wc, P).
%% ?- path(kitchen, wc, P).

%% 4.2 Bi-Directional Search to a Common Destination

bi_path(O1, O2, D, P1, P2) :- path(O1, D, P1), path(O2, D, P2).

%% TEST: Run the following queries in SWI-Prolog to verify correctness:
%% ?- bi_path(outside, kitchen, wc, P1, P2).
