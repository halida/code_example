require 'dbus'

class Test < DBus::Object
  # Create an interface.
  dbus_interface "org.ruby.SampleInterface" do
    # Create a hello method in that interface.
    dbus_method :hello, "in name:s, in name2:s" do |name, name2|
      puts "hello(#{name}, #{name2})"
    end
  end
end


def server
  bus = DBus.system_bus
  service = bus.request_service("org.ruby.service")

  exported_obj = Test.new("/org/ruby/MyInstance")
  service.export(exported_obj)

  loop = DBus::Main.new
  loop << bus
  loop.run
end

def client
  bus = DBus.system_bus
  ruby_service = bus.service("org.ruby.service")
  obj = ruby_service.object("/org/ruby/MyInstance")
  obj.introspect
  obj.default_iface = "org.ruby.SampleInterface"
  obj.hello("giligiligiligili", "haaaaaaa")
end
