# docker-lsyncd
Base docker image to run a lsyncd server
## Usage

```shell
sudo -i
vi config.lua
```

```shell
wget https://raw.githubusercontent.com/grengojbo/docker-tarmaker/master/lsyncd/lsyncd.service
systemctl enable /root/lsyncd.service
systemctl start lsyncd.service
systemctl status lsyncd.service
journalctl -u lsyncd
```
