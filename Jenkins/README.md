## Enable tcp in Docker MAC
1. `brew install socat`
2. `socat TCP-LISTEN:2375,reuseaddr,fork UNIX-CONNECT:/var/run/docker.sock &`

## Connecting from container to host on MAC
The host has a changing IP address (or none if you have no network access). From 18.03 onwards our recommendation is to connect to the special DNS name host.docker.internal, which resolves to the internal IP address used by the host. This is for development purpose and will not work in a production environment outside of Docker for Mac.