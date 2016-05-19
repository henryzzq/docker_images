FROM ubuntu:14.04

MAINTAINER Henry Zhao (https://www.linkedin.com/in/dreamerhenry)

USER root

#Package installed: vim wget unzip
#JDK installed: 	JDK6
ENV JAVA16_HOME /root/jdk/jdk1.6.0_45
ENV JAVA17_HOME /root/jdk/jdk1.7.0_79
ENV JAVA18_HOME /root/jdk/jdk1.8.0_92

RUN apt-get update && \
    apt-get install -y wget vim unzip && \
    apt-get clean

#Download google drive script
RUN wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=0B-NEimEr29WddlFEbmhqTUVOZm8' -O gdown.pl

#Download JDK1.6
RUN perl gdown.pl 'https://docs.google.com/uc?export=download&id=0B-NEimEr29WddXo1X1hma0pTTXM' 'jdk-6u45-linux-x64.bin'

#Download JDK1.7
RUN perl gdown.pl 'https://docs.google.com/uc?export=download&id=0B-NEimEr29WdZV9xRXhfSGZfUWM' 'jdk-7u79-linux-x64.tar.gz'

#Download JDK1.8
RUN perl gdown.pl 'https://docs.google.com/uc?export=download&id=0B-NEimEr29WdZkVlbF8wc1U3c0U' 'jdk-8u92-linux-x64.tar.gz'

RUN mkdir /root/jdk

RUN chmod +x jdk-6u45-linux-x64.bin

RUN ./jdk-6u45-linux-x64.bin && \
    rm jdk-6u45-linux-x64.bin && \
    mv jdk1.6.0_45 /root/jdk/jdk1.6

RUN tar -xzvf jdk-7u79-linux-x64.tar.gz -C /root/jdk && \
    rm jdk-7u79-linux-x64.tar.gz && \
    mv /root/jdk/jdk1.7.0_79 /root/jdk/jdk1.7

RUN tar -xzvf jdk-8u92-linux-x64.tar.gz -C /root/jdk && \
    rm jdk-8u92-linux-x64.tar.gz && \
    mv /root/jdk/jdk1.8.0_92 /root/jdk/jdk1.8
    
CMD ["bash"]