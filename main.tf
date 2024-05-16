terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = ">=3.0.0"  # Utilisez une version supérieure ou égale à 3.0.0
    }
  }
}

provider "proxmox" {
  pm_api_url         = "https://192.168.127.177:8006/api2/json"
  pm_api_token_id    = "root@pam!souha2"
  pm_api_token_secret = "4368e63e-53e8-4e07-b25a-856cab14593e"
  pm_tls_insecure    = true
}

resource "proxmox_vm_qemu" "my_vm" {
  name        = "my-vm"
  target_node = "pve"
  clone       = "VM 1804"
  agent       = 1

  disk {
    storage = "local-lvm"
    size    = "10G"
  }

  cloud_init {
    user_data = templatefile("${path.module}/cloud-init.yaml", {})
  }
}

output "vm_ip_address" {
  value = proxmox_vm_qemu.my_vm.ip_address
}
