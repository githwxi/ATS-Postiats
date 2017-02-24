#!/usr/bin/env sh

# install scheme/nodejs/python
apt-get -qq install -y mit-scheme nodejs python3 python2.7 python

# install erlang/elixir
wget http://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb
dpkg -i erlang-solutions_1.0_all.deb
apt-get -qq update
apt-get -qq install -yq esl-erlang elixir
apt-get clean

# install clojure
wget http://repo1.maven.org/maven2/org/clojure/clojure/1.8.0/clojure-1.8.0.zip
unzip clojure-1.8.0.zip && rm clojure-1.8.0.zip
echo "export CLASSPATH=\${HOME}/clojure-1.8.0/*:\${CLASSPATH}:" >> ${HOME}/.bashrc
