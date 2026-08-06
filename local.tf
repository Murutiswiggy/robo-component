locals {
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  ami_id = data.aws_ami.redhat_ami.id
  sg_id = data.aws_ssm_parameter.sg_id.value
  backend_alb_listener_arn = data.aws_ssm_parameter.backend_alb_listener_arn.value
  frontend_alb_listener_arn = data.aws_ssm_parameter.frontend_alb_listener_arn.value

  aws_lb_listener_rule = var.component == "frontend" ? local.backend_alb_listener_arn : local.frontend_alb_listener_arn

    common_name = "${var.project}-${var.environment}-${var.component}"
    private_sub_id = split("," , data.aws_ssm_parameter.private_sub_ids.value)[0]
    common_tags = {
        project = "${var.project}"
        environment = "${var.environment}"
        terraform = true
    }
}
