require 'bundler'
Bundler.require 
require 'beefcake'
require 'json'
require 'yajl'
require 'protobuf'

class TestMessage
  include Beefcake::Message
  required :number, :int32,  1
  required :chars,  :string, 2
  required :raw,    :bytes,  3
  required :bool,   :bool,   4
  required :float,  :float,  5

  def as_json
    {
      :number => number,
      :chars => chars,
      :raw => raw,
      :bool => bool,
      :float => float
    }
  end
end

class TestProtoMessage < ::Protobuf::Message
  required :int32, :number,  1
  required :string, :chars, 2
  required :bytes, :raw,  3
  required :bool,   :bool,   4
  required :float,  :float,  5
end

obj = {
  :number => 123,
  :chars  => "sup sup",
  :raw    => 'sup',
  :bool   => true,
  :float  => 1.1234
}

encodes = {
  :beefcake => lambda { TestMessage.new(obj).encode.to_s },
  :protobuf => lambda { TestProtoMessage.new(obj).encode.to_s },
  :json     => lambda { JSON.dump(TestMessage.new(obj).as_json) },
  :yajl     => lambda { Yajl.dump(TestMessage.new(obj).as_json) },
  :msgpack  => lambda { MessagePack.pack(TestMessage.new(obj).as_json) }
}

encoded = {}
encodes.each {|n, e| encoded[n] = e.call }

puts "===================="
puts "Sizes"
puts
encoded.each {|n, e| puts "#{n}: #{e.bytesize}b" }
puts "===================="

decodes = { 
  :beefcake => lambda { TestMessage.decode(encoded[:beefcake]) },
  :protobuf => lambda { TestProtoMessage.decode(encoded[:protobuf]) },
  :json     => lambda { TestMessage.new(JSON.load(encoded[:json])) },
  :yajl     => lambda { TestMessage.new(Yajl.load(encoded[:yajl])) },
  :msgpack  => lambda { TestMessage.new(MessagePack.unpack(encoded[:msgpack])) }
}

Benchmark.ips do |x|
  encodes.each do |n, e|
    x.report("encode/#{n}", e)
  end
  x.compare!
end
Benchmark.ips do |x|
  decodes.each do |n, e|
    x.report("decode/#{n}", e)
  end
  x.compare!
end
