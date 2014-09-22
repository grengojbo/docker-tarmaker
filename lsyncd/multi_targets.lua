settings = {
   delay        = 1,
   maxProcesses = 3,
   logfile      = "/var/log/lsyncd.log",
}
 
targetlist = {
 "10.0.1.24:/var/www/thomasjstein.com", 
 "10.0.1.26:/var/www/thomasjstein.com"
}
 
for _, server in ipairs(targetlist) do
  sync{ default.rsync,
    source="/var/www/thomasjstein.com",
    rsyncOps="-rltvupgo",
    target=server
  }
end