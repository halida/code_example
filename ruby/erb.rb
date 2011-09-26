require 'erb'

def render(str)
  template = ERB.new str
  puts template.result binding
end

# first test
render "
<% x = 2 %>
the value of x is : <%= x %>
"

