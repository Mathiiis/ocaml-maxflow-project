open Graph

(* A path is a list of nodes. *)
type path = id list

let rec find_path_helper graph forbidden arcs id1 id2 = 
  match arcs with
    | [] -> None
    | arc :: rest ->
      (* member of the forbidden list or label is less or equal to 0 *)
      if (List.mem arc.tgt forbidden) || (arc.lbl <= 0) then find_path_helper graph forbidden rest id1 id2
      else 
        match find_path graph (id1::forbidden) arc.tgt id2 with
        | Some p -> Some (id1::p)
        | None -> find_path_helper graph forbidden rest id1 id2

and find_path graph forbidden id1 id2 =
  if id1 = id2 then Some [id1]
  else find_path_helper graph forbidden (out_arcs graph id1) id1 id2