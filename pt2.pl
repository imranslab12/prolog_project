% Define the connections between locations
connected(outside, porch1).
connected(porch1, kitchen).
connected(kitchen, living_room).
connected(living_room, corridor).
connected(corridor, wc).
connected(living_room, bedroom1).
connected(living_room, bedroom2).
connected(corridor, bedroom1).
connected(corridor, bedroom2).
connected(corridor, bathroom).
connected(kitchen, pantry).

% Define bidirectional connections
path(A, B) :- connected(A, B).
path(A, B) :- connected(B, A).

% Reverse a list
reverse_list([], []).
reverse_list([H|T], Rev) :- reverse_list(T, RevT), append(RevT, [H], Rev).

% Depth-first search for pathfinding
find_path(O, D, Path) :-
    search(O, D, [O], RevPath),
    reverse_list(RevPath, Path).

search(D, D, Path, Path). % If destination is reached
search(Current, Destination, Visited, Path) :-
    path(Current, Next),
    \+ member(Next, Visited), % Avoid loops
    search(Next, Destination, [Next|Visited], Path).

% Find all possible paths
all_paths(O, D, Paths) :-
    findall(P, (find_path(O, D, P)), Paths).

% Error handling
find_path_safe(O, D, Path) :-
    ( path(O, _) -> ( path(D, _) -> find_path(O, D, Path)
    ; write('Error: Invalid destination.'), fail )
    ; write('Error: Invalid origin.'), fail ).

% Bi-directional path search
bidirectional_path(O1, O2, D, Path1, Path2) :-
    find_path(O1, D, Path1),
    find_path(O2, D, Path2).

% Find shortest paths to common destination
shortest_meeting_path(O1, O2, D, ShortestPath1, ShortestPath2) :-
    findall((P1, P2), bidirectional_path(O1, O2, D, P1, P2), Paths),
    min_member((ShortestPath1, ShortestPath2), Paths).