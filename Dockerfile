FROM gliderlabs/alpine:3.4

# we need to get requirements, clone binkd, compile it and remove the requirements
# in one step. we do this to stop each command being saved as a separate layer, 
# saving ~187mb!

RUN apk add build-base \
            gcc \
            abuild \
            binutils \
            binutils-doc \
            gcc-doc \
            git \
            --no-cache \
        && git clone https://github.com/pgul/binkd.git /tmp/binkd-src \
        && cd /tmp/binkd-src \
        && cp mkfls/unix/* . \
        && ./configure \
        && make \
        && make install \
        && apk del build-base gcc abuild binutils binutils-doc gcc-doc git \
        && rm -rf /tmp/binkd-src

VOLUME /config
VOLUME /mail

EXPOSE 24554

ENTRYPOINT ["binkd"]

