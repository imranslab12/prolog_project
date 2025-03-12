% CS2910 Coursework 2 Solution

%% 3.1 Family Tree Facts %%

% child_of(Child, Parent)
child_of(bart, homer).
child_of(bart, marge).
child_of(lisa, homer).
child_of(lisa, marge).
child_of(maggie, homer).
child_of(maggie, marge).
child_of(homer, abe).
child_of(homer, mona).
child_of(marge, jacqueline).
child_of(selma, jacqueline).
child_of(patty, jacqueline).

% male/1
male(bart).
male(homer).
male(abe).

% female/1
female(marge).
female(lisa).
female(maggie).
female(mona).
female(jacqueline).
female(selma).
female(patty).

% age_is(Person, Age)
age_is(bart, 10).
age_is(lisa, 8).
age_is(maggie, 1).
age_is(homer, 38).
age_is(marge, 40).
age_is(abe, 87).
age_is(mona, 64).
age_is(jacqueline, 90).
age_is(patty,46).
age_is(selma, 46).

%% 3.2 Family Tree Rules %%

% father_of(Father, Child)
father_of(Father, Child) :- 
    child_of(Child, Father), 
    male(Father).

% mother_of(Mother, Child)
mother_of(Mother, Child) :- 
    child_of(Child, Mother), 
    female(Mother).

% sibling_of(Sibling1, Sibling2)
sibling_of(Sibling1, Sibling2) :-
    Sibling1 \= Sibling2,
    child_of(Sibling1, Parent),
    child_of(Sibling2, Parent).

% brother_of(Brother, Person)
brother_of(Brother, Person) :-
    sibling_of(Brother, Person),
    male(Brother).

% sister_of(Sister, Person)
sister_of(Sister, Person) :-
    sibling_of(Sister, Person),
    female(Sister).

% Using findall to return a list of parents
find_all_parents(Parents) :-
    findall(Parent, (child_of(_, Parent)), ParentsWithDuplicates),
    sort(ParentsWithDuplicates, Parents).

% Using setof to return a list of parents
find_all_parents_setof(Parents) :-
    setof(Parent, Child^child_of(Child, Parent), Parents).

/* 
Comment: The difference between findall and setof is that:
1. findall will return duplicates if the same parent appears multiple times
2. setof automatically removes duplicates and sorts the results
3. setof fails if there are no solutions, while findall returns an empty list
4. In setof, Child^ is used to existentially quantify Child, meaning we're interested
   in collecting Parent values, ignoring which Child they relate to
*/

% older_than(Person1, Person2)
older_than(Person1, Person2) :-
    age_is(Person1, Age1),
    age_is(Person2, Age2),
    Age1 > Age2.

% younger_than(Person1, Person2)
younger_than(Person1, Person2) :-
    age_is(Person1, Age1),
    age_is(Person2, Age2),
    Age1 < Age2.

% twin_of(Person1, Person2)
twin_of(Person1, Person2) :-
    Person1 \= Person2,
    sibling_of(Person1, Person2),
    age_is(Person1, Age),
    age_is(Person2, Age).

% baby(Person)
baby(Person) :-
    age_is(Person, Age),
    Age < 2.

% senior_citizen(Person)
senior_citizen(Person) :-
    age_is(Person, Age),
    Age > 75.

%% 4.1 House Path Finding %%

% Define connections between locations (bidirectional)
connected(outside, porch1).
connected(porch1, kitchen).
connected(kitchen, living_room).
connected(living_room, corridor).
connected(corridor, wc).
connected(corridor, bedroom1).
connected(corridor, bedroom2).
connected(outside, porch2).
connected(porch2, living_room).
connected(bedroom1, balcony).
connected(bedroom2, balcony).

% Make connections bidirectional
connects(X, Y) :- connected(X, Y).
connects(X, Y) :- connected(Y, X).

% Valid locations
location(outside).
location(porch1).
location(porch2).
location(kitchen).
location(living_room).
location(corridor).
location(wc).
location(bedroom1).
location(bedroom2).
location(balcony).

% Check if locations are valid
valid_location(Location) :- location(Location), !.
valid_location(Location) :- 
    write('Error: '), write(Location), 
    write(' is not a valid location in this house plan.'), nl, fail.

% Find a path from origin to destination
% Using depth-first search with cycle detection
path(Origin, Destination, Path) :-
    valid_location(Origin),
    valid_location(Destination),
    depth_first_search(Origin, Destination, [Origin], Path).

% Base case: We've reached the destination
depth_first_search(Destination, Destination, Visited, Path) :-
    reverse(Visited, Path).

% Recursive case: Try each neighbor we haven't visited yet
depth_first_search(Current, Destination, Visited, Path) :-
    connects(Current, Next),
    \+ member(Next, Visited),  % Avoid cycles
    depth_first_search(Next, Destination, [Next|Visited], Path).

% Find all paths (wrapper for findall)
all_paths(Origin, Destination, Paths) :-
    valid_location(Origin),
    valid_location(Destination),
    findall(Path, path(Origin, Destination, Path), Paths).

/* 
This implementation uses depth-first search to find paths.
Depth-first search explores as far as possible along each branch before backtracking.
It uses the Prolog's backtracking mechanism to find all possible paths.
The algorithm maintains a list of visited locations to avoid cycles.
*/

%% 4.2 Paths Ending at a Common Destination %%

% Find paths from two origins to a common destination
meet_at(Origin1, Origin2, Destination, CombinedPath) :-
    path(Origin1, Destination, Path1),
    path(Origin2, Destination, Path2),
    % Combine the paths (Path2 in reverse without duplicating Destination)
    reverse(Path2, RevPath2),
    append(Path1, RevPath2, TempPath),
    remove_duplicate_destination(TempPath, CombinedPath).

% Remove duplicate destination in the combined path
remove_duplicate_destination([H|T], [H|Result]) :-
    remove_duplicate_destination_helper(H, T, Result).

remove_duplicate_destination_helper(_, [], []).
remove_duplicate_destination_helper(Duplicate, [Duplicate|T], Result) :-
    remove_duplicate_destination_helper(Duplicate, T, Result).
remove_duplicate_destination_helper(Duplicate, [H|T], [H|Result]) :-
    H \= Duplicate,
    remove_duplicate_destination_helper(Duplicate, T, Result).

% Find all meeting paths
all_meeting_paths(Origin1, Origin2, Destination, Paths) :-
    findall(Path, meet_at(Origin1, Origin2, Destination, Path), Paths).

% Find the shortest meeting path
shortest_meeting_path(Origin1, Origin2, Destination, ShortestPath) :-
    findall(Path, meet_at(Origin1, Origin2, Destination, Path), Paths),
    Paths \= [],  % Ensure there's at least one path
    shortest_path(Paths, ShortestPath).

% Helper to find the shortest path in a list of paths
shortest_path([Path], Path) :- !.
shortest_path([Path1,Path2|Paths], ShortestPath) :-
    length(Path1, Len1),
    length(Path2, Len2),
    (Len1 =< Len2 ->
        shortest_path([Path1|Paths], ShortestPath)
    ;
        shortest_path([Path2|Paths], ShortestPath)
    ).