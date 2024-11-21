# EMR general configurations
name = "spark-app"
region = "us-east-2"
subnet_id = "subnet-014fb48d5a6dee138"
vpc_id = "vpc-0bf8ec87da34f0492"
key_name = "emr-cluster"
ingress_cidr_blocks = "10.0.0.0/16"
release_label = "emr-7.5.0"
applications = ["Spark","Hadoop","JupyterEnterpriseGateway"]

# Master node configurations
master_instance_type = "m5.xlarge"
master_ebs_size = "64"

# Slave nodes configurations
core_instance_type = "m5.xlarge"
core_instance_count = 2
core_ebs_size = "64"


access_key="AKIA3FLD4HIR2V6N4DV2"
secret_key="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"

log_path = ""
bootstrap_path = ""