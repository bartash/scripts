# List the jobs managed by the Background Intelligent Transfer
# Service (BITS) (which runs inside a Windows Service Host
# svchost.exe container)
#
# must be admin
echo must be admin to run
bitsadmin.exe /list /allusers
