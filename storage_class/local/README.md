
Commands and scripts to enable local storage class in OCP on AWS

Change the SELinux labels so OCP can see the new EBS volume

chcon -R unconfined_u:object_r:svirt_sandbox_file_t:s0 /mnt/local-storage/
