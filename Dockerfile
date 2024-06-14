FROM python:3.11

ENV PYTHONUNBUFFERED=1
ENV PIPX_HOME=/opt/pipx
ENV PIPX_BIN_DIR=/usr/local/bin
ENV COLORTERM=truecolor

RUN pip install pipx && \
    pipx install harlequin

# install duckdb cli and tty2web

RUN apt-get update -y && apt-get install -y \
    wget unzip

# possibly instead use gotty like here: https://github.com/byReqz/gotty-docker/blob/main/Dockerfile

RUN wget -O /tmp/gotty.tgz "https://github.com/sorenisanerd/gotty/releases/download/v1.5.0/gotty_v1.5.0_linux_amd64.tar.gz"  && \
    tar xvfz /tmp/gotty.tgz -C /usr/local/bin && \
    chmod +x /usr/local/bin/gotty

RUN wget -O /usr/local/bin/tty2web "https://github.com/kost/tty2web/releases/download/v3.0.3/tty2web_linux_amd64" && \
    chmod +x /usr/local/bin/tty2web

RUN wget -O /tmp/duckdb.zip "https://github.com/duckdb/duckdb/releases/download/v1.0.0/duckdb_cli-linux-amd64.zip" && \
	unzip /tmp/duckdb.zip -d /usr/local/bin && \
	chmod +x /usr/local/bin/duckdb && \
	rm /tmp/duckdb.zip

VOLUME ["/data"]
EXPOSE 1294

# styling
COPY harlequin_tty2web.conf /root/.tty2web
COPY harlequin_bg.jpg /root/harlequin_bg.jpg
COPY index2.html /root/index.html

RUN apt install -y fonts-dejavu

#COPY local.conf /etc/fonts/local.conf

CMD bash -c "COLORTERM=truecolor TERM=xterm-256color tty2web --address 0.0.0.0 --port ${PORT:-1294} --config ~/.tty2web --term xterm --index ~/index.html --permit-write --reconnect harlequin --theme solarized-light"

# other commands that can be used

#CMD bash -c "COLORTERM=truecolor tty2web --address 0.0.0.0 --port ${PORT:-1294} --permit-write --reconnect duckdb"
#CMD harlequin --theme solarized-light -e httpfs -e json -e parquet -e sqlite -e excel -e aws
#CMD duckdb
