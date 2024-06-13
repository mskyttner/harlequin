# harlequin container (web variant)

This container provides a web variant (using tty2web) for "harlequin".

## Building

		docker build -t harlequin .

## Launching

After building, use:

		docker run -p 1294:1294 --rm harlequin

The non-web variant can be used too:

		docker run --rm -it harlequin

Data(bases/files) should be mounted into the /data directory.

## Issues

- How to use custom fonts in the tty2web interface? Preferably embedded in CSS (inline woff?).
- How to capture Ctrl-C signal to shut down container? Use tini and forward signals?

