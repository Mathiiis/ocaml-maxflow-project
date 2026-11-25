Base project for Ocaml project on Ford-Fulkerson. This project contains some simple configuration files to facilitate editing Ocaml in VSCode.

To use, you should install the *OCaml Platform* extension in VSCode.
Then open VSCode in the root directory of this repository (command line: `code path/to/ocaml-maxflow-project`).

Features :
 - full compilation as VSCode build task (Ctrl+Shift+b)
 - highlights of compilation errors as you type
 - code completion
 - view of variable types


A [`Makefile`](Makefile) provides some useful commands:

 - `make build` to compile. This creates an `ftest.exe` executable
 - `make demo` to run the `ftest` program with some arguments
 - `make format` to indent the entire project
 - `make edit` to open the project in VSCode
 - `make clean` to remove build artifacts

In case of trouble with the VSCode extension (e.g. the project does not build, there are strange mistakes), a common workaround is to (1) close vscode, (2) `make clean`, (3) `make build` and (4) reopen vscode (`make edit`).

## Testing the `Tools` module

`ftest.ml` runs one test per function of `Tools` on `graphs/graph1.txt`.
`outfile` is the graph read from `graphs/graph1.txt` and rewritten unchanged. Its arcs are in reverse order compared to the input file (this comes from `from_file`, not from `Tools`). Each test writes its own file, to compare with `outfile`.
Run `make demo`, then compare each result with the reference:

```
make demo
diff outfile outfile_clone
diff outfile outfile_incr
diff outfile outfile_add_e
diff outfile outfile_add_ne
```

Expected differences:
 - `outfile_clone` (`clone_nodes`): all the arcs are missing.
 - `outfile_incr` (`gmap` with `(fun x -> x + 1)`): every arc's label is increased by 1.
 - `outfile_add_e` (`add_arc` on an **existing** arc): the arc {1, 4} goes from label 1 to label 2.
 - `outfile_add_ne` (`add_arc` on a **non-existing** arc): the new arc {5, 1} with label 3 appears.

Notes:
- `gmap` preserves the order of the arcs.
- `add_arc` moves the modified (or created) arc to the front of the arc list.
