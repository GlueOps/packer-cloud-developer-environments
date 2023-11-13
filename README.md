# packer-cloud-developer-environments


When working locally set the following:

```bash
export PACKER_LOG=1
export AWS_ACCESS_KEY_ID=<dev-captain-aws-account>
export AWS_SECRET_ACCESS_KEY=<dev-captain-aws-account>
export PACKER_LOG=1
export PKR_VAR_aws_access_key=$AWS_ACCESS_KEY_ID
export PKR_VAR_aws_secret_key=$AWS_SECRET_ACCESS_KEY
export PKR_VAR_glueops_codespaces_container_tag=local-dev
packer build aws.pkr.hcl
```

The packer template expects you to always do you build in us-west-2 and replicate from there to other regions.

By default the AMI will be prefixed with the date and then the codespace version. The tags for this repo should be respective of changes in this repo and not the codespaces version being used. That being said we might be using v0.30.0 of codespace and this repo could be tagged as v0.1.0 or even v0.2.0. As bug fixes are made in this repo, it will likely move at different cadence than the codespace container tag
