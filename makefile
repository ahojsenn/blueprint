#
# 2015-12-01
# Johannes Mainusch
# purpose: to help make a static website with hugo
# inspired by: http://tepid.org/tech/hugo-web/
#

all: blueprint-home home

hugo:
	brew install hugo

clone-blueprint:
	git clone git@github.com:ahojsenn/blueprint.git

server:
	hugo server

RUM:
	# an a one line WebServer for RUM Monitoring
	while true; do { echo -e 'HTTP/1.1 200 OK\r\n\nconsole.log ("blueprint is 42")'; } | nc -l 12345 | grep logme; done
killRUM:
	ps -ef | grep "nc -l 12345" | awk '{print "kill -9 "$2}'

home: blueprint-home
	rsync -vaz --delete public/ pi@krukas.dyn.amicdns.de:public_html/blueprint/

blueprint-home: .FORCE
	hugo -D -b http://krukas.dyn.amicdns.de/~pi/blueprint --theme=blueprint --buildDrafts
	# change directories to 755
	find public -type d -print0 | xargs -0 chmod 755
	# change files to 644
	find public -type f -print0 | xargs -0 chmod 644

.FORCE: