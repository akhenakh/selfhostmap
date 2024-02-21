# selfhostmap

A complete solution to self host maps using [pmtiles](https://docs.protomaps.com/pmtiles/).

![amap](/img/example.jpg)

pmtiles can be served directly using HTTP range queries, but requires some additional js.
This solution aims at exposing the traditional MVT tiles /z/x/y format leveraging Caddy and a pmtiles plugin.

It can serve local files, over HTTP or s3 storage (see [remote-urls](https://github.com/protomaps/go-pmtiles?tab=readme-ov-file#remote-urls).

## Serve your map

See below if you don't know how to create your pmtiles files.

### Using Docker
```sh
docker run --rm -it -e BUCKET="file:///data" -e BASE_MAP_URL="http://192.168.1.3:8080" akhenakh/selfhostmap:latest 
```
### Using Caddy

You need to build Caddy with the pmtiles extension:

Install Caddy builder https://github.com/caddyserver/xcaddy

```sh
xcaddy build --with github.com/caddy-dns/cloudflare --with github.com/protomaps/go-pmtiles/caddy
```

Execute the resulting caddy binary:
```sh
BUCKET="file:///home/user/maps" BASE_MAP_URL="http://localhost:8080" ./caddy run -c ./Caddyfile.local
```
`BUCKET` should point to the directory you saved your pmtiles files.

Point your browser to http://localhost:8080

## QGIS

Works with QGIS:

Create a new Vector Tiles Connection:  
URL: http://192.168.1.3:8080/tiles/planet/{z}/{x}/{y}.mvt  
Style: http://192.168.1.3:8080/osm-liberty-gl.json  

Replace the url with your actual server.  
    ![QGIS](/img/qgis.jpg)
Then add the layer to your map.  
    ![QGISMap](/img/qgismap.jpg)

## Create a map using planetiler
```sh
wget https://github.com/onthegomap/planetiler/releases/latest/download/planetiler.jar
java -Xmx8g -jar planetiler.jar --download --area=france --output=france.pmtiles
```

See https://github.com/onthegomap/planetiler for the options.
