# format_benchmarks

This is a small Ruby script used to compare the encoding/decoding times
of protocol buffers to other encoding formats.

On my Macbook Pro with Ruby 2.2.2p95

```
$ bundle install
$ ruby format_benchmarks.rb
====================
Sizes

beefcake: 23b
protobuf: 23b
json: 71b
yajl: 71b
msgpack: 54b
====================
Calculating -------------------------------------
     encode/beefcake     3.437k i/100ms
     encode/protobuf     3.143k i/100ms
         encode/json     5.361k i/100ms
         encode/yajl     7.344k i/100ms
      encode/msgpack    11.913k i/100ms
-------------------------------------------------
     encode/beefcake     35.091k (± 5.5%) i/s -    175.287k
     encode/protobuf     31.084k (±17.1%) i/s -    150.864k
         encode/json     68.257k (±16.7%) i/s -    327.021k
         encode/yajl     78.168k (±16.8%) i/s -    381.888k
      encode/msgpack    128.113k (±20.2%) i/s -    595.650k

Comparison:
      encode/msgpack:   128113.3 i/s
         encode/yajl:    78168.2 i/s - 1.64x slower
         encode/json:    68256.7 i/s - 1.88x slower
     encode/beefcake:    35091.2 i/s - 3.65x slower
     encode/protobuf:    31083.5 i/s - 4.12x slower

Calculating -------------------------------------
     decode/beefcake     3.176k i/100ms
     decode/protobuf     4.294k i/100ms
         decode/json     7.740k i/100ms
         decode/yajl     9.053k i/100ms
      decode/msgpack    11.199k i/100ms
-------------------------------------------------
     decode/beefcake     33.960k (± 4.6%) i/s -    171.504k
     decode/protobuf     46.249k (± 4.6%) i/s -    231.876k
         decode/json     81.528k (±15.3%) i/s -    402.480k
         decode/yajl     96.640k (±10.6%) i/s -    479.809k
      decode/msgpack    127.809k (±12.1%) i/s -    638.343k

Comparison:
      decode/msgpack:   127809.4 i/s
         decode/yajl:    96639.5 i/s - 1.32x slower
         decode/json:    81527.5 i/s - 1.57x slower
     decode/protobuf:    46248.8 i/s - 2.76x slower
     decode/beefcake:    33960.1 i/s - 3.76x slower
```
