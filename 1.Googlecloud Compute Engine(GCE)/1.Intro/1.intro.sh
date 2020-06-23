preemptible instances for cost saving.

Create GCE VM instances.
  - 1. Reserving static IPs
  - 2. Working with cloud storage.
  - 3. Persistent disks
  - 4. local SSDs

Compute Choices:
---------------->
compute and storage

network logging security audit.log


Google Compute Engine(GCE) --> Google Kubernetes Engine(GKE) --> Google App Engine(GAE) --> Google Cloud Functions(GCF)

IaaS
----->
location
configuration
networking
storage
metadata
administration


location:
---------->
Region: us-central1
zone: us-central1-a
Network: default

configuration:
-------------->
1.Machine Type -> memory size, no.of vCPUs and maximum persistent disk capability
predefined:
 - standard
 - high-memory
 - high-cpu
 - shared-core
 - memory-optimized
custom:


2.Base Image -> operating system image
Public:

custom:
 custom image


Service accounts:
------------------>
Every VM that you create on GCP is associated with the service account.

Service accounts allows for service to service authentication.

If you have application running on this virtual machine,
it will use the service account to authenticate itself to the other APIs in the GCP.


