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

let write_metadata = (
  fun ob x ->
    Bi_outbuf.add_char ob '{';
    let is_first = ref true in
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"article_count\":";
    (
      Yojson.Safe.write_int
    )
      ob x.article_count;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"article_count_is_volume_total\":";
    (
      Yojson.Safe.write_bool
    )
      ob x.article_count_is_volume_total;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"index_language\":";
    (
      Yojson.Safe.write_string
    )
      ob x.index_language;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"article_language\":";
    (
      Yojson.Safe.write_string
    )
      ob x.article_language;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"title\":";
    (
      Yojson.Safe.write_string
    )
      ob x.title;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"version\":";
    (
      Yojson.Safe.write_string
    )
      ob x.version;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"description\":";
    (
      Yojson.Safe.write_string
    )
      ob x.description;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"copyright\":";
    (
      Yojson.Safe.write_string
    )
      ob x.copyright;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"license\":";
    (
      Yojson.Safe.write_string
    )
      ob x.license;
    if !is_first then
      is_first := false
    else
      Bi_outbuf.add_char ob ',';
    Bi_outbuf.add_string ob "\"source\":";
    (
      Yojson.Safe.write_string
    )
      ob x.source;
    Bi_outbuf.add_char ob '}';
)
let string_of_metadata ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_metadata ob x;
  Bi_outbuf.contents ob
let read_metadata = (
  fun p lb ->
    Yojson.Safe.read_space p lb;
    Yojson.Safe.read_lcurl p lb;
    let x =
      {
        article_count = Obj.magic 0.0;
        article_count_is_volume_total = Obj.magic 0.0;
        index_language = Obj.magic 0.0;
        article_language = Obj.magic 0.0;
        title = Obj.magic 0.0;
        version = Obj.magic 0.0;
        description = Obj.magic 0.0;
        copyright = Obj.magic 0.0;
        license = Obj.magic 0.0;
        source = Obj.magic 0.0;
      }
    in
    let bits0 = ref 0 in
    try
      Yojson.Safe.read_space p lb;
      Yojson.Safe.read_object_end lb;
      Yojson.Safe.read_space p lb;
      let f =
        fun s pos len ->
          if pos < 0 || len < 0 || pos + len > String.length s then
            invalid_arg "out-of-bounds substring position or length";
          match len with
            | 5 -> (
                if String.unsafe_get s pos = 't' && String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'l' && String.unsafe_get s (pos+4) = 'e' then (
                  4
                )
                else (
                  -1
                )
              )
            | 6 -> (
                if String.unsafe_get s pos = 's' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'u' && String.unsafe_get s (pos+3) = 'r' && String.unsafe_get s (pos+4) = 'c' && String.unsafe_get s (pos+5) = 'e' then (
                  9
                )
                else (
                  -1
                )
              )
            | 7 -> (
                match String.unsafe_get s pos with
                  | 'l' -> (
                      if String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 'c' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'n' && String.unsafe_get s (pos+5) = 's' && String.unsafe_get s (pos+6) = 'e' then (
                        8
                      )
                      else (
                        -1
                      )
                    )
                  | 'v' -> (
                      if String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'r' && String.unsafe_get s (pos+3) = 's' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'o' && String.unsafe_get s (pos+6) = 'n' then (
                        5
                      )
                      else (
                        -1
                      )
                    )
                  | _ -> (
                      -1
                    )
              )
            | 9 -> (
                if String.unsafe_get s pos = 'c' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'p' && String.unsafe_get s (pos+3) = 'y' && String.unsafe_get s (pos+4) = 'r' && String.unsafe_get s (pos+5) = 'i' && String.unsafe_get s (pos+6) = 'g' && String.unsafe_get s (pos+7) = 'h' && String.unsafe_get s (pos+8) = 't' then (
                  7
                )
                else (
                  -1
                )
              )
            | 11 -> (
                if String.unsafe_get s pos = 'd' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 'c' && String.unsafe_get s (pos+4) = 'r' && String.unsafe_get s (pos+5) = 'i' && String.unsafe_get s (pos+6) = 'p' && String.unsafe_get s (pos+7) = 't' && String.unsafe_get s (pos+8) = 'i' && String.unsafe_get s (pos+9) = 'o' && String.unsafe_get s (pos+10) = 'n' then (
                  6
                )
                else (
                  -1
                )
              )
            | 13 -> (
                if String.unsafe_get s pos = 'a' && String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'c' && String.unsafe_get s (pos+5) = 'l' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = '_' && String.unsafe_get s (pos+8) = 'c' && String.unsafe_get s (pos+9) = 'o' && String.unsafe_get s (pos+10) = 'u' && String.unsafe_get s (pos+11) = 'n' && String.unsafe_get s (pos+12) = 't' then (
                  0
                )
                else (
                  -1
                )
              )
            | 14 -> (
                if String.unsafe_get s pos = 'i' && String.unsafe_get s (pos+1) = 'n' && String.unsafe_get s (pos+2) = 'd' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'x' && String.unsafe_get s (pos+5) = '_' && String.unsafe_get s (pos+6) = 'l' && String.unsafe_get s (pos+7) = 'a' && String.unsafe_get s (pos+8) = 'n' && String.unsafe_get s (pos+9) = 'g' && String.unsafe_get s (pos+10) = 'u' && String.unsafe_get s (pos+11) = 'a' && String.unsafe_get s (pos+12) = 'g' && String.unsafe_get s (pos+13) = 'e' then (
                  2
                )
                else (
                  -1
                )
              )
            | 16 -> (
                if String.unsafe_get s pos = 'a' && String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'c' && String.unsafe_get s (pos+5) = 'l' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = '_' && String.unsafe_get s (pos+8) = 'l' && String.unsafe_get s (pos+9) = 'a' && String.unsafe_get s (pos+10) = 'n' && String.unsafe_get s (pos+11) = 'g' && String.unsafe_get s (pos+12) = 'u' && String.unsafe_get s (pos+13) = 'a' && String.unsafe_get s (pos+14) = 'g' && String.unsafe_get s (pos+15) = 'e' then (
                  3
                )
                else (
                  -1
                )
              )
            | 29 -> (
                if String.unsafe_get s pos = 'a' && String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'c' && String.unsafe_get s (pos+5) = 'l' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = '_' && String.unsafe_get s (pos+8) = 'c' && String.unsafe_get s (pos+9) = 'o' && String.unsafe_get s (pos+10) = 'u' && String.unsafe_get s (pos+11) = 'n' && String.unsafe_get s (pos+12) = 't' && String.unsafe_get s (pos+13) = '_' && String.unsafe_get s (pos+14) = 'i' && String.unsafe_get s (pos+15) = 's' && String.unsafe_get s (pos+16) = '_' && String.unsafe_get s (pos+17) = 'v' && String.unsafe_get s (pos+18) = 'o' && String.unsafe_get s (pos+19) = 'l' && String.unsafe_get s (pos+20) = 'u' && String.unsafe_get s (pos+21) = 'm' && String.unsafe_get s (pos+22) = 'e' && String.unsafe_get s (pos+23) = '_' && String.unsafe_get s (pos+24) = 't' && String.unsafe_get s (pos+25) = 'o' && String.unsafe_get s (pos+26) = 't' && String.unsafe_get s (pos+27) = 'a' && String.unsafe_get s (pos+28) = 'l' then (
                  1
                )
                else (
                  -1
                )
              )
            | _ -> (
                -1
              )
      in
      let i = Yojson.Safe.map_ident p f lb in
      Ag_oj_run.read_until_field_value p lb;
      (
        match i with
          | 0 ->
            let v =
              (
                Ag_oj_run.read_int
              ) p lb
            in
            Obj.set_field (Obj.repr x) 0 (Obj.repr v);
            bits0 := !bits0 lor 0x1;
          | 1 ->
            let v =
              (
                Ag_oj_run.read_bool
              ) p lb
            in
            Obj.set_field (Obj.repr x) 1 (Obj.repr v);
            bits0 := !bits0 lor 0x2;
          | 2 ->
            let v =
              (
                Ag_oj_run.read_string
              ) p lb
            in
            Obj.set_field (Obj.repr x) 2 (Obj.repr v);
            bits0 := !bits0 lor 0x4;
          | 3 ->
            let v =
              (
                Ag_oj_run.read_string
              ) p lb
            in
            Obj.set_field (Obj.repr x) 3 (Obj.repr v);
            bits0 := !bits0 lor 0x8;
          | 4 ->
            let v =
              (
                Ag_oj_run.read_string
              ) p lb
            in
            Obj.set_field (Obj.repr x) 4 (Obj.repr v);
            bits0 := !bits0 lor 0x10;
          | 5 ->
            let v =
              (
                Ag_oj_run.read_string
              ) p lb
            in
            Obj.set_field (Obj.repr x) 5 (Obj.repr v);
            bits0 := !bits0 lor 0x20;
          | 6 ->
            let v =
              (
                Ag_oj_run.read_string
              ) p lb
            in
            Obj.set_field (Obj.repr x) 6 (Obj.repr v);
            bits0 := !bits0 lor 0x40;
          | 7 ->
            let v =
              (
                Ag_oj_run.read_string
              ) p lb
            in
            Obj.set_field (Obj.repr x) 7 (Obj.repr v);
            bits0 := !bits0 lor 0x80;
          | 8 ->
            let v =
              (
                Ag_oj_run.read_string
              ) p lb
            in
            Obj.set_field (Obj.repr x) 8 (Obj.repr v);
            bits0 := !bits0 lor 0x100;
          | 9 ->
            let v =
              (
                Ag_oj_run.read_string
              ) p lb
            in
            Obj.set_field (Obj.repr x) 9 (Obj.repr v);
            bits0 := !bits0 lor 0x200;
          | _ -> (
              Yojson.Safe.skip_json p lb
            )
      );
      while true do
        Yojson.Safe.read_space p lb;
        Yojson.Safe.read_object_sep p lb;
        Yojson.Safe.read_space p lb;
        let f =
          fun s pos len ->
            if pos < 0 || len < 0 || pos + len > String.length s then
              invalid_arg "out-of-bounds substring position or length";
            match len with
              | 5 -> (
                  if String.unsafe_get s pos = 't' && String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'l' && String.unsafe_get s (pos+4) = 'e' then (
                    4
                  )
                  else (
                    -1
                  )
                )
              | 6 -> (
                  if String.unsafe_get s pos = 's' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'u' && String.unsafe_get s (pos+3) = 'r' && String.unsafe_get s (pos+4) = 'c' && String.unsafe_get s (pos+5) = 'e' then (
                    9
                  )
                  else (
                    -1
                  )
                )
              | 7 -> (
                  match String.unsafe_get s pos with
                    | 'l' -> (
                        if String.unsafe_get s (pos+1) = 'i' && String.unsafe_get s (pos+2) = 'c' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'n' && String.unsafe_get s (pos+5) = 's' && String.unsafe_get s (pos+6) = 'e' then (
                          8
                        )
                        else (
                          -1
                        )
                      )
                    | 'v' -> (
                        if String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 'r' && String.unsafe_get s (pos+3) = 's' && String.unsafe_get s (pos+4) = 'i' && String.unsafe_get s (pos+5) = 'o' && String.unsafe_get s (pos+6) = 'n' then (
                          5
                        )
                        else (
                          -1
                        )
                      )
                    | _ -> (
                        -1
                      )
                )
              | 9 -> (
                  if String.unsafe_get s pos = 'c' && String.unsafe_get s (pos+1) = 'o' && String.unsafe_get s (pos+2) = 'p' && String.unsafe_get s (pos+3) = 'y' && String.unsafe_get s (pos+4) = 'r' && String.unsafe_get s (pos+5) = 'i' && String.unsafe_get s (pos+6) = 'g' && String.unsafe_get s (pos+7) = 'h' && String.unsafe_get s (pos+8) = 't' then (
                    7
                  )
                  else (
                    -1
                  )
                )
              | 11 -> (
                  if String.unsafe_get s pos = 'd' && String.unsafe_get s (pos+1) = 'e' && String.unsafe_get s (pos+2) = 's' && String.unsafe_get s (pos+3) = 'c' && String.unsafe_get s (pos+4) = 'r' && String.unsafe_get s (pos+5) = 'i' && String.unsafe_get s (pos+6) = 'p' && String.unsafe_get s (pos+7) = 't' && String.unsafe_get s (pos+8) = 'i' && String.unsafe_get s (pos+9) = 'o' && String.unsafe_get s (pos+10) = 'n' then (
                    6
                  )
                  else (
                    -1
                  )
                )
              | 13 -> (
                  if String.unsafe_get s pos = 'a' && String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'c' && String.unsafe_get s (pos+5) = 'l' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = '_' && String.unsafe_get s (pos+8) = 'c' && String.unsafe_get s (pos+9) = 'o' && String.unsafe_get s (pos+10) = 'u' && String.unsafe_get s (pos+11) = 'n' && String.unsafe_get s (pos+12) = 't' then (
                    0
                  )
                  else (
                    -1
                  )
                )
              | 14 -> (
                  if String.unsafe_get s pos = 'i' && String.unsafe_get s (pos+1) = 'n' && String.unsafe_get s (pos+2) = 'd' && String.unsafe_get s (pos+3) = 'e' && String.unsafe_get s (pos+4) = 'x' && String.unsafe_get s (pos+5) = '_' && String.unsafe_get s (pos+6) = 'l' && String.unsafe_get s (pos+7) = 'a' && String.unsafe_get s (pos+8) = 'n' && String.unsafe_get s (pos+9) = 'g' && String.unsafe_get s (pos+10) = 'u' && String.unsafe_get s (pos+11) = 'a' && String.unsafe_get s (pos+12) = 'g' && String.unsafe_get s (pos+13) = 'e' then (
                    2
                  )
                  else (
                    -1
                  )
                )
              | 16 -> (
                  if String.unsafe_get s pos = 'a' && String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'c' && String.unsafe_get s (pos+5) = 'l' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = '_' && String.unsafe_get s (pos+8) = 'l' && String.unsafe_get s (pos+9) = 'a' && String.unsafe_get s (pos+10) = 'n' && String.unsafe_get s (pos+11) = 'g' && String.unsafe_get s (pos+12) = 'u' && String.unsafe_get s (pos+13) = 'a' && String.unsafe_get s (pos+14) = 'g' && String.unsafe_get s (pos+15) = 'e' then (
                    3
                  )
                  else (
                    -1
                  )
                )
              | 29 -> (
                  if String.unsafe_get s pos = 'a' && String.unsafe_get s (pos+1) = 'r' && String.unsafe_get s (pos+2) = 't' && String.unsafe_get s (pos+3) = 'i' && String.unsafe_get s (pos+4) = 'c' && String.unsafe_get s (pos+5) = 'l' && String.unsafe_get s (pos+6) = 'e' && String.unsafe_get s (pos+7) = '_' && String.unsafe_get s (pos+8) = 'c' && String.unsafe_get s (pos+9) = 'o' && String.unsafe_get s (pos+10) = 'u' && String.unsafe_get s (pos+11) = 'n' && String.unsafe_get s (pos+12) = 't' && String.unsafe_get s (pos+13) = '_' && String.unsafe_get s (pos+14) = 'i' && String.unsafe_get s (pos+15) = 's' && String.unsafe_get s (pos+16) = '_' && String.unsafe_get s (pos+17) = 'v' && String.unsafe_get s (pos+18) = 'o' && String.unsafe_get s (pos+19) = 'l' && String.unsafe_get s (pos+20) = 'u' && String.unsafe_get s (pos+21) = 'm' && String.unsafe_get s (pos+22) = 'e' && String.unsafe_get s (pos+23) = '_' && String.unsafe_get s (pos+24) = 't' && String.unsafe_get s (pos+25) = 'o' && String.unsafe_get s (pos+26) = 't' && String.unsafe_get s (pos+27) = 'a' && String.unsafe_get s (pos+28) = 'l' then (
                    1
                  )
                  else (
                    -1
                  )
                )
              | _ -> (
                  -1
                )
        in
        let i = Yojson.Safe.map_ident p f lb in
        Ag_oj_run.read_until_field_value p lb;
        (
          match i with
            | 0 ->
              let v =
                (
                  Ag_oj_run.read_int
                ) p lb
              in
              Obj.set_field (Obj.repr x) 0 (Obj.repr v);
              bits0 := !bits0 lor 0x1;
            | 1 ->
              let v =
                (
                  Ag_oj_run.read_bool
                ) p lb
              in
              Obj.set_field (Obj.repr x) 1 (Obj.repr v);
              bits0 := !bits0 lor 0x2;
            | 2 ->
              let v =
                (
                  Ag_oj_run.read_string
                ) p lb
              in
              Obj.set_field (Obj.repr x) 2 (Obj.repr v);
              bits0 := !bits0 lor 0x4;
            | 3 ->
              let v =
                (
                  Ag_oj_run.read_string
                ) p lb
              in
              Obj.set_field (Obj.repr x) 3 (Obj.repr v);
              bits0 := !bits0 lor 0x8;
            | 4 ->
              let v =
                (
                  Ag_oj_run.read_string
                ) p lb
              in
              Obj.set_field (Obj.repr x) 4 (Obj.repr v);
              bits0 := !bits0 lor 0x10;
            | 5 ->
              let v =
                (
                  Ag_oj_run.read_string
                ) p lb
              in
              Obj.set_field (Obj.repr x) 5 (Obj.repr v);
              bits0 := !bits0 lor 0x20;
            | 6 ->
              let v =
                (
                  Ag_oj_run.read_string
                ) p lb
              in
              Obj.set_field (Obj.repr x) 6 (Obj.repr v);
              bits0 := !bits0 lor 0x40;
            | 7 ->
              let v =
                (
                  Ag_oj_run.read_string
                ) p lb
              in
              Obj.set_field (Obj.repr x) 7 (Obj.repr v);
              bits0 := !bits0 lor 0x80;
            | 8 ->
              let v =
                (
                  Ag_oj_run.read_string
                ) p lb
              in
              Obj.set_field (Obj.repr x) 8 (Obj.repr v);
              bits0 := !bits0 lor 0x100;
            | 9 ->
              let v =
                (
                  Ag_oj_run.read_string
                ) p lb
              in
              Obj.set_field (Obj.repr x) 9 (Obj.repr v);
              bits0 := !bits0 lor 0x200;
            | _ -> (
                Yojson.Safe.skip_json p lb
              )
        );
      done;
      assert false;
    with Yojson.End_of_object -> (
        if !bits0 <> 0x3ff then Ag_oj_run.missing_fields [| !bits0 |] [| "article_count"; "article_count_is_volume_total"; "index_language"; "article_language"; "title"; "version"; "description"; "copyright"; "license"; "source" |];
        Ag_oj_run.identity x
      )
)
let metadata_of_string s =
  read_metadata (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write__1 = (
  Ag_oj_run.write_list (
    fun ob x ->
      Bi_outbuf.add_char ob '(';
      (let x, _ = x in
      (
        Yojson.Safe.write_string
      ) ob x
      );
      Bi_outbuf.add_char ob ',';
      (let _, x = x in
      (
        Yojson.Safe.write_string
      ) ob x
      );
      Bi_outbuf.add_char ob ')';
  )
)
let string_of__1 ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write__1 ob x;
  Bi_outbuf.contents ob
let read__1 = (
  Ag_oj_run.read_list (
    fun p lb ->
      Yojson.Safe.read_space p lb;
      let std_tuple = Yojson.Safe.start_any_tuple p lb in
      let len = ref 0 in
      let end_of_tuple = ref false in
      (try
        let x0 =
          let x =
            (
              Ag_oj_run.read_string
            ) p lb
          in
          incr len;
          Yojson.Safe.read_space p lb;
          Yojson.Safe.read_tuple_sep2 p std_tuple lb;
          x
        in
        let x1 =
          let x =
            (
              Ag_oj_run.read_string
            ) p lb
          in
          incr len;
          (try
            Yojson.Safe.read_space p lb;
            Yojson.Safe.read_tuple_sep2 p std_tuple lb;
          with Yojson.End_of_tuple -> end_of_tuple := true);
          x
        in
        if not !end_of_tuple then (
          try
            while true do
              Yojson.Safe.skip_json p lb;
              Yojson.Safe.read_tuple_sep2 p std_tuple lb;
            done
          with Yojson.End_of_tuple -> ()
        );
        (x0, x1)
      with Yojson.End_of_tuple ->
        Ag_oj_run.missing_tuple_fields !len [ 0; 1 ]);
  )
)
let _1_of_string s =
  read__1 (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
let write_wb = (
  write__1
)
let string_of_wb ?(len = 1024) x =
  let ob = Bi_outbuf.create len in
  write_wb ob x;
  Bi_outbuf.contents ob
let read_wb = (
  read__1
)
let wb_of_string s =
  read_wb (Yojson.Safe.init_lexer ()) (Lexing.from_string s)
