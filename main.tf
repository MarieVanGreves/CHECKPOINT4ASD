provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "AppServer" {
  ami           = "ami-0c55b159cbfafe1f0"  # ID de l'AMI Ubuntu
  instance_type = "t2.micro"

  tags = {
    Name = "AppServer"
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update
              sudo apt install -y docker.io
              sudo systemctl start docker
              sudo systemctl enable docker

              # Docker

              docker run -d -p 80:80 your-app-image

              # Installer et configurer Prometheus et Grafana ici
              # Installer Prometheus
              sudo useradd --no-create-home --shell /bin/false prometheus
              sudo mkdir /etc/prometheus
              sudo mkdir /var/lib/prometheus
              sudo chown prometheus:prometheus /etc/prometheus
              sudo chown prometheus:prometheus /var/lib/prometheus

              wget https://github.com/prometheus/prometheus/releases/download/v2.29.1/prometheus-2.29.1.linux-amd64.tar.gz
              tar xvf prometheus-2.29.1.linux-amd64.tar.gz
              sudo cp prometheus-2.29.1.linux-amd64/prometheus /usr/local/bin/
              sudo cp prometheus-2.29.1.linux-amd64/promtool /usr/local/bin/
              sudo cp -r prometheus-2.29.1.linux-amd64/consoles /etc/prometheus
              sudo cp -r prometheus-2.29.1.linux-amd64/console_libraries /etc/prometheus
              sudo cp prometheus-2.29.1.linux-amd64/prometheus.yml /etc/prometheus

              # Créer un service systemd pour Prometheus

              sudo bash -c 'cat <<EOT > /etc/systemd/system/prometheus.service
              [Unit]
              Description=Prometheus
              Wants=network-online.target
              After=network-online.target

              [Service]
              User=prometheus
              Group=prometheus
              Type=simple
              ExecStart=/usr/local/bin/prometheus --config.file /etc/prometheus/prometheus.yml --storage.tsdb.path /var/lib/prometheus/

              [Install]
              WantedBy=multi-user.target
              EOT'

              sudo systemctl daemon-reload
              sudo systemctl start prometheus
              sudo systemctl enable prometheus

              # Installer Grafana
              sudo apt-get install -y software-properties-common
              sudo add-apt-repository "deb https://packages.grafana.com/oss/deb stable main"
              sudo apt-get update
              sudo apt-get install -y grafana

              sudo systemctl start grafana-server
              sudo systemctl enable grafana-server
              EOF
}
