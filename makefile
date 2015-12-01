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
	hugo server --theme=hyde --buildDrafts

home: blueprint-home
	rsync -vaz --delete public/ pi@krukas.dyn.amicdns.de:public_html/blueprint/

blueprint-home: .FORCE
	hugo -D -b http://krukas.dyn.amicdns.de/~pi/blueprint --theme=hyde --buildDrafts
	# change directories to 755
	find public -type d -print0 | xargs -0 chmod 755
	# change files to 644
	find public -type f -print0 | xargs -0 chmod 644

.FORCE: