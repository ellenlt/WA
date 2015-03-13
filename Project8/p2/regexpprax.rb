response = "X-Frame-Options: SAMEORIGIN
X-Xss-Protection: 1; mode=block
X-Content-Type-Options: nosniff
X-Ua-Compatible: chrome=1
Content-Type: text/html; charset=utf-8
Etag: 'c69e6760a77831f122f09fce8d6ceb5d'
Cache-Control: max-age=0, private, must-revalidate
X-Request-Id: d910bbd5-645e-4b98-b154-54f5588d07fa
X-Runtime: 0.008206
Server: WEBrick/1.3.1 (Ruby/2.1.4/2014-10-27)
Date: Thu, 12 Mar 2015 19:01:43 GMT
Content-Length: 1811
Connection: close
Set-Cookie: _session_id=a253fdbeb92112160cb0c582ca42c229; path=/; HttpOnly
><input name='authenticity_token' type='hidden' value='2e4Jz4b4Nb7RQ2MqYyP2XK3O9JZOVWuZMIw9suWmzDU=' /></div>    <div>
</html>"

authToken = (response =~ /<input name=['"]authenticity_token['"] type=['"]hidden['"] value=['"](.*)['"]/) ? $1 : nil
puts "auth is: #{authToken}"