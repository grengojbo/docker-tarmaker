settings {
  logfile    = "/var/log/lsyncd.log",
  statusFile = "/var/log/lsyncd.status",
  statusInterval = 10,
  nodaemon   = true,
}

sync{
  default.rsync,
  source = "/data/test1",
  target = "/data/test2",
  delete = false,
}
