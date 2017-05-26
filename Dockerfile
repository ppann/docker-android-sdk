FROM ubuntu:14.04.4

ENV DEBIAN_FRONTEND noninteractive
ENV ANDROID_HOME /opt/android-sdk-linux
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools

###
# JAVA 8 (https://askubuntu.com/questions/464755/how-to-install-openjdk-8-on-14-04-lts)
###
RUN apt-get update && \
    apt-get -y install software-properties-common && \
    add-apt-repository -y ppa:webupd8team/java && \
    apt-get update && \
    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections && \
    apt-get -y install oracle-java8-installer


##
# ANDROID SDK (Download Android SDK tools into $ANDROID_HOME)
##
RUN cd /opt && wget -q https://dl.google.com/android/android-sdk_r24.4.1-linux.tgz -O android-sdk.tgz && \
    cd /opt && tar -xvzf android-sdk.tgz && \
    cd /opt && rm -f android-sdk.tgz


##
# ANDROID SDKs
##
RUN echo y | android update sdk --no-ui --all --filter platform-tools | grep 'package installed'

RUN echo y | android update sdk --no-ui --all --filter android-25 | grep 'package installed'
# RUN echo y | android update sdk --no-ui --all --filter android-24 | grep 'package installed'
# RUN echo y | android update sdk --no-ui --all --filter android-23 | grep 'package installed'
# RUN echo y | android update sdk --no-ui --all --filter android-18 | grep 'package installed'
# RUN echo y | android update sdk --no-ui --all --filter android-16 | grep 'package installed'

RUN echo y | android update sdk --no-ui --all --filter build-tools-25.0.2 | grep 'package installed'
# RUN echo y | android update sdk --no-ui --all --filter build-tools-25.0.1 | grep 'package installed'
# RUN echo y | android update sdk --no-ui --all --filter build-tools-25.0.0 | grep 'package installed'
# RUN echo y | android update sdk --no-ui --all --filter build-tools-24.0.3 | grep 'package installed'
# RUN echo y | android update sdk --no-ui --all --filter build-tools-24.0.2 | grep 'package installed'
# RUN echo y | android update sdk --no-ui --all --filter build-tools-24.0.1 | grep 'package installed'
# RUN echo y | android update sdk --no-ui --all --filter build-tools-23.0.3 | grep 'package installed'
# RUN echo y | android update sdk --no-ui --all --filter build-tools-23.0.2 | grep 'package installed'
# RUN echo y | android update sdk --no-ui --all --filter build-tools-23.0.1 | grep 'package installed'


# Extras
RUN echo y | android update sdk --no-ui --all --filter extra-android-m2repository | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter extra-google-m2repository | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter extra-google-google_play_services | grep 'package installed'



RUN chown -R 1000:1000 $ANDROID_HOME && \
    apt-get clean