# Terraform Cloud Parity

## Taint

### Setup

* Setup a user with customized workspace access - remove their ability to read state, set it to "outputs only".
* Login via the CLI as the user with customized access.

### Reproduction

```bash
$ terraform taint random_pet.demo
Error locking state: Error acquiring the state lock: resource not found

Terraform acquires a state lock to protect the state from being written
by multiple users at the same time. Please resolve the issue above and try
again. For most commands, you can disable locking with the "-lock=false"
flag, but this is not recommended.
```

### Desired state

```bash
$ terraform taint random_pet.demo
Resource instance random_pet.demo has been marked as tainted.
```

## Refresh

### Reproduction

```bash
$ terraform refresh
Error: error starting operation:

The "remote" backend does not support the "OperationTypeRefresh" operation.
```

```bash
$ terraform plan -refresh=false
Error: Planning without refresh is currently not supported

Currently the "remote" backend will always do an in-memory refresh of the
Terraform state prior to generating the plan.
```

### Desired state

```bash
$ terraform refresh
random_pet.demo: Refreshing state... [id=intense-cod]

Outputs:

pet = intense-cod
```

```bash
$ terraform plan -refresh=false

No changes. Infrastructure is up-to-date.

This means that Terraform did not detect any differences between your
configuration and real physical resources that exist. As a result, no
actions need to be performed.
```

## Import

I went a meta on this demo, which makes it difficult to reproduce cleanly from this repo without
making a number of changes and jumping through hoops of switching back and forth between local
and remote backends. Which is exactly the problem we're trying to overcome sooo 🤷‍♂️, I guess it's
🐢 all the way down.

### Reproduction

```bash
$ terraform import -lock=false tfe_organization.demo Compu-Global-Hyper-Mega-Net

Warning: Value for var.TFE_TOKEN unavailable

The value of variable "TFE_TOKEN" is marked as sensitive in the remote
workspace. This operation always runs locally, so the value for that variable
is not available.

Error: required token could not be found

  on /Users/glenngillen/Development/terraform-cloud-parity/main.tf line 12, in provider "tfe":
  12: provider "tfe" {
```

```bash
$ TF_VAR_TFE_TOKEN=my-token-here terraform import -lock=false tfe_organization.demo Compu-Global-Hyper-Mega-Net

Warning: Value for var.TFE_TOKEN unavailable

The value of variable "TFE_TOKEN" is marked as sensitive in the remote
workspace. This operation always runs locally, so the value for that variable
is not available.

Error: required token could not be found

  on /Users/glenngillen/Development/terraform-cloud-parity/main.tf line 12, in provider "tfe":
  12: provider "tfe" {
```