/*output "ip" {
  value = google_compute_address.vm_static_ip.address
}*/
output ip1 {
  value = google_compute_instance.control.network_interface[0].access_config[0].nat_ip
}
output ip2 {
  value = google_compute_instance.worker1.network_interface[0].access_config[0].nat_ip
}
output ip3 {
  value = google_compute_instance.worker2.network_interface[0].access_config[0].nat_ip
}