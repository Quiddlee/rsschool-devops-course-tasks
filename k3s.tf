resource "aws_instance" "k3s_server" {
  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = "t3.medium"
  key_name      = aws_key_pair.bastion_key.key_name
  subnet_id     = aws_subnet.private_subnet_1.id
  vpc_security_group_ids = [aws_security_group.k3s_node_sg.id]

  user_data = <<-EOF
              INSTANCE_PRIVATE_IP=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)

              curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--node-ip=$${INSTANCE_PRIVATE_IP}" sh -s - server --kube-apiserver-arg="--etcd-quorum-guard=false" --write-kubeconfig-mode="0644"

              sleep 30
              echo "K3S_SERVER_IP=$${INSTANCE_PRIVATE_IP}" | sudo tee /etc/profile.d/k3s_server_ip.sh

              echo 'source <(kubectl completion bash)' >> ~/.bashrc
              echo 'alias k=kubectl' >> ~/.bashrc
              echo 'alias kg="kubectl get"' >> ~/.bashrc
              echo 'alias kd="kubectl describe"' >> ~/.bashrc
              EOF

  tags = {
    Name = "RSSchoolDevops-K3s-Server"
  }
}

resource "aws_instance" "k3s_agent" {
  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = "t3.small"
  key_name      = aws_key_pair.bastion_key.key_name
  subnet_id     = aws_subnet.private_subnet_2.id
  vpc_security_group_ids = [aws_security_group.k3s_node_sg.id]
  depends_on = [aws_instance.k3s_server]

  user_data = <<-EOF
              K3S_NODE_TOKEN="${random_string.k3s_token.result}"
              K3S_SERVER_IP="${aws_instance.k3s_server.private_ip}"

              curl -sfL https://get.k3s.io | K3S_URL="https://$${K3S_SERVER_IP}:6443" K3S_TOKEN="$${K3S_NODE_TOKEN}" INSTALL_K3S_EXEC="--node-ip=$${self.private_ip}" sh -s - agent

              echo 'source <(kubectl completion bash)' >> ~/.bashrc
              echo 'alias k=kubectl' >> ~/.bashrc
              echo 'alias kg="kubectl get"' >> ~/.bashrc
              echo 'alias kd="kubectl describe"' >> ~/.bashrc
              EOF

  tags = {
    Name = "RSSchoolDevops-K3s-Agent"
  }
}

output "k3s_server_private_ip" {
  description = "The private IP address of the K3s server node."
  value       = aws_instance.k3s_server.private_ip
}

output "k3s_agent_private_ip" {
  description = "The private IP address of the K3s agent node."
  value       = aws_instance.k3s_agent.private_ip
}
