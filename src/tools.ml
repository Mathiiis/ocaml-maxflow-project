open Graph

let clone_nodes gr =
  n_fold gr (fun acu id -> new_node acu id) empty_graph

let gmap gr f =
  e_fold gr (fun acu arc -> new_arc acu { arc with lbl = f arc.lbl }) empty_graph

let add_arc gr id1 id2 n =
  let old_lbl =
    match find_arc gr id1 id2 with
      | None -> 0
      | Some arc -> arc.lbl
  in
    new_arc gr { src = id1; tgt = id2; lbl = old_lbl + n }
