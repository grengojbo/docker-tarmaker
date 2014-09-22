settings {
  logfile    = "/var/log/lsyncd.log",
  statusFile = "/var/log/lsyncd.status",
  statusInterval = 10,
  nodaemon   = true,
}

sync{
  default.rsync,
  source = "/storage/test1",
  target = "/storage/test2",
  delete = false,
}