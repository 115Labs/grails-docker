FROM java:7
MAINTAINER Manuel Ortiz Bey <ortiz.manuel@mozartanalytics.com>

# Set customizable env vars defaults.
# Set Grails version (max version for this Docker image is: 2.5.0).
ENV GRAILS_VERSION 2.5.0

# Set phusion/baseimage's correct settings.
ENV HOME /root

# Install Grails
WORKDIR /usr/lib/jvm
RUN wget http://dist.springframework.org.s3.amazonaws.com/release/GRAILS/grails-$GRAILS_VERSION.zip
RUN unzip grails-$GRAILS_VERSION.zip
RUN rm -rf grails-$GRAILS_VERSION.zip
RUN ln -s grails-$GRAILS_VERSION grails

# Setup Grails path.
ENV GRAILS_HOME /usr/lib/jvm/grails
ENV PATH $GRAILS_HOME/bin:$PATH

# Create App Directory
WORKDIR /
RUN mkdir /app
WORKDIR /app

# Clean up APT.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set Default Behavior
# Use phusion/baseimage's init system.
# See http://phusion.github.io/baseimage-docker/ for more info.
ENTRYPOINT ["/sbin/my_init", "grails"]
CMD ["prod", "run-war"]
