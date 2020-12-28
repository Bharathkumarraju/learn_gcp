mkdir foresti_setup
cd foresti_setup

git clone https://github.com/GoogleCloudPlatform/forseti-security.git
ls
cd forseti-security
ls

nano install/gcp_installer.py
python install/gcp_installer.py
Check deployment manager, bucket, iam, instances

ssh into forseti instance (server)
tail -n1 /tmp/deployment.log

forseti config show
forseti inventory --help
forseti inventory create
forseti inventory list
forseti inventory get <INVENTORY_INDEX_ID>
forseti model create --inventory_index_id <INVENTORY_INDEX_ID> <MODEL_NAME>

forseti inventory delete <INVENTORY_INDEX_ID>
forseti model list
forseti model get <MODEL_NAME>
forseti model use <MODEL_NAME>
forseti scanner run
forseti explainer list_resources 

forseti explainer list_members
forseti explainer list_roles
forseti explainer list_permissions --roles roles/iam.roleAdmin roles/resourcemanager.projectMover
forseti server configuration get

forseti server log_level get


forseti notifier --help

forseti notifier run



