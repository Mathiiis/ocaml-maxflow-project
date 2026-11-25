open Graph

val clone_nodes: 'a graph -> 'b graph
val rev_arcs : 'a graph -> 'a graph
val gmap: 'a graph -> ('a -> 'b) -> 'b graph
val add_arc: int graph -> id -> id -> int -> int graph
val to_int_graph : string graph -> int graph
val to_string_graph : int graph -> string graph
