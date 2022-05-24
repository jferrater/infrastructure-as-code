FROM alpine:3.9

RUN mkdir -p /data/db && \
    addgroup -S -g 27017 mongodb && \
    adduser -S -u 27017 -g mongodb mongodb && \
    chown -R mongodb:mongodb /data

RUN apk add mongodb curl --update-cache --no-cache
 
VOLUME ["/data/db/"]
EXPOSE 27017
#USER mongodb
CMD ["/usr/bin/mongod", "--dbpath=/data/db"]
