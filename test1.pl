
  child_of(bart, homer).
  male(homer).
  female(marge).
  age_is(abe, X).

  father_of(homer, bart).
  mother_of(marge, bart).
  sibling_of(lisa, bart).
  older_than(marge, homer).
  younger_than(maggie, lisa).
  twin_of(patty, selma).
  baby(maggie).
  senior_citizen(abe).



  path(outside, wc, P).
  path(kitchen, wc, P).


  bi_path(outside, kitchen, wc, P1, P2).


-----------------------------------

% Find a path from outside to the WC
% path(outside, wc, Path).

% Find a path from bedroom_1 to the kitchen
% path(bedroom_1, kitchen, Path).

?- find_path(outside, wc, Path).
?- all_paths(outside, wc, Paths).
?- bidirectional_path(kitchen, bedroom1, wc, Path1, Path2).
?- shortest_meeting_path(kitchen, bedroom1, wc, ShortestPath1, ShortestPath2).
