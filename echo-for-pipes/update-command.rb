q6_path  = ARGV[0] || ""
filename = ARGV[1] || "output"

file = File.new(filename, "r")


q6_path_hex     = q6_path.each_byte.map {|b| "\\\\x#{b.to_s(16)}" }.join
q6_path_len_hex = q6_path.length.to_i.to_s.each_byte.map {|b| "\\\\x#{b.to_s(16)}" }.join
data_hex        = file.each_byte.map {|b| "\\\\x#{b.to_s(16)}" }.join
data_len_hex    = "192".each_byte.map {|b| "\\\\x#{b.to_s(16)}" }.join

command_length     = 3 + q6_path.length + 3 + "f0VMRgEBAUhpIFdvcmxkCgI=".length
command_length_hex = command_length.to_s(16)

puts "echo -n -e \\\\x#{command_length_hex} > Inet-w-com-r\n"
puts "echo -n -e \\\\x32#{q6_path_len_hex}#{q6_path_hex}#{data_len_hex}#{data_hex} > Dnet-w-com-r\n"
puts "echo -n -e \\\\xFF > Inet-w-com-r\n"


