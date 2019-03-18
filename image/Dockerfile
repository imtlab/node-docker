FROM imtlab/baseimage:##TAG##
LABEL maintainer="infra-ops@imtlab.io"

COPY . /node_build
RUN /node_build/install.sh
ENV PATH=/usr/local/lib/nodejs/bin:$PATH
CMD ["/sbin/my_init"]
