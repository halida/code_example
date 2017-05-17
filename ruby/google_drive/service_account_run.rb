require "google_drive"

session = GoogleDrive::Session.from_service_account_key("service_account.json")

# Gets list of remote files.
session.files.map(&:title)

# Uploads a local file.
session.upload_from_file("temp.txt", "hello.txt", convert: false)

# Downloads to a local file.
file = session.file_by_title("hello.txt")
file.download_to_file("hello.txt")

# Updates content of the remote file.
file.update_from_file("hello.txt")

# export file
file.export_as_string("text/html")
