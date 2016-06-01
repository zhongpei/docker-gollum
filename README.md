## docker-gollum

This Dockerfile is intended as a general purpose gollum instance. Adapted from https://github.com/suttang/docker-gollum


## Installation

	docker pull winkapp/docker-gollum

## Usage

### Run container simply

    sudo docker run -d -P --name gollum winkapp/docker-gollum

    # Check container port
    sudo docker port gollum
    # 0.0.0.0:49157

    wget http://localhost:49157

### Change port to 80

    sudo docker run -d -p 80:4567 --name gollum winkapp/docker-gollum
    wget http://localhost

### You can attach some options

	sudo docker run -d -P --name gollum winkapp/docker-gollum --allow-uploads --live-preview

[github.com/gollum/gollum](https://github.com/gollum/gollum#running)

### Use wikidata in host filesystem

	# Create and initialize wikidata
	mkdir ~/wikidata
	git init ~/wikidata

	sudo docker run -d -P -v ~/wikidata:/root/wikidata winkapp/docker-gollum

### Load config file

	# Create and initialize wikidata
	mkdir ~/wikidata
	git init ~/wikidata

	# Create config.rb
	vi ~/config.rb

	sudo docker run -d -P -v ~/wikidata:/root/wikidata winkapp/docker-gollum --config /root/wikidata/config.rb

### Use nginx-proxy

	sudo docker run -d -P --name gollum -v ~/wikidata:/root/wikidata -e VIRTUAL_HOST=wiki.example.com -e VIRTUAL_PORT=80 -p 80 winkapp/docker-gollum --allow-uploads --config /root/wikidata/config.rb --port 80

[github.com/jwilder/nginx-proxy](https://github.com/jwilder/nginx-proxy)
