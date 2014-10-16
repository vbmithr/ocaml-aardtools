cstruct aard_header {
  uint8_t signature[4];
  uint8_t sha1sum[40];
  uint16_t version;
  uint8_t uuid[16];
  uint16_t volume;
  uint16_t of_;
  uint32_t meta_length;
  uint32_t index_count;
  uint32_t article_offset;
  uint8_t index1_item_format[4];
  uint8_t key_length_format[2];
  uint8_t article_length_format[2];
} as big_endian
