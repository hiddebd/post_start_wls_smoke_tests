import socket

def serverStatus(server):
 cd('/ServerLifeCycleRuntimes/' + server.getName())
 return cmo.getState()

username = 'weblogic'
password = 'webl0gic'
URL='t3://'+ (socket.gethostname()) + ':7001'

try:
 connect(username,password,URL)
except:
 print 'Could not connect to AdminServer. Please check server is running.'
 exit()

servers = cmo.getServers()
domainRuntime()
print '#### Weblogic Domain Status ####'

for server in servers:
 serverState = serverStatus(server)
 print 'Server ' + str(server.getName()) + ' is ' + serverState # + ' on ' + str(machine.getName())
 print '################################'

disconnect()
stopRedirect()
exit()
