open Printf

let convert_str charset_from cstr =
  let str = String.(sub cstr 0 (index cstr '\000')) in
  let open Re_pcre in
  let rex = regexp "([\"])" in
  let str = substitute ~rex ~subst:(function
      | "\"" -> "\\\""
      | _ -> assert false
    ) str in
  Encoding.recode_string ~src:charset_from ~dst:"UTF-8" str

let main ic oc k_chset v_chset =
  let k = String.create 31 in
  let v = String.create 53 in
  fprintf oc "[";
  try
    while true do
      really_input ic k 0 31;
      really_input ic v 0 53;
      fprintf oc "[\"%s\",\"%s\"],\n" (convert_str k_chset k) (convert_str v_chset v)
    done
  with
  | Not_found -> failwith "File is probably not a .wb file or it is corrupted."
  | End_of_file ->
    seek_out oc (pos_out oc - 2);
    fprintf oc "]"

let () =
  let open Arg in
  let in_files = ref [] in
  let k_chset = ref "" in
  let v_chset = ref "" in
  let output_file = ref "" in
    let speclist = align [
      "--key_charset", Set_string k_chset, "<string> Charset of keys.";
      "-k", Set_string k_chset, "<string> Charset of keys.";
      "--value_charset", Set_string v_chset, "<string> Charset of values.";
      "-v", Set_string v_chset, "<string> Charset of values.";
      "-o", Set_string output_file, "<string> Output file."
    ] in
  let usage_msg = "Usage: " ^ Sys.argv.(0) ^ " [options] file\nOptions are:" in
  let anon_fun s = in_files := s::!in_files in
  parse speclist anon_fun usage_msg;
  let oc = if !output_file = "" then stdout else open_out !output_file in
  let ic = open_in_bin (List.hd !in_files) in
  main ic oc !k_chset !v_chset


