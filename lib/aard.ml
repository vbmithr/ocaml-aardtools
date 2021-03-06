type metadata = {
  article_count: int;
  article_count_is_volume_total: bool;
  index_language: string;
  article_language: string;
  title: string;
  version: string;
  description: string;
  copyright: string;
  license: string;
  source: string;
} [@@deriving Yojson]

exception Not_an_aard_file
exception Corrupted_header_field of string

let compress_to_buffer str buffer =
  let strlen = String.length str in
  let pos = ref 0 in
  Buffer.clear buffer;
  Zlib.compress
    (fun buf ->
       let len = String.length buf in
       let minlen = min len (strlen - !pos) in
       String.blit str !pos buf 0 minlen;
       pos := !pos + minlen;
       minlen
    )
    (fun buf len -> Buffer.add_substring buffer buf 0 len)

let sha1sum ic =
  let open Cryptokit in
  let hash = Hash.sha1 () in
  let buf = Bytes.create 4096 in
  really_input ic buf 0 44;
  if String.sub buf 0 4 <> "aard" then raise Not_an_aard_file;
  let old_chksum = String.sub buf 4 40 in
  try
    while true do
      let nb_read = input ic buf 0 4096 in
      if nb_read > 0
      then hash#add_substring buf 0 nb_read
      else raise End_of_file
    done; "",""
  with End_of_file -> old_chksum, (hash#result |> transform_string (Hexa.encode ()))

let vrfy_sha1sum filename =
  let ic = open_in_bin filename in
  try
    let old, new_ = sha1sum ic in
    close_in ic; old = new_
  with exn -> close_in ic; raise exn

let item_fmt_of_string str =
  let endianness = match str.[0] with
    | '>' -> `BigEndian
    | '<' -> `LittleEndian
    | _   -> `Native in
  let key_addr = match str.[1] with
    | 'L' -> 4
    | 'H' -> 2
    | _   -> 4 in
  let ar_addr = match str.[2] with
    | 'L' -> 4
    | 'H' -> 2
    | _   -> 4 in
  endianness, key_addr, ar_addr

let len_fmt_of_string str =
  let endianness = match str.[0] with
    | '>' -> `BigEndian
    | '<' -> `LittleEndian
    | _   -> `Native in
  let key_len = match str.[1] with
    | 'L' -> 4
    | 'H' -> 2
    | _   -> 4 in
  endianness, key_len

let output_header oc hdr =
  let open Aard_header in
  let open Printf in
  fprintf oc "signature:\t%s\n" (get_aard_header_signature hdr |> Cstruct.to_string);
  fprintf oc "sha1sum:\t%s\n" (get_aard_header_sha1sum hdr |> Cstruct.to_string);
  fprintf oc "version:\t%d\n" (get_aard_header_version hdr);
  fprintf oc "uuid:\t\t%s\n"
    (get_aard_header_uuid hdr |> Cstruct.to_string |> Uuidm.of_bytes
     |> function
     | None -> raise (Corrupted_header_field "uuid")
     | Some uuid -> Uuidm.to_string uuid
    );
  fprintf oc "volume:\t\t%d of %d\n" (get_aard_header_volume hdr) (get_aard_header_of_ hdr);
  fprintf oc "meta_length:\t%ld\n" (get_aard_header_meta_length hdr);
  fprintf oc "index_count:\t%ld\n" (get_aard_header_index_count hdr);
  fprintf oc "a_offset:\t%ld\n" (get_aard_header_article_offset hdr);
  fprintf oc "i_item_fmt:\t%s\n" (get_aard_header_index1_item_format hdr |> Cstruct.to_string);
  fprintf oc "k_len_fmt:\t%s\n" (get_aard_header_key_length_format hdr |> Cstruct.to_string);
  fprintf oc "a_len_fmt:\t%s\n" (get_aard_header_article_length_format hdr |> Cstruct.to_string)
