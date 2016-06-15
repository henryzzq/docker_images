# Default domain 'base_domain' to be created inside the Docker image for WLS
# ==============================================

# Open default domain template
# ======================
readTemplate("/root/Oracle/Middleware/wlserver_10.3/common/templates/domains/wls.jar")

# Define the user password for weblogic
# =====================================
cd('/')
cd('Security/base_domain/User/weblogic')
cmo.setPassword('Oracle@123')

# Write the domain and close the domain template
# ==============================================
setOption('OverwriteDomain', 'true')

writeDomain('/root/Oracle/Middleware/user_projects/domains/osb_domain')
closeTemplate()

readDomain('/root/Oracle/Middleware/user_projects/domains/osb_domain')
addTemplate('/root/Oracle/Middleware/Oracle_OSB1/common/templates/applications/wlsb.jar')

# Configure the Administration Server and SSL port.
# =========================================================
cd('/Servers/AdminServer')
set('ListenAddress','')
set('ListenPort', 7001)

# Configure osb cluster and managed servers
# =========================================================
print 'Create OsbCluster...'
cd('/')
create('OsbCluster', 'Cluster')

print 'Create OsbServer1...'
cd('/')
create('OsbServer1', 'Server')
cd('Server/OsbServer1')
set('ListenAddress','')
set('ListenPort', 8001)

print 'Create OsbServer2...'
cd('/')
create('OsbServer2', 'Server')
cd('Server/OsbServer2')
set('ListenAddress','')
set('ListenPort', 8002)

print 'Create ProxyServer...'
cd('/')
create('ProxyServer','Server')
cd('Server/ProxyServer')
set('ListenAddress','')
set('ListenPort',8101)

print 'Assign OsbServer1,2 to OsbCluster...'
cd('/')
assign('Server','OsbServer1,OsbServer2','Cluster','OsbCluster')

print 'Set frontend port as proxy server port...'
cd('Clusters/OsbCluster')
set('FrontendHTTPPort',8101)
set("ClusterMessagingMode", "unicast")

print 'Done.'
updateDomain()
closeDomain()
# Exit WLST
# =========
exit()