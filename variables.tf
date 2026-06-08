variable "company-name" {
    type = string
    description = "Nombre de la organizacion para el estandar de nomenclatura"
    default = "KanetTech"
}

variable "environment" {
    type = string
    description = "Ambiente para el estandar de nomenclatura"
    default = "prod"
}

variable "location" {
    type = string
    description = "Region de Azure donde se crearan los recursos"
    default = "eastus2"
}

variable "vnet_cidr" {
    type = list(string)
    description = "Rango de IPs principal para la red virtual"
    default = ["10.0.0.0/16"]
}