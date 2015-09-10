From centos:latest

WORKDIR /usr/local/src

# install KyotoCabinet
RUN yum -y update 
RUN yum -y install wget make gcc-c++ zlib-devel lzo-devel.x86_64 lzma-devel.x86_64 xz-devel.x86_64
RUN wget http://fallabs.com/kyotocabinet/pkg/kyotocabinet-1.2.76.tar.gz
RUN tar zxfv kyotocabinet-1.2.76.tar.gz
RUN cd kyotocabinet-1.2.76;./configure
RUN cd kyotocabinet-1.2.76;make
RUN cd kyotocabinet-1.2.76;make install

# install KyotoTycoon
RUN yum -y install lua-devel.x86_64
RUN wget http://fallabs.com/kyototycoon/pkg/kyototycoon-0.9.56.tar.gz
RUN tar zxfv kyototycoon-0.9.56.tar.gz
RUN sed -i '24a\#include <unistd.h>' /usr/local/src/kyototycoon-0.9.56/ktdbext.h
RUN cd kyototycoon-0.9.56;./configure
RUN cd kyototycoon-0.9.56;make
RUN cd kyototycoon-0.9.56;make install
RUN cp ./kyototycoon-0.9.56/lab/ktservctl /usr/local/sbin/
RUN cp ./kyototycoon-0.9.56/lab/ktservctl /etc/rc.d/init.d/ktserver

# add memcache interchangeable
RUN sed -i '65a\cmd="$cmd -plsv /usr/local/src/kyototycoon-0.9.56/ktplugservmemc.so"' /etc/rc.d/init.d/ktserver
RUN sed -i '66a\cmd="$cmd -plex port=11401#opts=f#tout=10"' /etc/rc.d/init.d/ktserver

# clean
RUN yum clean all
RUN rm -rf /tmp/* /var/tmp/*
RUN rm kyotocabinet-1.2.76.tar.gz
RUN rm kyototycoon-0.9.56.tar.gz

CMD /etc/rc.d/init.d/ktserver start && tail -F /var/ktserver/log
