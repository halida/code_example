require 'csv'

`mkdir -p tmp`
filename = "tmp/file.csv"

# write
CSV.open(filename, "wb+") do |csv|
  csv << ["ID", "name", "value"]
  csv << [1, "halida", 120]
  csv << [2, "James", 300]
end

# read as table
c = CSV.new(File.open(filename), headers: :first_row)
# read first
row = c.readline
# read all
c.read

puts "ID: #{row['ID']}"
# return all fields
puts "first line: #{row.fields}"

# read all
CSV.foreach(filename) do |row|
  row.to_s
end

