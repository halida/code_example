require 'Qt4'

app = Qt::Application.new(ARGV)

hello = Qt::PushButton.new("fuck you")
hello.resize(100,30)
hello.show()

app.exec()
