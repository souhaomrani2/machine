terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.1-rc1"
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

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      host        = self.network_interface.0.ipv4_address
      user        = "your_ssh_user"
      private_key = file("~/.ssh/id_rsa")
    }

    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y qemu-guest-agent",
      "sudo systemctl enable qemu-guest-agent",
      "sudo systemctl start qemu-guest-agent"
    ]
  }
}

output "vm_ip_address" {
  value = proxmox_vm_qemu.my_vm.ip_address
}
