all about identities and permissions

identities such as google users or google groups or entire domains

identities also include service accounts.

RBAC also tells about identities and role also.

primitive and pre-defined roles


GCP identities:
-------------->
Goole accounts
Service accounts
Google groups
Gsuite Domains
Cloud identity domains


allUsers
allAuthenticatedUsers


Service account: identity of a program

Service account by itself enough for authentication but for authorization service account also needs akey.
User managed service accounts
google managed service accounts


Service account persmissons .. we can also attach IAM policies to the service accounts.




GCP Access:
------------->
given using RBAC or ACLs

ACLS are specific to single object

RBAC:
------>
Primitive  --> owner , editor, viewer

Pre-defined

Custom

IAM policy bindings:
---------------------->

Policy_Bindings:
------------------->
1. Members(goole account,service account etc...)  <-------> cloud IAM <----->  Organization->Folder->Project->Resource
2. Role(Compute.imageUser,Compute.instanceAdmin.v1)








