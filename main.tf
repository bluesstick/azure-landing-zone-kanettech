# 1. Grupo de Recursos Principal (Contenerdor Logico)
resource "azurerm_resource_group" "rg_principal" {
    name     = "rg-${var.company-name}-${var.environment}-${var.location}"
    location = var.location

tags = {
        Proyecto    = "Migracion KanetTech"
        Gestionado  = "Terraform"
        Owner       = "KanetTech"
    }
}

# 2. Red Virtual Principal (VNet)
resource "azurerm_virtual_network" "vnet_principal" {
    name                = "vnet-${var.company-name}-${var.environment}-${var.location}"
    location            = azurerm_resource_group.rg_principal.location
    resource_group_name = azurerm_resource_group.rg_principal.name
    address_space       = var.vnet_cidr
    
    tags = azurerm_resource_group.rg_principal.tags
}

# 3. Subred para Sevicios Core / Computo
resource "azurerm_subnet" "sub_core" {
    name                 = "snet-core-${var.environment}-001"
    resource_group_name  = azurerm_resource_group.rg_principal.name
    virtual_network_name = azurerm_virtual_network.vnet_principal.name
    address_prefixes     = ["10.0.1.0/24"]
}

# 4. Grupo de seguridad de Red (Firewall de la Subred)
resource "azurerm_network_security_group" "nsg_core" {
name                = "nsg-core-${var.environment}-001"
location            = azurerm_resource_group.rg_principal.location
resource_group_name = azurerm_resource_group.rg_principal.name

# Regla de Seguridad: Permitir entrada HTTPS (Puerto 443) de forma segura
security_rule {
    name                       = "Allow-HTTPS-Inbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
}

tags = azurerm_resource_group.rg_principal.tags
}

# 5. Asociación del NSG a nuestra Subred (El puente de union)
resource "azurerm_subnet_network_security_group_association" "nsg_assoc" {
    subnet_id                 = azurerm_subnet.sub_core.id
    network_security_group_id = azurerm_network_security_group.nsg_core.id
}
