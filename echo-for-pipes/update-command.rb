q6_path  = ARGV[0] || "/home/apps/new/a"
filename = ARGV[1] || "output"

file = File.new(filename, "r")

q6_path_length_bytes = q6_path.length.to_s.each_byte.map do |b|
    b.to_s(16)
end

(3 - q6_path_length_bytes.length).times {|i| q6_path_length_bytes.unshift("30")}

q6_path_bytes = q6_path.each_byte.map {|b| b.to_s(16)} 


FRAME_LENGTH = 190
data_length = FRAME_LENGTH - q6_path_length_bytes.length - q6_path_bytes.length

data_bytes    = file.each_byte.map {|b| b.to_s(16) }
loop_times  = (data_bytes.length / data_length.to_f).ceil

q6_path_hex = "#{q6_path_length_bytes.map{|s| "\\\\x#{s}"}.join}" + "#{q6_path_bytes.map{|s| "\\\\x#{s}"}.join}"


loop_times.times do |i|       
    start  = i * data_length
    finish = i + 1 * data_length
    if finish > data_bytes.length
        finish = data_bytes.length 
    end

    data_bytes_hex = data_bytes[start..finish].map{|s| "\\\\x#{s}"}.join

    puts "echo -n -e \\\\x32#{q6_path_hex}#{data_bytes_hex} > Dnet-w-com-r\n"
    puts "echo -n -e \\\\x21 > Dnet-w-com-r\n"
end
