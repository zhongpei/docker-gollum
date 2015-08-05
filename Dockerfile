FROM ubuntu:14.04

MAINTAINER Nathan Smith <nathansmith22@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# Install dependencies
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y -q build-essential python2.7 libicu-dev libreadline-dev libssl-dev zlib1g-dev git-core curl cmake libxml2-dev
RUN apt-get clean
RUN rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

# Install rvm and ruby
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN \curl -L https://get.rvm.io | sudo bash -s stable --ruby

# Initialize wiki data
RUN mkdir /root/wikidata
RUN git init /root/wikidata

# Expose default gollum port 4567
EXPOSE 4567

# Temporary hack until gitlab grit pushes master to rubygems
RUN /bin/bash -c "source /usr/local/rvm/scripts/rvm \
  && git clone https://github.com/gitlabhq/grit.git \
  && cd grit \
  && gem build gitlab-grit.gemspec \
  && gem install gitlab-grit-2.7.3.gem"

ADD ./Gemfile /root/
RUN /bin/bash -c "source /usr/local/rvm/scripts/rvm && rvm --default use ruby-2.2.1 && cd /root && bundle install && cd -"

ADD ./run_gollum.sh /root/
ENTRYPOINT ["/root/run_gollum.sh"]
