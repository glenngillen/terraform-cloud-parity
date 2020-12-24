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
