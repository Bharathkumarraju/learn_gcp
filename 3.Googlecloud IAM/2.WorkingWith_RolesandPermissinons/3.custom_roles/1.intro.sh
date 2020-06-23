List all permissions assigned to a particular role.

bharath@cloudshell:~ (srianjaneyam)$ gcloud beta iam roles describe roles/storage.admin
description: Full control of GCS resources.
etag: AA==
includedPermissions:
- firebase.projects.get
- resourcemanager.projects.get
- resourcemanager.projects.list
- storage.buckets.create
- storage.buckets.delete
- storage.buckets.get
- storage.buckets.getIamPolicy
- storage.buckets.list
- storage.buckets.setIamPolicy
- storage.buckets.update
- storage.objects.create
- storage.objects.delete
- storage.objects.get
- storage.objects.getIamPolicy
- storage.objects.list
- storage.objects.setIamPolicy
- storage.objects.update
name: roles/storage.admin
stage: GA
title: Storage Admin
bharath@cloudshell:~ (srianjaneyam)$

