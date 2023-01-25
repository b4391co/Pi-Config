cd /var/www/html/hugopages

docker run --rm -it \
            -v $(pwd):/src \
            -p 1313:1313 \
            klakegg/hugo:0.101.0 \
            server -D  --bind 192.168.1.4