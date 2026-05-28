# Networking module

Provee VPC, subnets, IGW, route table associations y un security group.

Version: v1.0.0

Entradas principales:
- `vpc_cidr`, `public_subnet_cidr`, `private_subnet_cidr`, `ingress_rules`, `tags`

Salidas principales:
- `vpc_id`, `public_subnet_id`, `private_subnet_id`, `security_group_id`

Publicar este directorio como repo `terraform-aws-networking` y referenciar por `git::` desde el repo raíz.
