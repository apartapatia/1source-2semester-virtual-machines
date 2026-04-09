output "vm_public_ip" {
  description = "Public IP address of the VM"
  value       = module.compute.public_ip
}