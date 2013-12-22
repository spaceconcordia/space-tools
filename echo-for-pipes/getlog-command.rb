subsystem  = ARGV[0] || 0
bytes      = ARGV[1] || 100

bytes_bytes = bytes.to_s.each_byte.map do |b|
    b.to_s(16)
end

(3 - bytes_bytes.length).times {|i| bytes_bytes.unshift("30")}


bytes_bytes_hex = "#{bytes_bytes.map{|s| "\\\\x#{s}"}.join}"
total = 1 + 1 + bytes_bytes.length
subsystem = subsystem.to_i + 30 #to hex

puts "echo -n -e \\\\x#{total} > Inet-w-com-r\n"
puts "echo -n -e \\\\x33\\\\x#{subsystem}#{bytes_bytes_hex} > Dnet-w-com-r\n"
puts "echo -n -e \\\\xFF > Inet-w-com-r\n"
