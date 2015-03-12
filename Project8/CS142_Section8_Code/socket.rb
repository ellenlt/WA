require 'socket'

# NOTE: You must have the netslip Rails app running for this to work!

http = Array.new
http << "GET /movies/selectGenre HTTP/1.1"
http << "Host: localhost:3000"
http << "Connection: close"      # Close connection after response

# Create HTTP request string
request = http.join("\r\n") + "\r\n\r\n"

# Open socket
socket = TCPSocket.open("localhost", 3000)

# Send request
socket.puts(request)

# Read response
response = socket.read

# Close socket
socket.close

# Print response
puts response
