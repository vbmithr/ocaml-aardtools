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
