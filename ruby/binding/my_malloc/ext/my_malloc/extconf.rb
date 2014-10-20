require 'mkmf'

# have_func returns false if a C function cannot be found.  Sometimes this
# will be OK (the function changed names between versions) and sometimes it is
# not so you need to exit without creating the Makefile.

abort 'missing malloc()' unless have_func 'malloc'
abort 'missing free()'   unless have_func 'free'

# Now we create the Makefile that will install the extension as
# lib/my_malloc/my_malloc.so.

create_makefile 'my_malloc/my_malloc'

