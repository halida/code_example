require 'ffi'
require 'pry'

module Libc
  extend FFI::Library
  ffi_lib 'c'
  attach_function :puts, [ :string ], :int
end

module Mono
  # doc:
  # /Library/Frameworks/Mono.framework/Versions/4.6.2/include/mono-2.0/mono/jit/jit.h
  extend FFI::Library
  PATH = '/Library/Frameworks/Mono.framework/Versions/4.6.2/lib/'
  ffi_lib File.join(PATH, 'libmono-2.0.dylib')

  attach_function :mono_jit_init, [ :string ], :pointer
  attach_function :mono_jit_cleanup, [:pointer], :void

  attach_function :mono_domain_assembly_open, [:pointer, :string], :pointer
  attach_function :mono_assembly_get_image, [:pointer], :pointer
  attach_function :mono_jit_exec, [:pointer, :pointer, :int, :pointer], :int

  attach_function :mono_class_from_name, [:pointer, :string, :string], :pointer

  attach_function :mono_object_new, [:pointer, :pointer],:pointer
  attach_function :mono_runtime_object_init, [:pointer], :void
        
  attach_function :mono_class_get_field_from_name, [:pointer, :string], :pointer
  attach_function :mono_field_get_value, [:pointer, :pointer, :pointer], :void

  attach_function :mono_class_get_methods, [:pointer, :pointer], :pointer
  attach_function :mono_method_get_name, [:pointer], :string
  attach_function :mono_class_get_method_from_name, [:pointer, :string, :int], :pointer
  attach_function :mono_runtime_invoke, [:pointer, :pointer, :pointer, :pointer], :pointer
end

def test_libc
  Libc.puts "hello"
end

def learn_pointer
  require 'ffi'
  p = FFI::MemoryPointer.new(40)
  p.address
  p.write_string("hello")
  p.read_string
end

def show(msg)
  puts "--\t#{msg}"
end

def test_mono
  domain = Mono.mono_jit_init ''

  dll_name = 'invoke.exe'
  show "load lib: #{dll_name}"
  assembly = Mono.mono_domain_assembly_open(domain, dll_name)
  image = Mono.mono_assembly_get_image(assembly)

  show "run file: #{dll_name}"
  argv = FFI::MemoryPointer.new(:pointer, 1)
  arr = FFI::MemoryPointer.new(:char, 10)
  arr.write_string("hello.exe")
  argv.write_pointer(arr)
  Mono.mono_jit_exec(domain, assembly, 1, argv)

  show "load class"
  klass = Mono.mono_class_from_name(image, "Embed", "MyType")

  show "init class object"
  obj = Mono.mono_object_new(domain, klass)
  Mono.mono_runtime_object_init(obj)

  show "get field"
  field = Mono.mono_class_get_field_from_name(klass, "val")
  val = FFI::MemoryPointer.new(:int, 1)
  Mono.mono_field_get_value(obj, field, val)
  show "Value of field is: #{val.get_int32(0)}"

  show "call method"
  method = Mono.mono_class_get_method_from_name(klass, "method", 0)
  Mono.mono_runtime_invoke(method, obj, nil, nil)

  show "get methods"
  iter = FFI::MemoryPointer.new(:pointer, 1)
  names = []
  while true
    m = Mono.mono_class_get_methods(klass, iter)
    break unless m && !m.null?
    names << Mono.mono_method_get_name(m)
  end
  puts names.to_s

end

class MonoLoader
  def initialize
    @domain ||= Mono.mono_jit_init ''
  end

  def load_lib(filename)
    MonoLib.new(@domain, filename)
  end
end

class MonoLib

  def initialize(domain, filename)
    @domain = domain
    @assembly = Mono.mono_domain_assembly_open(@domain, filename)
    @image = Mono.mono_assembly_get_image(@assembly)
  end

  def get_class(namespace, name)
    klass = Mono.mono_class_from_name(@image, namespace, name)
    MonoClass.new(@domain, klass)
  end

end

class MonoClass
  def initialize(domain, klass)
    @domain = domain
    @klass = klass
  end

  def create
    obj = Mono.mono_object_new(@domain, @klass)
    Mono.mono_runtime_object_init(obj)
    MonoObject.new(@klass, obj)
  end
end

class MonoObject
  def initialize(klass, obj)
    @klass = klass
    @obj = obj
  end

  def call(method_name)
    method = Mono.mono_class_get_method_from_name(@klass, method_name, 0)
    Mono.mono_runtime_invoke(method, @obj, nil, nil)
  end
end

def test_mono_lib
  l = MonoLoader.new
  lib = l.load_lib('invoke.exe')
  klass = lib.get_class("Embed", "MyType")
  obj = klass.create
  obj.call('method')
end

def test_mono_cba
  l = MonoLoader.new
  cba_path = '/Users/halida/data/workspace/focus/cba_local'
  bin_path = File.join(cba_path, 'Cba.Website', 'bin')

  lib_focus = l.load_lib(File.join(bin_path, 'Focus.dll'))
  lib_tools = l.load_lib(File.join(bin_path, 'Focus.Tools.dll'))
  lib_objects = l.load_lib(File.join(bin_path, 'Cba.Objects.dll'))

  klass = lib_objects.get_class('CBA::Objects', 'Registry')
  klass.set_field(:connection_string, "server=192.168.10.67;Trusted_Connection=true;Integrated Security=False;Connection Timeout=120;database=connect_20151022;User Id=sa;Password=sa123;")
  klass = lib_objects.get_class('CBA::Objects', 'CbaCore')
  klass.call('register_objects')
end

test_mono_cba
