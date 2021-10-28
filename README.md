# Vertex Coloring
Prolog program that preforms vertex coloring on a given graph/map. Vertex coloring is an assignment of colors to each vertex of a graph such that no edge connects two identically colored vertices. Compile using swi-prolog or gprolog.

# Predicates
dynamic edge/2, dynamic color/1:
  Dynamic predicates which will be added into the database during execution to keep track of the edges between vertices and the colors defined in the initial list. Using these facts means less dealing with lists.

map/1:
  The single fact defining the map. I chose to define the map as an undirected graph. So connections between vertices are defined both ways ([a,b],[b,a]).

colors/1:
  The single fact defining the set of colors.

result/1:
  The predicate which is called by the user. It creates the dynamic facts from the map and colors fact. Gets a list of all the vertices using findall, removes the duplicates using removeDuplicates to get an accurate list of vertices, then calls colorGraph.

findall/3:
  The build in function which returns a list containing all possible results from calling a defined fact/rule. 

loop/1:
  Loops through a list.

createEdges/1:
  Uses assertz to create facts from data in the List.

createColors/1:
  Loops through the list of colors and uses assertz to create facts.

colorGraph/4:
  Recursive function which loops through the list of vertices. It calls upon other predicates to color a vertex, append the colored vertex to solution, remove the colored vertex from list of vertices, then finally does a recursive call.

colorVertex/3:
  Utilizes findall to get all of FirstEle's Neighbours, calls checkNeighbours to check if any Neighbours have been assigned Color, then returns a valid vector-color.

checkNeighbours/4:
  Loops through the list of neighbours, checking to see if the given color is valid against all neighbours.

isColorValid/5:
  Check if a neighbouring vertex has already been colored. It uses member to check the Solution list, and if a neighbouring vertex has already been colored, return a new color, and return all neighbours as T to ensure it loops though all the vertices again. Ensuring the color is valid against all neighbours.

firstEle/2:
  Returns the first element of a list.

lastEle/2: 
  Returns the last element of a list.

trimList/2:
  Remove the first element of a list and return the rest.

member/2:
  Returns true is X is a member of a list.

append/3:
  Appends two lists together, returning a new list containing the two.

length/2:
  Counts the length of a given list, returning the number of elements.

removeDuplicates/2:
  Removes duplicate elements from a list using member/2 to look for dups and a cut to prevent backtracking. Returns the modified list.
