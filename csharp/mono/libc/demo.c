#include <mono/jit/jit.h>
#include <mono/metadata/assembly.h>

/* The C# signature for this method is: string GetMessage () in class Sample */
MonoString*
getMessage()
{
	return mono_string_new(mono_domain_get (), "Hello, world");
}

int main(int argc, char ** argv)
{
	/*
	 * Load the default Mono configuration file, this is needed
	 * if you are planning on using the dllmaps defined on the
	 * system configuration
	 */
	mono_config_parse(NULL);

	/*
	 * mono_jit_init() creates a domain: each assembly is
	 * loaded and run in a MonoDomain.
	 */
	MonoDomain *domain = mono_jit_init("startup.exe");

	/*
	 * Optionally, add an internal call that your startup.exe
	 * code can call, this will bridge startup.exe to Mono
	 */
        mono_add_internal_call("Sample::GetMessage", getMessage);

	/*
	 * Open the executable, and run the Main method declared
	 * in the executable
	 */
	MonoAssembly *assembly = mono_domain_assembly_open(domain, "startup.exe");

	if (!assembly) exit (2);
            
	/*
	 * mono_jit_exec() will run the Main() method in the assembly.
	 * The return value needs to be looked up from
	 * System.Environment.ExitCode.
	 */
	mono_jit_exec(domain, assembly, argc, argv);
}

