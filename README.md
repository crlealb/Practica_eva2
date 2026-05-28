# Terraform multi-module refactor

**Estructura de módulos**

- `modules/networking` — Provee VPC, subnets públicas/privadas, Internet Gateway, route table y un security group para la aplicación.
- `modules/compute` — Crea la instancia EC2 (usa subred y security group entregados por `networking`).
- `modules/storage` — Crea un bucket S3 con versioning y bloqueo de acceso público.

**Qué hace cada módulo**

- `networking`:
  - Crea `aws_vpc`, dos `aws_subnet` (pública y privada), `aws_internet_gateway`, `aws_route_table` y `aws_security_group` con reglas de ingreso predefinidas.
  - Exporta: `vpc_id`, `public_subnet_id`, `private_subnet_id`, `security_group_id`.

- `compute`:
  - Crea `aws_instance` configurable por `ami`, `instance_type`, `user_data` y etiquetas.
  - Recibe `subnet_id` y `security_group_ids` desde `networking`.
  - Exporta: `instance_id`, `public_ip`.

- `storage`:
  - Crea `aws_s3_bucket` con `aws_s3_bucket_versioning` y `aws_s3_bucket_public_access_block`.
  - Genera sufijo seguro usando `random_id`.
  - Exporta: `bucket_name`.

**Módulos locales**

Cada módulo ya está definido en su propio directorio bajo `./modules/<name>` y el módulo raíz está configurado para usarlos localmente. No necesitas GitHub para esta evaluación.

Los valores que debes cambiar están entre corchetes en `terraform.tfvars.example`:

- `vpc_name = "[VPC_NAME]"`
- `bucket_prefix = "[BUCKET_PREFIX]"`
- `instance_name = "[INSTANCE_NAME]"`

**Justificación de la versión elegida**

- Se usa `v1.0.0` como versión inicial de ejemplo: representa una primera versión del módulo con interfaz estable de variables y outputs.

**Cómo probar localmente**

- La configuración actual ya usa módulos locales en `./modules/...`, por lo que no es necesario cambiar nada para ejecutar.

**Personalización rápida (para presentar mañana)**

- Copia `terraform.tfvars.example` a `terraform.tfvars` y reemplaza los valores entre corchetes por tus nombres deseados.
- Por defecto los módulos apuntan a las carpetas locales `./modules/*`, así no necesitas dependencias externas.
- Para ejecutar rápidamente:

```powershell
Copy-Item terraform.tfvars.example terraform.tfvars
.\apply.ps1
```

Para destruir los recursos al terminar:

```powershell
.\apply.ps1 -Destroy
```

**Notas**

- Mantén los módulos pequeños y reutilizables. Si más adelante necesitas separar reglas de seguridad o NAT gateways, crea módulos adicionales.
