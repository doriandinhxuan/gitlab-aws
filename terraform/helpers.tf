module "secrets" {
  source = "../tf.modules/terraform-aws-secrets-manager"
  secret_arn = "${var.secrets_arn}"
}

module "rds_secret" {
  source = "../tf.modules/terraform-aws-secrets-manager"
  secret_arn = "${var.rds_secret_arn}"
}

data "template_file" "authorized_keys" {
  template = "${file("templates/authorized_keys.sh.tpl")}"

  vars {
    ssh_keypair_id_rsa_pub = "${base64decode(lookup(module.secrets.secret, "public"))}"
  }
}

data "template_file" "bastion_ssh_keys" {
  template = "${file("templates/bastion_ssh_keys.sh.tpl")}"

  vars {
    # values in secret namager are base64 encoded
    ssh_keypair_id_rsa_pub = "${lookup(module.secrets.secret, "public")}"
    ssh_keypair_id_rsa     = "${lookup(module.secrets.secret, "private")}"
  }
}

data "template_file" "gitlab_install" {
  template = "${file("scripts/gitlab/gitlab-ansible-install.sh.tpl")}"

  vars {
    stage                = "${var.stage}"
    name                 = "${var.name}"
    gitlab_hostname      = "${var.gitlab_hostname}"
    gitlab_db_user       = "${lookup(module.secrets.secret, "gitlab_db_user")}"
    gitlab_db_pass       = "${lookup(module.secrets.secret, "gitlab_db_pass")}"
    gitlab_db_endpoint   = "${module.gitlab_db.instance_address}"
  }
}

data "template_file" "gitlab_runner_install" {
  template = "${file("scripts/gitlab/gitlab-runner.sh.tpl")}"

  vars {
    ssh_keypair_id_rsa_pub = "${base64decode(lookup(module.secrets.secret, "public"))}"
    stage                  = "${var.stage}"
    name                   = "${var.name}"
    runners_executor       = "docker"
    runners_name           = "${var.name}-runner"
    runners_gitlab_url     = "https://${var.gitlab_hostname}.${var.stage}.${var.domain_name}/"
    registration_token     = "${lookup(module.secrets.secret, "registration_token")}"
  }
}

resource "aws_iam_instance_profile" "gitlab_runner_instance_profile" {
  name = "Gitlab_Runner_FullAccess_Instance_Profile"
  role = "${aws_iam_role.GitlabRunner_FullAccess_Role.name}"
}

resource "aws_iam_role" "GitlabRunner_FullAccess_Role" {
  name = "GitlabRunner_FullAccess_Role_${var.stage}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "gitlab_runnerfull_access" {
  role       = "${aws_iam_role.GitlabRunner_FullAccess_Role.name}"
  policy_arn = "${var.gitlab_runner_instance_role}"
}

resource "aws_ecr_repository" "ecr" {
  name = "${var.name}-runner-image"

  tags = "${
    merge(
      map(
        "Name", "${format("${var.name}-runner-image")}",
        "Environment", "${format("%s", var.stage)}"
          ),
        var.tags
        )
      }"
}

data "aws_route53_zone" "default" {
  name         = "${var.domain_name}"
  private_zone = false
}
