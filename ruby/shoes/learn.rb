require 'shoes'

# def run
#   Shoes.app { button "Push me" }
# end

def a
  Shoes.app do
    @counter = para "STARTING"
    animate(24) do |frame|
      @counter.replace "FRAME #{frame}"
    end
  end
end  

a
