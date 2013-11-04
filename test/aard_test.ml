open Aard

let () =
  if (vrfy_sha1sum Sys.argv.(1)) = false then failwith "Corrupted file.";
  let fd = Unix.(openfile Sys.argv.(1) [O_RDONLY] 0o666)  in
  let buf = Unix_cstruct.of_fd fd in
  let meta_len = get_aard_header_meta_length buf |> Int32.to_int in
  let meta_cstr = ref (Cstruct.sub buf sizeof_aard_header meta_len) in
  let meta_uncompressed = Buffer.create meta_len in
  Zlib.uncompress
    (fun buf ->
       let len = min (String.length buf) (Cstruct.len !meta_cstr) in
       Cstruct.blit_to_string !meta_cstr 0 buf 0 len;
       meta_cstr := Cstruct.shift !meta_cstr len;
       len
    )
    (fun buf len -> Buffer.add_substring meta_uncompressed buf 0 len);
  print_endline "Header:";
  output_header stdout buf;
  print_endline "Metadata:";
  print_endline (Buffer.contents meta_uncompressed)
