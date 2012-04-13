test:
	time ruby test.rb
	rbx compile test.rb -o t.rbc
	time rbx -e "Rubinius::CodeLoader.require_compiled 't'"

