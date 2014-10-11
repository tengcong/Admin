require 'mongoid'

Mongoid.load!("config/mongoid.yml", 'development')

Dir["./models/*.rb"].each { |f| require f }

Dir['seeds/*.txt'].each do |file_name|

  line_num=0
  text=File.open(file_name).read
  text.gsub!(/\r\n?/, "\n")
  text.each_line do |line|
    line_num += 1

    line.chomp!

    Photo.find_or_create_by(url: line, type: 1)
  end

  puts "#{file_name} -- #{line_num}"

end

