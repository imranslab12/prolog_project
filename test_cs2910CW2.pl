% Test file for CS2910 Coursework 2
% This file contains test cases for all sections of the assignment

% Load the main program
:- [cs2910CW2].

% Section 3.1: Testing Facts
test_facts :-
    write('=== Testing Section 3.1: Facts ===\n'),
    % Test child_of/2
    write('\nTesting child_of/2:\n'),
    child_of(bart, homer),
    child_of(lisa, marge),
    child_of(maggie, homer),
    % Test male/1
    write('\nTesting male/1:\n'),
    male(bart),
    male(homer),
    male(abe),
    % Test female/1
    write('\nTesting female/1:\n'),
    female(marge),
    female(lisa),
    female(maggie),
    % Test age_is/2
    write('\nTesting age_is/2:\n'),
    age_is(bart, 10),
    age_is(lisa, 8),
    age_is(maggie, 1),
    write('\nAll fact tests passed!\n').

% Section 3.2: Testing Rules
test_rules :-
    write('\n=== Testing Section 3.2: Rules ===\n'),
    % Test father_of/2
    write('\nTesting father_of/2:\n'),
    father_of(homer, bart),
    father_of(homer, lisa),
    father_of(homer, maggie),
    % Test mother_of/2
    write('\nTesting mother_of/2:\n'),
    mother_of(marge, bart),
    mother_of(marge, lisa),
    mother_of(marge, maggie),
    % Test sibling_of/2
    write('\nTesting sibling_of/2:\n'),
    sibling_of(bart, lisa),
    sibling_of(lisa, maggie),
    % Test brother_of/2
    write('\nTesting brother_of/2:\n'),
    brother_of(bart, lisa),
    brother_of(bart, maggie),
    % Test sister_of/2
    write('\nTesting sister_of/2:\n'),
    sister_of(lisa, bart),
    sister_of(maggie, bart),
    % Test find_all_parents
    write('\nTesting find_all_parents:\n'),
    find_all_parents(Parents),
    write('Parents: '), write(Parents), nl,
    % Test find_all_parents_setof
    write('\nTesting find_all_parents_setof:\n'),
    find_all_parents_setof(ParentsSet),
    write('Parents (setof): '), write(ParentsSet), nl,
    % Test older_than/2
    write('\nTesting older_than/2:\n'),
    older_than(homer, bart),
    older_than(marge, lisa),
    % Test younger_than/2
    write('\nTesting younger_than/2:\n'),
    younger_than(bart, homer),
    younger_than(maggie, marge),
    % Test twin_of/2
    write('\nTesting twin_of/2:\n'),
    twin_of(patty, selma),
    % Test baby/1
    write('\nTesting baby/1:\n'),
    baby(maggie),
    % Test senior_citizen/1
    write('\nTesting senior_citizen/1:\n'),
    senior_citizen(abe),
    senior_citizen(jacqueline),
    write('\nAll rule tests passed!\n').

% Section 4.1: Testing Path Finding
test_paths :-
    write('\n=== Testing Section 4.1: Path Finding ===\n'),
    % Test valid paths
    write('\nTesting valid paths:\n'),
    path(outside, wc, Path1),
    write('Path from outside to WC: '), write(Path1), nl,
    path(kitchen, balcony, Path2),
    write('Path from kitchen to balcony: '), write(Path2), nl,
    % Test all paths
    write('\nTesting all paths:\n'),
    all_paths(outside, wc, AllPaths),
    write('All paths from outside to WC: '), write(AllPaths), nl,
    % Test invalid locations
    write('\nTesting invalid locations:\n'),
    \+ path(invalid_room, wc, _),
    write('\nAll path finding tests passed!\n').

% Section 4.2: Testing Meeting Paths
test_meeting_paths :-
    write('\n=== Testing Section 4.2: Meeting Paths ===\n'),
    % Test meeting paths
    write('\nTesting meeting paths:\n'),
    meet_at(outside, kitchen, living_room, CombinedPath),
    write('Combined path from outside and kitchen to living room: '), write(CombinedPath), nl,
    % Test all meeting paths
    write('\nTesting all meeting paths:\n'),
    all_meeting_paths(outside, kitchen, living_room, AllMeetingPaths),
    write('All meeting paths: '), write(AllMeetingPaths), nl,
    % Test shortest meeting path
    write('\nTesting shortest meeting path:\n'),
    shortest_meeting_path(outside, kitchen, living_room, ShortestPath),
    write('Shortest meeting path: '), write(ShortestPath), nl,
    write('\nAll meeting path tests passed!\n').

% Run all tests
run_all_tests :-
    test_facts,
    test_rules,
    test_paths,
    test_meeting_paths,
    write('\nAll tests completed successfully!\n'). 