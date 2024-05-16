variable "pm_api_url" {
  description = "URL de l'API Proxmox"
  default     = "https://192.168.127.177:8006/api2/json"  # Remplacez par l'URL de votre API Proxmox
}

variable "pm_user" {
  description = "Nom d'utilisateur Proxmox"
  default     = " root@pam!souha"  # Remplacez par votre nom d'utilisateur Proxmox
}

variable "pm_password" {
  description = "Mot de passe Proxmox"
  default     = "21d17d80-eda1-40e6-a9fa-6966c9475c59  "  # Remplacez par votre mot de passe Proxmox
}

variable "template" {
  description = "Nom du modèle pour la création de la machine virtuelle"
  type        = string
  default     = "VM 1804"  # Remplacez par le nom de votre modèle de machine virtuelle Proxmox
}

variable "target_node" {
  description = "Nœud Proxmox sur lequel déployer la machine virtuelle"
  default     = "pve"  # Remplacez par le nom de votre nœud Proxmox cible
}
