let st ?(attrs=[]) name = ("", name), List.map (fun (n,s) -> ("",n),s) attrs

let ar lang1 lang2 = [`El_start (st "ar");
                      `El_start (st "head");
                      `El_start (st "k"); `Data lang1; `El_end;
                      `El_end;
                      `El_start (st "def"); `Data lang2; `El_end;
                      `El_end]

let convert_str charset_from cstr =
  let str = String.(sub cstr 0 (index cstr '\000')) in
  Encoding.recode_string ~src:charset_from ~dst:"UTF-8" str

let encode ic oc lang_from lang_to charset_from charset_to name descr=
  let open Xmlm in
  let out = make_output ~indent:None (`Channel oc) in
  let lang1 = String.create 31 in
  let lang2 = String.create 53 in
  output out (`Dtd None);
  output out (`El_start (st ~attrs:["lang_from", lang_from;
                                    "lang_to", lang_to;
                                    "format", "visual";
                                    "revision", "032beta"
                                   ] "xdxf"));
  output out (`El_start (st "full_title"));
  output out (`Data name);
  output out `El_end;
  output out (`El_start (st "description"));
  output out (`Data descr);
  output out `El_end;

  try
    while true do
      really_input ic lang1 0 31;
      really_input ic lang2 0 53;

      List.iter (output out) (ar (convert_str charset_from lang1)
                                (convert_str charset_to lang2));
    done
  with End_of_file -> output out `El_end

let () =
  let open Arg in
  let name = ref "" in
  let descr = ref "" in
  let lang_from = ref "" in
  let lang_to = ref "" in
  let charset_from = ref "" in
  let charset_to = ref "" in
  let in_files = ref [] in
  let output_file = ref "" in
  let speclist = align [
      "--name", Set_string name, "<string> Name of dict.";
      "--descr", Set_string descr, "<string> Descr of dict.";
      "--lang-from", Set_string lang_from, "<string> Lang from.";
      "--lang-to", Set_string lang_to, "<string> Lang to.";
      "--charset-from", Set_string charset_from, "<string> Charset from.";
      "--charset-to", Set_string charset_to, "<string> Charset to.";
      "-o", Set_string output_file, "<string> Output file."
    ] in
  let usage_msg = "Usage: " ^ Sys.argv.(0) ^ " [options] files...\nOptions are:" in
  let anon_fun s = in_files := s::!in_files in
  parse speclist anon_fun usage_msg;
  let oc = if !output_file = "" then stdout else open_out !output_file in
  List.iter
    (fun f ->
       let ic = open_in f in
       try
         encode ic oc !lang_from !lang_to !charset_from !charset_to !name !descr; close_in ic
       with exn -> close_in ic; raise exn
    )
  !in_files;
  close_out oc

