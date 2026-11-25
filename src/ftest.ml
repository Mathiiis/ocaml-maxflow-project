open Gfile

let () =

  (* Check the number of command-line arguments *)
  if Array.length Sys.argv <> 5 then
    begin
      Printf.printf
        "\n ✻  Usage: %s infile source sink outfile\n\n%s%!" Sys.argv.(0)
        ("    🟄  infile  : input file containing a graph\n" ^
         "    🟄  source  : identifier of the source vertex (used by the ford-fulkerson algorithm)\n" ^
         "    🟄  sink    : identifier of the sink vertex (ditto)\n" ^
         "    🟄  outfile : output file in which the result should be written.\n\n") ;
      exit 0
    end ;


  (* Arguments are : infile(1) source-id(2) sink-id(3) outfile(4) *)
  
  let infile = Sys.argv.(1)
  and outfile = Sys.argv.(4)
  
  (* These command-line arguments are not used for the moment. *)
  and _source = int_of_string Sys.argv.(2)
  and _sink = int_of_string Sys.argv.(3)
  in

  (* Open file *)
  let graph = from_file infile in

  (* Tests for module Tools *)

  let graph_int = Tools.to_int_graph graph in

  (* Test clone_nodes on graph1 *)
  let graph_clone = Tools.clone_nodes graph_int in

  (* Test gmap (increment each arc's label by one) on graph1 *)
  let graph_incr = Tools.gmap graph_int (fun x -> x + 1) in

  (* Test add_arc on graph1: increment the label of the already existing arc {1, 4} by one *)
  let graph_add_e = Tools.add_arc graph_int 1 4 1 in

  (* Test add_arc on graph1: add the non-existing arc {5, 1} with label's value 3 *)
  let graph_add_ne = Tools.add_arc graph_int 5 1 3 in

  (* Write the graphs that have been computed *)
  let () = write_file (outfile ^ "_clone") (Tools.to_string_graph graph_clone) in
  let () = write_file (outfile ^ "_incr") (Tools.to_string_graph graph_incr) in
  let () = write_file (outfile ^ "_add_e") (Tools.to_string_graph graph_add_e) in
  let () = write_file (outfile ^ "_add_ne") (Tools.to_string_graph graph_add_ne) in

  (* Rewrite the graph that has been read. *)
  let () = write_file outfile graph in

  let () = export (outfile ^ ".dot") graph in

  ()
