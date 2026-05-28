# Compute module

Crea una instancia EC2 simple y expone `instance_id` y `public_ip`.

Version: v1.0.0

Entradas:
- `ami`, `instance_type`, `subnet_id`, `security_group_ids`, `user_data`, `tags`

Salidas:
- `instance_id`, `public_ip`

Publicar este directorio como repo `terraform-aws-compute` y referenciar por `git::` desde el repo raíz.
