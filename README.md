# quake3e-docker


Build the image with:

`docker build -t quake3e/server .`

Create a volume that will contain the Quake3 Paks:

`docker volume create quake3-data`

Start the server:

`docker run -dit --name=quake3e --restart=always -p 27960:27960/udp -v quake3-data:/home/quake3esrv/.q3a/ quake3e/server`

The server will start and die due to the missing Paks. At this point you can `docker cp` the packs into /home/quake3esrv/.q3a in the container and restart it.
