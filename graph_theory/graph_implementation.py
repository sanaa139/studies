# Add a vertex to the dictionary
def add_vertex(graph, vertices_number, v):
    if v in graph:
        print("Vertex ", v, " already exists.")
    else:
        vertices_number = vertices_number + 1
        graph[v] = []

# Add an edge between vertex v1 and v2 with edge weight e
def add_edge(graph, v1, v2):
    # Check if vertex v1 is a valid vertex
    if v1 not in graph:
        print("Vertex ", v1, " does not exist.")
    # Check if vertex v2 is a valid vertex
    elif v2 not in graph:
        print("Vertex ", v2, " does not exist.")
    else:
        graph[v1].append(v2)
        graph[v2].append(v1)
        
def print_vertices(graph):
    print("Vertices:")
    for vertex in graph:
        print(vertex, end = ', ')
            
def print_edges(graph):
    print("\nEdges:")
    for vertex in graph:
        for edge in graph[vertex]:
            print(vertex, " <-> ", edge)

def print_neighbours(graph, vertex):
    print("Neighbours of", vertex, ":")
    print(graph[vertex])
    
def find_minimal_degree_vertex(graph):
    print("Minimum degree vertex:")
    min_degree = len(graph) - 1
    degree_of_a_vertex = 0
    for vertex in graph:
        for edges in graph[vertex]:
            degree_of_a_vertex = degree_of_a_vertex + 1
        if degree_of_a_vertex < min_degree:
            min_degree = degree_of_a_vertex
        degree_of_a_vertex = 0
    print(min_degree)
    
def find_maximal_degree_vertex(graph):
    print("Maximum degree vertex:")
    max_degree = 0
    degree_of_a_vertex = 0
    for vertex in graph:
        for edges in graph[vertex]:
            degree_of_a_vertex = degree_of_a_vertex + 1
        if degree_of_a_vertex > max_degree:
            max_degree = degree_of_a_vertex
        degree_of_a_vertex = 0
    print(max_degree)
            
def find_eccentricity(graph, vertex):
    print("Eccentricity of a vertex", vertex, ":")
    result = eccentricity(graph, vertex)
    print(result)         

def eccentricity(graph, vertex):
    eccentricity_no = 0
    visited = [vertex]
    active  = graph[vertex]
    while active != []:
        eccentricity_no = eccentricity_no + 1
        visited += active
        active = [y for x in active for y in graph[x] if y not in visited] 
    return eccentricity_no
    
def diameter(graph):
    print("diameter:")
    max = 0
    for vertex in graph:
        ecc = eccentricity(graph, vertex)
        if(ecc > max):
            max = ecc
    print(max)
    
def radius(graph):
    print("radius:")
    min = 100
    for vertex in graph:
        ecc = eccentricity(graph, vertex)
        if(ecc < min):
            min = ecc
    print(min) 

def main():
    graph = {}

    vertices_number = 0
    add_vertex(graph, vertices_number, 1)
    add_vertex(graph, vertices_number, 2)
    add_vertex(graph, vertices_number, 3)
    add_vertex(graph, vertices_number, 4)
    add_vertex(graph, vertices_number, 5)
    add_vertex(graph, vertices_number, 6)
    
    add_edge(graph, 1, 2)
    add_edge(graph, 1, 3)
    add_edge(graph, 2, 3)
    add_edge(graph, 4, 1)
    add_edge(graph, 4, 5)
    add_edge(graph, 5, 6)
    
    print(graph)
    print_vertices(graph)
    print_edges(graph)
    print_neighbours(graph, 1)
    find_minimal_degree_vertex(graph)
    find_maximal_degree_vertex(graph)
    find_eccentricity(graph, 6)
    diameter(graph)
    radius(graph)
    
if __name__ == "__main__":
    main()