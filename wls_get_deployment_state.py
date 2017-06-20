import socket
connect('weblogic','webl0gic','t3://' + (socket.gethostname()) + ':7001')
cd ('AppDeployments')
myapps=cmo.getAppDeployments()

for appName in myapps:
       domainConfig()
       cd ('/AppDeployments/'+appName.getName()+'/Targets')
       mytargets = ls(returnMap='true')
       domainRuntime()
       cd('AppRuntimeStateRuntime')
       cd('AppRuntimeStateRuntime')
       for targetinst in mytargets:
             curstate4=cmo.getCurrentState(appName.getName(),targetinst)
             print '-----------', curstate4, '-----------', appName.getName()
