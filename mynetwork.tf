# Create the mynet-us-vm instance
module "mynet-us-vm" {
  source           = "./instance"
  instance_name    = "mynet-us-vm"
  instance_zone    = "us-central1-c"
  instance_subnetwork = google_compute_network.mynetwork.self_link
}

# Create the mynet-eu-vm" instance
module "mynet-eu-vm" {
  source           = "./instance"
  instance_name    = "mynet-eu-vm"
  instance_zone    = "europe-west1-b"
  instance_subnetwork = google_compute_network.mynetwork.self_link
}

# Create the mynet-as-vm" instance
module "mynet-as-vm" {
  source           = "./instance"
  instance_name    = "mynet-as-vm"
  instance_zone    = "asia-east1-b"
  instance_subnetwork = google_compute_network.mynetwork.self_link
}
    
# Create the mynetwork network
resource "google_compute_network" "mynetwork" {
name                    = "mynetwork"
auto_create_subnetworks = true
}

# Add a firewall rule to allow HTTP, SSH, RDP, and ICMP traffic on mynetwork
resource "google_compute_firewall" "mynetwork-allow-http-ssh-rdp-icmp" {
name = "mynetwork-allow-http-ssh-rdp-icmp"
network = google_compute_network.mynetwork.self_link
allow {
    protocol = "tcp"
    ports    = ["22", "80", "443", "3389"]
    }
allow {
    protocol = "icmp"
    }
}
