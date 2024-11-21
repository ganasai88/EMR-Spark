resource "aws_security_group" "emr_master" {
  name                   = "${var.name} - EMR-master"
  description            = "Security group for EMR master."
  vpc_id                 = var.vpc_id
  revoke_rules_on_delete = true

  # Allow SSH access (trusted IPs only, or VPC CIDR)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Replace with your trusted IP range
  }

  # Allow Spark Web UI (restricted to VPC CIDR)
  ingress {
    from_port   = 4040
    to_port     = 4040
    protocol    = "tcp"
    cidr_blocks = [var.ingress_cidr_blocks] # Ensure this is the private VPC CIDR
  }

  # Allow Jupyter Notebook access (restricted to VPC CIDR)
  ingress {
    from_port   = 8888
    to_port     = 8888
    protocol    = "tcp"
    cidr_blocks = [var.ingress_cidr_blocks] # Ensure this is the private VPC CIDR
  }

  # Allow HDFS NameNode Web UI (restricted to VPC CIDR)
  ingress {
    from_port   = 20888
    to_port     = 20888
    protocol    = "tcp"
    cidr_blocks = [var.ingress_cidr_blocks] # Ensure this is the private VPC CIDR
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "EMR_master"
  }
}

resource "aws_security_group" "emr_slave" {
  name                   = "${var.name} - EMR-slave"
  description            = "Security group for EMR slave."
  vpc_id                 = var.vpc_id
  revoke_rules_on_delete = true

  # Allow SSH access (restricted to VPC CIDR)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ingress_cidr_blocks] # Ensure this is the private VPC CIDR
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "EMR_slave"
  }
}
