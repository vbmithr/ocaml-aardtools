(* Auto-generated from "aard.atd" *)


type metadata = Aard_t.metadata = {
  article_count: int;
  article_count_is_volume_total: bool;
  index_language: string;
  article_language: string;
  title: string;
  version: string;
  description: string;
  copyright: string;
  license: string;
  source: string
}

type wb = Aard_t.wb

val write_metadata :
  Bi_outbuf.t -> metadata -> unit
  (** Output a JSON value of type {!metadata}. *)

val string_of_metadata :
  ?len:int -> metadata -> string
  (** Serialize a value of type {!metadata}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_metadata :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> metadata
  (** Input JSON data of type {!metadata}. *)

val metadata_of_string :
  string -> metadata
  (** Deserialize JSON data of type {!metadata}. *)

val write_wb :
  Bi_outbuf.t -> wb -> unit
  (** Output a JSON value of type {!wb}. *)

val string_of_wb :
  ?len:int -> wb -> string
  (** Serialize a value of type {!wb}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_wb :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> wb
  (** Input JSON data of type {!wb}. *)

val wb_of_string :
  string -> wb
  (** Deserialize JSON data of type {!wb}. *)

