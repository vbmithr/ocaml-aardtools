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
}

val metadata_of_yojson : Yojson.Safe.json -> [ `Ok of metadata | `Error of string ]
val metadata_to_yojson : metadata -> Yojson.Safe.json

exception Not_an_aard_file
exception Corrupted_header_field of string

val sha1sum : in_channel -> string * string
val vrfy_sha1sum : string -> bool
val compress_to_buffer : string -> Buffer.t -> unit
val output_header : out_channel -> Cstruct.t -> unit

