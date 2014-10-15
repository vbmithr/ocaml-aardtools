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

let main json_ic idx1_oc idx2_oc ar_oc =
  let lexbuf = Lexing.from_channel json_ic in
  let lexer_state = Yojson.init_lexer () in
  let dict = read_wb lexer_state lexbuf in
  List.fold_left
    (fun (nb,p1,p2) (k,v) ->
       EndianString.BigEndian.set_int32 hdr 0 (Int32.of_int p1);
       EndianString.BigEndian.set_int32 hdr 4 (Int32.of_int p2);
       output idx1_oc hdr 0 8;
       let len1 = String.length k in
       EndianString.BigEndian.set_int16 hdr 0 len1;
       output idx2_oc hdr 0 2;
       output idx2_oc k 0 len1;
       let len2 = compress_to_oc ar_oc ("[\"" ^ v ^ "\",null]") 4 in
       (succ nb,p1+len1+2,p2+len2)
    )
    (0,0,0) dict |> fun (nb,p1,p2) ->
  Printf.printf "Written %d definitions, sizeof idx2 = %d, sizeof ar = %d\n" nb p1 p2

let () =
  let basename = Filename.chop_extension Sys.argv.(1) in
  let json_ic = open_in Sys.argv.(1) in
  let idx1_oc = open_out_bin (basename ^ ".idx1") in
  let idx2_oc = open_out_bin (basename ^ ".idx2") in
  let ar_oc = open_out_bin (basename ^ ".ar") in
  main json_ic idx1_oc idx2_oc ar_oc

