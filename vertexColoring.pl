:- dynamic(edge/2).
:- dynamic(color/1).

map([[1,2],[2,1],[2,3],[2,4],[3,2],[3,5],[4,2],[4,5],[5,3],[5,4]]).
colors([red,green,blue]).

result(X) :-
    % create edges from map
    map(Map), loop(Map),
    % create color from colors
    colors(Colors), createColors(Colors),
    % get list of all vertices, remove duplicates
    findall(V, edge(V, _), Vertices1), removeDuplicates(Vertices1, Vertices2),
    % get number of vertices
    length(Vertices2, Len),
    % call recursive predicate
    colorGraph(Vertices2, Len, [], X).

loop([]).
loop([H|T]) :-
    createEdges(H),
    loop(T).

createEdges(List) :-
    firstEle(List, Vertex),
    lastEle(List, Neighbour),
    assertz(edge(Vertex, Neighbour)).

createColors([]).
createColors([H|T]):-
    assertz(color(H)),
    createColors(T).

colorGraph(_, Len, Solution, X) :-
    % check if # of colored vertices == # of verticies
    length(Solution, L),
    L =:= Len,
    % if so, unify X with Solution
    X = Solution.

colorGraph(Verticies, Len, Solution, X) :-
    % color vertex
    colorVertex(Verticies, Solution, ColoredVertex),
    % append colored vertex to solution
    append(Solution, [ColoredVertex], NewSolution),
    % remove colored vertex from list of vertices
    trimList(Verticies, RemainingVertices),
    % recursive call
    colorGraph(RemainingVertices, Len, NewSolution, X).
    
colorVertex([FirstEle|_], X, ColoredVertex) :-
    % findall FirstEle Neigbours
    findall(N, edge(FirstEle, N), Neighbours),
    % check if any Neighbours have been assigned Color
    color(Color), checkNeighbours(Neighbours, Neighbours, X, Color),
	% return valid vector-color
	ColoredVertex = [FirstEle-Color].

checkNeighbours([], _, _, _).
checkNeighbours([H|T], Neighbours, X, Color) :-
    % check if current color is valid
    isColorValid([H-Color], Color, X, Neighbours, T),
    % recursive call
    checkNeighbours(T, Neighbours, X, Color).

isColorValid([H-Color], Color, X, Neighbours, T) :-
    % check if vertex has already been colored
    \+ member([H-Color], X) ;
    % if it has, pick next color and return all neighbours as T
    (	color(Color), T = Neighbours	).

% get first element of a list
firstEle([H|_], H).
% get last element of a list 
lastEle([_|[T]], T).
% remove first element of a list
trimList([_|T], T).

% member/2
member(X, [X|_]). 
member(X, [_|R]) :- member(X, R).

% append/3
append([], L, L).
append([H|T], L, [H|R]) :-
    append(T, L, R).

% length/2
length([], 0).
length([_|T], I) :- 
    length(T, J), I is J + 1.

% remove duplicate elements from a list
removeDuplicates([], []).
removeDuplicates([H|T], R) :-
    member(H, T), !,
    removeDuplicates(T, R).
removeDuplicates([H|T], [H|R]) :-
    removeDuplicates(T, R).