# aprox – Simple caching proxy

Use the following commands to enable aprox:

```sh
echo 'Acquire::http::Proxy "http://127.0.0.1:3142";' | sudo tee /etc/apt/apt.conf.d/99proxy
sudo systemctl enable --now aprox.socket
sudo systemctl enable --now aprox-clean.timer
```

To customize address or port, run:
```sh
sudo systemctl edit aprox.socket
```
and update the URL in `/etc/apt/apt.conf.d/99proxy` accordingly.

You can also run **aprox** manually, optionally specifying `[address][:port]` on
the command line, and a custom cache directory via `APROX_ARCHIVES`. For
example:

```sh
APROX_ARCHIVES=/tmp/proxy aprox 192.168.1.1:8080
```

Share and enjoy.

## Authors

* **Dimitry Ishenko** - dimitry (dot) ishenko (at) (gee) mail (dot) com

## License

This project is distributed under the GNU GPL license. See the
[LICENSE.md](LICENSE.md) file for details.
