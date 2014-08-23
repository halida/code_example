# encoding: utf-8

##
# Backup Generated: my_backup
# Once configured, you can run the backup with the following command:
#
# $ backup perform -t my_backup [-c <path_to_configuration_file>]
#
Backup::Model.new(:my_backup, 'Description for my_backup') do
  ##
  # Split [Splitter]
  #
  # Split the backup file in to chunks of 250 megabytes
  # if the backup file size exceeds 250 megabytes
  #
  split_into_chunks_of 250
  ##
  # Archive [Archive]
  #
  # Adding a file:
  #
  #  archive.add "/path/to/a/file.rb"
  #
  # Adding an directory (including sub-directories):
  #
  #  archive.add "/path/to/a/directory/"
  #
  # Excluding a file:
  #
  #  archive.exclude "/path/to/an/excluded_file.rb"
  #
  # Excluding a directory (including sub-directories):
  #
  #  archive.exclude "/path/to/an/excluded_directory/
  #
  base = "/User/halida/data/workspace/code_example/ruby/backup/"

  archive :my_archive do |archive|
    archive.add base + '../em_tcp/'
  end

  ##
  # Local (Copy) [Storage]
  #
  store_with Local do |local|
    local.path       = location + "backup/"
    local.keep       = 5
  end

end
