run:
	ruby receive_logs.rb info &
	ruby receive_logs.rb error &
	sleep 1
	ruby emit_log.rb error log1
	ruby emit_log.rb info log2
