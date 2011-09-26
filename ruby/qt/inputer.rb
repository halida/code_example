require 'Qt4'

class Inputer < Qt::Dialog
  def initialize(parent = nil)
    super
    
    layout = Qt::VBoxLayout.new(self)
    @input = Qt::LineEdit.new
    @result = Qt::ListWidget.new

    layout.addWidget @input
    layout.addWidget @result
    
    Qt::Object.connect(@input, SIGNAL('returnPressed()'), 
                       self, SLOT('process()'))
  end

  slots 'process()'
  def process()
    text = @input.text
    if not text then return end
    
    @result.insertItem(0, text)
    @input.clear
  end
end

app = Qt::Application.new(ARGV)
Inputer.new().show()
app.exec()
