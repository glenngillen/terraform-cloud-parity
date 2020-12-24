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