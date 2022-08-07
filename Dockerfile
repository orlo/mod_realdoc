FROM debian:buster

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -q update && \
    apt-get -qy install eatmydata && \
    eatmydata -- apt-get -qy install apache2 apache2-dev make dpkg-dev fakeroot && \
    apt-get clean

COPY . /srv 

WORKDIR /srv
RUN make install 
RUN cp /usr/lib/apache2/modules/mod_realdoc.so /srv/build/

RUN dpkg-buildpackage -rfakeroot -b --no-sign

RUN cp ../*.deb /srv/build/

# docker run -v $(pwd)/tmp:/srv/tmp -ti builder bash -c 'cp /srv/export/* /srv/tmp'

