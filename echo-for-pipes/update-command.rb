q6_path  = ARGV[0] || "q6_pathaodaiodiasodiaso daos doaidoasid oasid oasid oiasod iasod asodi asoisd "
filename = ARGV[1] || "output"

file = File.new(filename, "r")


q6_path_hex     = q6_path.each_byte.map {|b| "\\\\x#{b.to_s(16)}" }.join
q6_path_len_hex = q6_path.length.to_i.to_s.each_byte.map {|b| "\\\\x#{b.to_s(16)}" }.join
data_hex        = file.each_byte.map {|b| "\\\\x#{b.to_s(16)}" }.join
data_len_hex    = data_hex.length.to_i.to_s.each_byte.map {|b| "\\\\x#{b.to_s(16)}" }.join

puts "echo -n -e \\\\x01 > Inet-w-com-r\n"
puts "echo -n -e #{q6_path_len_hex}#{q6_path_hex}#{data_len_hex}#{data_hex} > Dnet-w-com-r\n"
puts "echo -n -e \\\\xFF > Inet-w-com-r\n"


