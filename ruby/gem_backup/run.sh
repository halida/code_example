backup generate:config --config-file bb/config.rb

backup generate:model --config-file bb/config.rb -t mylib --storages=local --archives

backup perform --config-file bb/config.rb -t mylib
