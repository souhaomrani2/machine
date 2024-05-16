# Configuration Terraform
terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.1-rc1"
    }
  }
}

# Définition du provider Proxmox
provider "proxmox" {
  pm_api_url         = "https://192.168.127.177:8006/api2/json"
  pm_api_token_id    = "root@pam!souha"
  pm_api_token_secret = "f21d17d80-eda1-40e6-a9fa-6966c9475c59"
  pm_tls_insecure    = true  # Utilisation de HTTPS (non sécurisé dans cet exemple)
}

# Définition de la machine virtuelle Proxmox avec Cloud-Init
resource "proxmox_vm_qemu" "my_vm" {
  name        = "my-vm"
  target_node = "pve"       # Utilisez le nom du nœud Proxmox cible
  clone       = "VM 1804"   # Utilisez le nom du template à cloner défini dans les variables
  memory      = 1024
  cores       = 2

  # Configuration Cloud-Init
  provisioner "file" {
    source      = "cloud-init.yaml"
    destination = "/tmp/cloud-init.yaml"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/cloud-init.yaml",
      "sudo /tmp/cloud-init.yaml"
    ]
  }
}
