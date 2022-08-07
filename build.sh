
[ ! -d build ] && mkdir build

docker build -t apache-builder --pull -f ./Dockerfile .

docker run -v $(pwd)/build:/srv/tmp -ti apache-builder bash -c 'cp /srv/build/* /srv/tmp'

