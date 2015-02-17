require 'socket'
require 'resolv'

# resolve dns
# dns = Resolv::DNS.new
# ip = dns.getaddress("douban.com").to_s
# port = 80

# run
# python -m SimpleHTTPServer 8100

ip = '46.137.198.152'
port = 1723

header = """
GET http://127.0.0.1/ HTTP/1.1
"""

socket = TCPSocket.new(ip, port)
socket.write(header)
data = socket.read
puts data.count
