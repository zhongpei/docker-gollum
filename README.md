## docker-gollum

This Dockerfile is intended as a general purpose gollum instance. Adapted from https://github.com/suttang/docker-gollum


## Installation

	docker pull winkapp/gollum

## Usage

### Run container simply

    sudo docker run -d -P --name gollum winkapp/gollum

    # Check container port
    sudo docker port gollum
    # 0.0.0.0:49157

    wget http://localhost:49157

### Change port to 80

    sudo docker run -d -p 80:4567 --name gollum winkapp/gollum
    wget http://localhost

### You can attach some options

	sudo docker run -d -P --name gollum winkapp/gollum --allow-uploads --live-preview

[github.com/gollum/gollum](https://github.com/gollum/gollum#running)

### Use wikidata in host filesystem

	# Create and initialize wikidata
	mkdir ~/wikidata
	git init ~/wikidata

	sudo docker run -d -P -v ~/wikidata:/root/wikidata winkapp/gollum

### Load config file

	# Create and initialize wikidata
	mkdir ~/wikidata
	git init ~/wikidata

	# Create config.rb
	vi ~/config.rb

	sudo docker run -d -P -v ~/wikidata:/root/wikidata winkapp/gollum --config /root/wikidata/config.rb

### Use nginx-proxy

	sudo docker run -d -P --name gollum -v ~/wikidata:/root/wikidata -e VIRTUAL_HOST=wiki.example.com -e VIRTUAL_PORT=80 -p 80 winkapp/gollum --allow-uploads --config /root/wikidata/config.rb --port 80

[github.com/jwilder/nginx-proxy](https://github.com/jwilder/nginx-proxy)

### Customize suttang/gollum image

	sudo docker run -t -i --entrypoint="/bin/bash" winkapp/gollum

	# execute some commands in container's shell

	sudo docker commit -m "customized suttang/gollum by myself" CONTAINER_ID YOURNAME/gollum

or create new Dockerfile with `FROM winkapp/gollum`
