# Three-Tier Web Architecture on Azure

This Terraform configuration deploys a highly available three-tier web architecture on Azure, following enterprise best practices for security, scalability, and high availability.

## Architecture Overview

The architecture consists of three main tiers:

1. **Web Tier (Public)**
   - Application Gateway (Layer 7 Load Balancer)
   - Linux VMs running Nginx
   - Public subnets with internet access

2. **Application Tier (Private)**
   - Linux VMs running Java applications
   - Private subnets with no direct internet access
   - Communication with Web and Database tiers

3. **Database Tier (Private)**
   - Azure Database for MySQL Flexible Server
   - Private endpoints for secure access
   - Zone-redundant configuration

## Features

- **High Availability**
  - Multi-zone deployment
  - Load balancing with Application Gateway
  - Zone-redundant MySQL server

- **Security**
  - Network Security Groups at each tier
  - Private endpoints for database access
  - Azure Bastion Host for secure management
  - No public IPs on App and DB tiers

- **Networking**
  - Virtual Network with public and private subnets
  - NAT Gateway for outbound connectivity
  - Route tables for proper traffic routing

## Prerequisites

- Azure subscription
- Terraform 1.x
- Azure CLI
- SSH key pair

## Project Structure

```
.
├── main.tf                 # Main Terraform configuration
├── variables.tf            # Variable definitions
├── outputs.tf             # Output definitions
├── backend.tf             # Remote state configuration
├── terraform.tfvars       # Variable values (not in version control)
├── setup-backend.sh       # Script to set up remote state storage
└── modules/
    ├── networking/        # Network infrastructure
    ├── web/              # Web tier resources
    ├── app/              # Application tier resources
    └── db/               # Database tier resources
```

## Remote State Setup

1. **Set up Azure Storage Account for Remote State**
   ```bash
   # Make the setup script executable
   chmod +x setup-backend.sh

   # Run the setup script
   ./setup-backend.sh
   ```

2. **Configure Environment Variables**
   ```bash
   # Set the storage account access key
   export ARM_ACCESS_KEY=<storage-account-key>
   ```

3. **Initialize Terraform with Remote Backend**
   ```bash
   terraform init
   ```

## Usage

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd three-tier-azure-architecture
   ```

2. **Configure Azure credentials**
   ```bash
   az login
   az account set --subscription <subscription-id>
   ```

3. **Create terraform.tfvars**
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```
   Edit `terraform.tfvars` with your specific values.

4. **Initialize Terraform**
   ```bash
   terraform init
   ```

5. **Review the plan**
   ```bash
   terraform plan
   ```

6. **Apply the configuration**
   ```bash
   terraform apply
   ```

## Variables

Key variables to configure in `terraform.tfvars`:

- `resource_group_name`: Name of the resource group
- `location`: Azure region
- `vnet_cidr`: VNet address space
- `public_subnet_cidrs`: Public subnet CIDRs
- `private_app_subnet_cidrs`: App tier subnet CIDRs
- `private_db_subnet_cidrs`: DB tier subnet CIDRs
- `vm_size`: VM size for web and app tiers
- `admin_username`: Admin username for VMs
- `ssh_key`: SSH public key
- `db_name`: MySQL database name
- `db_admin`: MySQL admin username
- `db_password`: MySQL admin password

## Outputs

After deployment, Terraform will output:

- VNet and subnet IDs
- Public IP of Application Gateway
- Private IPs of VMs
- MySQL server FQDN
- Bastion Host IP

## Security Considerations

1. **Sensitive Data**
   - Never commit `terraform.tfvars` to version control
   - Use Azure Key Vault for secrets in production
   - Rotate credentials regularly

2. **Network Security**
   - Review and update NSG rules as needed
   - Consider adding Azure Firewall for additional protection
   - Implement Azure DDoS Protection

3. **Access Control**
   - Use Azure RBAC for resource access
   - Implement Azure AD integration
   - Enable MFA for administrative access

4. **State Security**
   - State is stored in Azure Storage Account with encryption
   - Access to state is controlled via Azure RBAC
   - Enable versioning on the storage account
   - Regularly backup the state file

## Cost Optimization

- Use appropriate VM sizes based on workload
- Consider Azure Reserved Instances for long-term workloads
- Implement auto-scaling where appropriate
- Monitor and optimize resource usage

## Maintenance

1. **Updates**
   - Regularly update Terraform and provider versions
   - Apply security patches to VMs
   - Update MySQL server to latest version

2. **Monitoring**
   - Enable Azure Monitor
   - Set up alerts for critical resources
   - Monitor performance metrics

3. **State Management**
   - Regularly backup the state file
   - Use state locking to prevent concurrent modifications
   - Clean up old state versions periodically

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For support, please open an issue in the repository or contact the maintainers. 