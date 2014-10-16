#!/usr/bin/env ocaml
#directory "pkg"
#use "topkg.ml"

let () =
  Pkg.describe "operf-macro" ~builder:`OCamlbuild [
    Pkg.lib "pkg/META";
    Pkg.lib ~exts:Exts.module_library "lib/aard";
    Pkg.bin ~auto:true "src/xdxf_of_wb";
    Pkg.bin ~auto:true "src/json_of_wb";
    Pkg.bin ~auto:true "src/aard_of_json";
    Pkg.bin ~auto:true "src/compile_aard";
    Pkg.bin ~auto:true "test/aard_test";
  ]
