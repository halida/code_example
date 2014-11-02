require 'socket'
require 'resolv'

# resolve dns
# dns = Resolv::DNS.new
# ip = dns.getaddress("douban.com").to_s
# port = 80

# run
# python -m SimpleHTTPServer 8100

ip = '127.0.0.1'
port = 8100

header = """
GET http://127.0.0.1/ HTTP/1.1
"""

socket = TCPSocket.new(ip, port)
socket.write(header)
data = socket.read
puts data.count
