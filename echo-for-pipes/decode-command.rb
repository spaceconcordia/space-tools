src_path  = ARGV[0] || ""
dest_path = ARGV[1] || ""

src_path_length_bytes = src_path.length.to_s.each_byte.map do |b|
    b.to_s(16)
end
p src_path_length_bytes.length
(3 - src_path_length_bytes.length).times {|i| src_path_length_bytes.unshift("30")}

p src_path_length_bytes.inspect
dest_path_length_bytes = dest_path.length.to_s.each_byte.map do |b|
    b.to_s(16)
end

(3 - dest_path_length_bytes.length).times {|i| dest_path_length_bytes.unshift("30")}

src_path_bytes  = src_path.each_byte.map {|b| b.to_s(16) }
dest_path_bytes = dest_path.each_byte.map {|b| b.to_s(16) }

total = src_path_length_bytes.length + src_path_bytes.length + dest_path_length_bytes.length + dest_path_bytes.length + 2
src_path_hex = "#{src_path_length_bytes.map{|s| "\\\\x#{s}"}.join}" + "#{src_path_bytes.map{|s| "\\\\x#{s}"}.join}"
dest_path_hex = "#{dest_path_length_bytes.map{|s| "\\\\x#{s}"}.join}" + "#{dest_path_bytes.map{|s| "\\\\x#{s}"}.join}"

puts "echo -n -e \\\\x#{total.to_s(16)} > Inet-w-com-r\n"
puts "echo -n -e \\\\x36\\\\x30#{src_path_hex}#{dest_path_hex} > Dnet-w-com-r\n"
puts "echo -n -e \\\\xFF > Inet-w-com-r\n"


