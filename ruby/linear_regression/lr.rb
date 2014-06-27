require 'gnuplot'

def fake_data opt
  x = []
  x = (0..50).collect { |v| v.to_f }
  y = x.collect { |v| v*opt[:a] + opt[:b] + rand * opt[:rand]}
  [x, y]
end

def plot_dots x, y
  Gnuplot.open do |gp|
    Gnuplot::Plot.new( gp ) do |plot|
      plot.title  "Dots"
      plot.xlabel "x"
      plot.ylabel "y"

      plot.data << Gnuplot::DataSet.new( [x, y] ) do |ds|
        ds.with = "linespoints"
        ds.notitle
      end
    end
  end
end

def cost h, x, y
  1/2 * x.length * (h(x))
end

def main
  x, y = fake_data a: 3, b: 4, rand: 30
  plot_dots(x, y)
end

main
