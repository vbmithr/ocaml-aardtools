let hdr = Bytes.create 16
let compressed_buf = Buffer.create 13

let compress_to_oc oc str hdr_size =
  Aard.compress_to_buffer str compressed_buf;
  let contents = Buffer.contents compressed_buf in
  let contents_len = Buffer.length compressed_buf in
  Buffer.clear compressed_buf;
  (match hdr_size with
  | 2 ->
    EndianString.BigEndian.set_int16 hdr 0 contents_len;
    output oc hdr 0 2
  | 4 ->
    EndianString.BigEndian.set_int32 hdr 0 (Int32.of_int contents_len);
    output oc hdr 0 4
  | 8 ->
    EndianString.BigEndian.set_int64 hdr 0 (Int64.of_int contents_len);
    output oc hdr 0 8
  | _ -> failwith "compressed_to_oc: Unsupported header size"
  );

  output oc contents 0 contents_len;
  hdr_size + contents_len

type lexlist = Jsonm.lexeme list [@@deriving Show]

exception Parse_error of string

let main json_ic idx1_oc idx2_oc ar_oc =
  let output_things (nb,p1,p2) k v =
    EndianString.BigEndian.set_int32 hdr 0 (Int32.of_int p1);
    EndianString.BigEndian.set_int32 hdr 4 (Int32.of_int p2);
    output idx1_oc hdr 0 8;
    let len1 = String.length k in
    EndianString.BigEndian.set_int16 hdr 0 len1;
    output idx2_oc hdr 0 2;
    output idx2_oc k 0 len1;
    let len2 = compress_to_oc ar_oc ("[\"" ^ v ^ "\",null]") 4 in
    (succ nb,p1+len1+2,p2+len2)
  in
  let dec = Jsonm.decoder (`Channel json_ic) in
  let rec read_all_tuples st acc =
    match Jsonm.decode dec with
    | `Await
    | `Error _ as e ->
        (try
           (match st with
            | [`As; `String s1; `String s2] ->
                e, output_things acc s1 s2
            | _ -> e, acc
           )
         with _ -> e, acc)
    | `Lexeme `Ae ->
        (match st with
         | [] ->
             read_all_tuples [] acc (* Last `Ae *)
         | [`String s2; `String s1; `As; _]
         | [`String s2; `String s1; `As] ->
             read_all_tuples [] @@ output_things acc s1 s2 (* Intermediate `Ae *)
         | lexlist ->
             `Parse_error (show_lexlist lexlist), acc)
    | `Lexeme l ->
        read_all_tuples (l::st) acc
    | `End ->
       `End, acc
  in
  let end_state, (nb, p1, p2) = read_all_tuples [] (0,0,0) in
  Printf.printf "Written %d definitions, sizeof idx2 = %d, sizeof ar = %d, " nb p1 p2;
  (match end_state with
  | `End -> Printf.printf "no errors.\n"
  | `Error e ->
      Jsonm.pp_error Format.std_formatter e
  | `Await -> assert false
  | `Parse_error err -> raise (Parse_error err)
  )

let () =
  let basename = Filename.chop_extension Sys.argv.(1) in
  let json_ic = open_in Sys.argv.(1) in
  let idx1_oc = open_out_bin (basename ^ ".idx1") in
  let idx2_oc = open_out_bin (basename ^ ".idx2") in
  let ar_oc = open_out_bin (basename ^ ".ar") in
  main json_ic idx1_oc idx2_oc ar_oc

