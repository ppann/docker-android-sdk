FROM ubuntu:14.04.4

ENV DEBIAN_FRONTEND noninteractive
ENV ANDROID_HOME /opt/android-sdk
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools

###
# JAVA 8 (https://askubuntu.com/questions/464755/how-to-install-openjdk-8-on-14-04-lts)
###
RUN apt-get update && \
    apt-get -y install software-properties-common && \
    add-apt-repository -y ppa:webupd8team/java && \
    apt-get update && \
    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections && \
    apt-get -y install oracle-java8-installer && \
    apt-get -y install unzip

###
# Android SDK Tools
# https://developer.android.com/studio/index.html#downloads (2017-05-30)
###
RUN cd /opt && \
    wget -q https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip -O sdk-tools-linux.zip && \
    unzip sdk-tools-linux.zip -d android-sdk && \
    rm -f sdk-tools-linux.zip

RUN mkdir -p ~/.android && \
    touch ~/.android/repositories.cfg && \
    echo y | sdkmanager "platform-tools" \
                        "platforms;android-26" \
                        "build-tools;26.1.1" \
                        "extras;google;m2repository" \
                        "extras;android;m2repository" \
                        "extras;google;google_play_services"


RUN chown -R 1000:1000 $ANDROID_HOME && \
    apt-get clean
