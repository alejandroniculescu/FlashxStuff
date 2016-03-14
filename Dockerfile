# FlashX Docker image 

FROM ubuntu:14.04
MAINTAINER Alexander Niculescu


###FLASHX CONF COMBINED FROM DOCKERFILE &&FLASHX QUICKSTART###
#https://github.com/icoming/FlashX/wiki/FlashX-Quick-Start-Guide
#https://github.com/wking/dockerfile
#Credits to Da Zheng for the original (JHU)

RUN sudo apt-get update
RUN sudo apt-get update
RUN sudo apt-get install -y git cmake g++
RUN sudo apt-get install -y libboost-dev libboost-system-dev libboost-filesystem-dev libnuma-dev libaio-dev libhwloc-dev libatlas-base-dev zlib1g-dev
RUN sudo apt-get install -y libstxxl-dev zlib1g-dev

RUN git clone https://github.com/icoming/FlashX.git

RUN sudo apt-get install wget
#wget is for trilinos

WORKDIR /FlashX
RUN mkdir build
WORKDIR build
RUN cmake ..
RUN make -j32


####Install and compile R
#https://www.digitalocean.com/community/tutorials/how-to-set-up-r-on-ubuntu-14-04
RUN sudo sh -c 'echo "deb http://cran.rstudio.com/bin/linux/ubuntu trusty/" >> /etc/apt/sources.list'
RUN gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9
RUN gpg -a --export E084DAB9 | sudo apt-key add -
RUN sudo apt-get update
RUN sudo apt-get -y install r-base

#run R >> intstall igraph install.packages("igraph")
RUN sudo su - -c "R -e \"install.packages('igraph', repos = 'http://cran.rstudio.com/')\""

WORKDIR /FlashX
RUN ./install_FlashR.sh

####R finished####

##Run FlashX Demo
CMD wget http://snap.stanford.edu/data/wiki-Vote.txt.gz
CMD gunzip wiki-Vote.txt.gz
CMD build/matrix/utils/el2fg conf/run_test.txt wiki-Vote.txt wiki-Vote

CMD build/flash-graph/test-algs/test_algs flash-graph/conf/run_test.txt wiki-Vote.adj wiki-Vote.index wcc
###FLASHX CONF END ###


