# RHEL Reposync

Ansible + sync scripts to configure an internal RHEL mirror for Datto

# Host setup
Basic setup for this system requires a RHEL 9 server registered with subscription-manager:
```
subscription-manager register --org <org> --activationkey <activation-key>
```
Org ID and activation key can be found in [the Red Hat Customer Center](https://access.redhat.com/management/activation_keys).

## Development
For development, at least 250GB of disk is recommended. You may also configure a separate volume
as with prod and set `use_external_srv_volume` to true in your inventory.

## Production
Production use requires a separate volume -  At least 1TB is recommended.
`use_external_srv_volume` is enabled for the prod group by default, and the playbook will
automatically partition, format and mount this to `/srv`.
`srv_volume_disk_device` and `srv_volume_part_device` can be used to configure the device used for
the volume and the created partition - they default to `/dev/vdb`/`/dev/vdb1`.

Ports 80/443 should be open for the repo server, and 8002 for debuginfo. On systems managing their
own ingress via firewalld, the playbook will automatically configure those ports. Otherwise, they
should be configured using your network/cloud provider's tools as needed.

To use HTTPS, you need to set the `use_https` flag and set the paths to certificates to install
with `nginx_full_bundle_https_cert` and `nginx_private_server_https_key`.

* `nginx_full_bundle_https_cert` should be the server public cert concatenated with the CA cert
* `nginx_private_server_https_key` should be the private key for the server cert
