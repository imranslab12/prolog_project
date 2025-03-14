?- path(outside, porch1).       % Should return true.
?- path(porch1, outside).       % Should return true (bidirectional).
?- path(living_room, bedroom1). % Should return true.
?- path(bedroom1, bathroom).    % Should return true (via corridor).
?- path(outside, kitchen).      % Should return false (no direct connection).


?- find_path(outside, kitchen, Path).
% Expected output: Path should show a route like [outside, porch1, kitchen].

?- find_path(outside, masterbedroom, Path).
% Expected output: A valid path, e.g., [outside, porch1, kitchen, living_room, corridor, masterbedroom].

?- find_path(masterbedroom, bathroom, Path).
% Expected output: A valid path through corridor, e.g., [masterbedroom, corridor, bathroom].

?- find_path(outside, bedroom1, Path).
% Expected output: Should return a path that reaches bedroom1.


?- all_paths(outside, bathroom, Paths).
% Expected output: A list of possible paths.

?- all_paths(outside, bedroom1, Paths).
% Expected output: A list of paths to bedroom1.

?- find_path_safe(outside, bedroom999, Path).
% Expected output: "Error: Invalid destination." and failure.

?- find_path_safe(garage, living_room, Path).
% Expected output: "Error: Invalid origin." and failure.


?- bidirectional_path(outside, porch2, living_room, Path1, Path2).
% Expected output: Two valid paths from `outside` and `porch2` to `living_room`.

?- bidirectional_path(kitchen, bathroom, bedroom1, Path1, Path2).
% Expected output: Two valid paths leading to `bedroom1`.


?- shortest_meeting_path(outside, bedroom1, living_room, ShortestPath1, ShortestPath2).
% Expected output: The shortest paths from `outside` and `bedroom1` to `living_room`.

?- shortest_meeting_path(outside, masterbedroom, bathroom, ShortestPath1, ShortestPath2).
% Expected output: The shortest paths leading to `bathroom`.
