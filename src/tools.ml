open Graph

(* Returns a new graph having the same nodes than gr, but no arc. *)
let clone_nodes gr =
  n_fold gr (fun acu id -> new_node acu id) empty_graph

(* Reverses the order of the arcs of gr. Used in gmap to preserve the order of the arcs of gr. *)
let rev_arcs gr =
  e_fold gr (fun acu arc -> new_arc acu arc) (clone_nodes gr)

(* Maps all arcs of gr by function f. *)
let gmap gr f =
  rev_arcs (e_fold gr (fun acu arc -> new_arc acu { arc with lbl = f arc.lbl }) (clone_nodes gr))

(* Adds n to the value of the arc between id1 and id2. If the arc does not exist, it is created. *)
let add_arc gr id1 id2 n =
  let old_lbl =
    match find_arc gr id1 id2 with
      | None -> 0
      | Some arc -> arc.lbl
  in
    new_arc gr { src = id1; tgt = id2; lbl = old_lbl + n }

(* Conversions between string graphs and int graphs. *)
let to_int_graph gr = gmap gr int_of_string
let to_string_graph gr = gmap gr string_of_int
