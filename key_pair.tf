resource "aws_key_pair" "bastion_key" {
  key_name = "RSSchoolDevops-bastion-key"
  public_key = file("/Users/bohdanshcherbyna/.ssh/id_rsa_aws_terraform.pub")
}
