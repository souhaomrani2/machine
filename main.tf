terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = ">= 3.0.1"
    }
  }
}

provider "proxmox" {
  pm_api_url         = "https://192.168.127.177:8006/api2/json"
  pm_api_token_id    = "your-api-token-id"
  pm_api_token_secret = "your-api-token-secret"
  pm_tls_insecure    = true
}

resource "proxmox_vm_qemu" "my_vm" {
  name        = "my-vm"
  target_node = "pve"
  clone       = "VM 1804"
  memory      = 1024
  cores       = 2

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
