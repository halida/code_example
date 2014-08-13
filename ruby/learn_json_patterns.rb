require 'json_patterns'

pattern = { users: array_of({ id: Integer, name: String }) }
validation = Validation.new_from_pattern(pattern)

hash = {'users' => [{'id' => 1}, {'name' => 12}]}
errors = validation.validate([], hash)
puts errors
