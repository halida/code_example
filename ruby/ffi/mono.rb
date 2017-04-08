require 'ffi'

module MyLib
  extend FFI::Library
  ffi_lib 'libmono-2.0.dylib'

  attach_function :mono_jit_init, [ :string ], :int
end

def run
  MyLib.mono_jit_init 'run.exe'
  mono_assembly_get_image(MonoAssembly *assembly)
  
  System.Console.WriteLine("hello")
end

run
