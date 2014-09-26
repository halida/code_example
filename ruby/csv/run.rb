require 'csv'

`mkdir -p tmp`
filename = "tmp/file.csv"

# write
CSV.open(filename, "wb+") do |csv|
  csv << ["row", "of", "CSV", "data"]
  csv << ["another", "row"]
end


CSV.foreach(filename) do |row|
  puts row.to_s
end
