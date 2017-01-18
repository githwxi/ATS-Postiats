FROM ubuntu
MAINTAINER Steinway Wu "https://github.com/steinwaywhw"

# for installing erlang/elixir
WORKDIR /tmp
RUN apt-get -qq update
RUN apt-get -qq install -y wget libgmp3-dev libgc-dev make gcc build-essential git \
				bash libjson-c-dev pkg-config mit-scheme openjdk-8-jdk unzip nodejs
RUN wget http://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb
RUN dpkg -i erlang-solutions_1.0_all.deb
RUN apt-get -qq update
RUN apt-get -qq install -yq esl-erlang elixir
RUN apt-get clean

RUN wget http://repo1.maven.org/maven2/org/clojure/clojure/1.8.0/clojure-1.8.0.zip
RUN unzip clojure-1.8.0.zip && rm clojure-1.8.0.zip
RUN echo "export CLASSPATH=\${HOME}/clojure-1.8.0/*:\${CLASSPATH}:" >> ${HOME}/.bashrc

ADD ./*.sh /tmp/
RUN chmod +x *.sh 

ARG ATSVER 

ENV HOME=/root
ENV CC=gcc

ENV ATSVER=$ATSVER
ENV ATSHOME=${HOME}/ats-lang-anairiats-${ATSVER}
ENV ATSHOMERELOC=ATS-${ATSVER}

ENV PATSHOME=${HOME}/ATS-Postiats
ENV PATSHOMERELOC=${HOME}/ATS-Postiats-contrib
ENV PATSCONTRIB=${PATSHOMERELOC}
ENV PATSHOME_contrib=${PATSHOMERELOC}

ENV PATH=${PATH}:${PATSHOME}/bin

WORKDIR ${HOME}
RUN git clone https://github.com/githwxi/ATS-Postiats

WORKDIR /tmp
RUN (cd ${HOME} && /tmp/install_ats1.sh)
RUN (cd ${PATSHOME} && /tmp/install_ats2.sh)
RUN (cd ${PATSHOME} && /tmp/install_utilities.sh)
RUN (cd ${HOME} && /tmp/install_contrib.sh)

WORKDIR /tmp
RUN rm -rf *
CMD patscc