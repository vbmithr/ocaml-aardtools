open Aard_j
open Aard_t
open Aard

let pipe_buf = String.create 4096

let pipe oc ic =
  try
    while true do
      let nb_read = input ic pipe_buf 0 4096 in
      if nb_read > 0
      then output oc pipe_buf 0 nb_read
      else raise End_of_file
    done
  with End_of_file -> ()

let hash_ic hash ic =
  try
    while true do
      let nb_read = input ic pipe_buf 0 4096 in
      if nb_read > 0 then hash#add_substring pipe_buf 0 nb_read
      else raise End_of_file
    done
  with End_of_file -> ()

let main aard_oc meta_ic idx1_ic idx2_ic ar_ic version volume of_ =
  let lexbuf = Lexing.from_channel meta_ic in
  let lexer_state = Yojson.init_lexer () in
  let meta = read_metadata lexer_state lexbuf in
  let idx_count = meta.article_count in
  let meta_string = string_of_metadata meta in
  let buf = Buffer.create 1024 in
  Util.compress_to_buffer meta_string buf;
  let meta_gzip = Buffer.contents buf in
  let meta_gzip_len = Buffer.length buf in
  let ar_offset =
    sizeof_aard_header + meta_gzip_len + in_channel_length idx1_ic + in_channel_length idx2_ic in

  (* Creating header cstruct and filling it *)
  let hdr = Cstruct.create sizeof_aard_header in
  set_aard_header_signature "aard" 0 hdr;
  set_aard_header_version hdr version;
  set_aard_header_uuid Uuidm.(v5 ns_url meta.source |> to_bytes) 0 hdr;
  set_aard_header_volume hdr volume;
  set_aard_header_of_ hdr of_;
  set_aard_header_meta_length hdr (meta_gzip_len |> Int32.of_int);
  set_aard_header_index_count hdr (idx_count |> Int32.of_int);
  set_aard_header_article_offset hdr (ar_offset |> Int32.of_int);
  set_aard_header_index1_item_format ">LL\000" 0 hdr;
  set_aard_header_key_length_format ">H" 0 hdr;
  set_aard_header_article_length_format ">L" 0 hdr;
  let hdr_string = Cstruct.to_string hdr in

  (* Writing the final .aar file *)
  output aard_oc hdr_string 0 sizeof_aard_header;
  output aard_oc meta_gzip 0 meta_gzip_len;
  pipe aard_oc idx1_ic;
  pipe aard_oc idx2_ic;
  pipe aard_oc ar_ic;

  (* Computing checksum *)
  seek_in idx1_ic 0;
  seek_in idx2_ic 0;
  seek_in ar_ic 0;
  let open Cryptokit in
  let hash = Hash.sha1 () in
  hash#add_substring hdr_string 44 (sizeof_aard_header - 44);
  hash#add_string meta_gzip;
  hash_ic hash idx1_ic;
  hash_ic hash idx2_ic;
  hash_ic hash ar_ic;

  (* Writing the checksum *)
  seek_out aard_oc 4;
  output aard_oc (hash#result |> transform_string (Hexa.encode ())) 0 40

let () =
  let open Arg in
  let basename = ref "" in
  let version = ref 1 in
  let volume = ref 1 in
  let of_ = ref 1 in
  let speclist = align [
      "--version", Set_int version, "<int> Version of the .aar file (default 1).";
      "--volume", Set_int volume, "<int> Volume number of the dictionary to be created (default 1).";
      "--of", Set_int of_, "<int> Number of volumes of the dictionary to be created (default 1).";
    ] in
  let usage_msg = "Usage: " ^ Sys.argv.(0) ^ " [options] basename\nOptions are:" in
  let anon_fun s = basename := s in
  parse speclist anon_fun usage_msg;
  let aard_oc = open_out_bin (!basename ^ ".aar") in
  let meta_ic = open_in (!basename ^ ".meta") in
  let idx1_ic = open_in_bin (!basename ^ ".idx1") in
  let idx2_ic = open_in_bin (!basename ^ ".idx2") in
  let ar_ic = open_in_bin (!basename ^ ".ar") in
  main aard_oc meta_ic idx1_ic idx2_ic ar_ic !version !volume !of_

