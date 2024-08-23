param (
	[Parameter(Mandatory=$true)]
	[string]$SecurityGroupId,

	[Parameter(Mandatory=$true)]
	[int]$Port,

	[Parameter(Mandatory=$true)]
	[string]$Protocol,

	[Parameter(Mandatory=$true)]
	[string]$IpRange,

	[Parameter(Mandatory=$true)]
	[int]$Duration
)

# Añadir la regla de entrada
Write-Host "Añadiendo la regla de entrada al grupo de seguridad..."
aws ec2 authorize-security-group-ingress --group-id $SecurityGroupId --protocol $Protocol --port $Port --cidr $IpRange

# Esperar la duración especificada
Write-Host "Esperando $Duration segundos antes de eliminar la regla..."
Start-Sleep -Seconds $Duration

# Eliminar la regla de entrada
Write-Host "Eliminando la regla de entrada del grupo de seguridad..."
aws ec2 revoke-security-group-ingress --group-id $SecurityGroupId --protocol $Protocol --port $Port --cidr $IpRange

Write-Host "Operación completada."