resource "aws_codedeploy_deployment_group" "A002" {
  app_name               = "${aws_codedeploy_app.backend_codedeploy.name}"
  deployment_group_name  = "A002"
  service_role_arn       = "${local.code_deploy_role}"
  deployment_config_name = "CodeDeployDefault.LambdaAllAtOnce"

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "BLUE_GREEN"
  }
}

resource "aws_codedeploy_deployment_group" "A003" {
  app_name               = "${aws_codedeploy_app.backend_codedeploy.name}"
  deployment_group_name  = "A003"
  service_role_arn       = "${local.code_deploy_role}"
  deployment_config_name = "CodeDeployDefault.LambdaAllAtOnce"

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "BLUE_GREEN"
  }
}

resource "aws_codedeploy_deployment_group" "C001" {
  app_name               = "${aws_codedeploy_app.backend_codedeploy.name}"
  deployment_group_name  = "C001"
  service_role_arn       = "${local.code_deploy_role}"
  deployment_config_name = "CodeDeployDefault.LambdaAllAtOnce"

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "BLUE_GREEN"
  }
  # auto_rollback_configuration {
  #   enabled = true
  #   events  = ["DEPLOYMENT_STOP_ON_ALARM"]
  # }
  # alarm_configuration {
  #   alarms  = ["my-alarm-name"]
  #   enabled = true
  # }
}

resource "aws_codedeploy_deployment_group" "C002" {
  app_name               = "${aws_codedeploy_app.backend_codedeploy.name}"
  deployment_group_name  = "C002"
  service_role_arn       = "${local.code_deploy_role}"
  deployment_config_name = "CodeDeployDefault.LambdaAllAtOnce"

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "BLUE_GREEN"
  }
}

resource "aws_codedeploy_deployment_group" "C003" {
  app_name               = "${aws_codedeploy_app.backend_codedeploy.name}"
  deployment_group_name  = "C003"
  service_role_arn       = "${local.code_deploy_role}"
  deployment_config_name = "CodeDeployDefault.LambdaAllAtOnce"

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "BLUE_GREEN"
  }
}

resource "aws_codedeploy_deployment_group" "C004" {
  app_name               = "${aws_codedeploy_app.backend_codedeploy.name}"
  deployment_group_name  = "C004"
  service_role_arn       = "${local.code_deploy_role}"
  deployment_config_name = "CodeDeployDefault.LambdaAllAtOnce"

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "BLUE_GREEN"
  }
}

resource "aws_codedeploy_deployment_group" "C005" {
  app_name               = "${aws_codedeploy_app.backend_codedeploy.name}"
  deployment_group_name  = "C005"
  service_role_arn       = "${local.code_deploy_role}"
  deployment_config_name = "CodeDeployDefault.LambdaAllAtOnce"

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "BLUE_GREEN"
  }
}


resource "aws_codedeploy_deployment_group" "C006" {
  app_name               = "${aws_codedeploy_app.backend_codedeploy.name}"
  deployment_group_name  = "C006"
  service_role_arn       = "${local.code_deploy_role}"
  deployment_config_name = "CodeDeployDefault.LambdaAllAtOnce"

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "BLUE_GREEN"
  }
}


resource "aws_codedeploy_deployment_group" "C007" {
  app_name               = "${aws_codedeploy_app.backend_codedeploy.name}"
  deployment_group_name  = "C007"
  service_role_arn       = "${local.code_deploy_role}"
  deployment_config_name = "CodeDeployDefault.LambdaAllAtOnce"

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "BLUE_GREEN"
  }
}

resource "aws_codedeploy_deployment_group" "C008" {
  app_name               = "${aws_codedeploy_app.backend_codedeploy.name}"
  deployment_group_name  = "C008"
  service_role_arn       = "${local.code_deploy_role}"
  deployment_config_name = "CodeDeployDefault.LambdaAllAtOnce"

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "BLUE_GREEN"
  }
}

resource "aws_codedeploy_deployment_group" "D001" {
  app_name               = "${aws_codedeploy_app.backend_codedeploy.name}"
  deployment_group_name  = "D001"
  service_role_arn       = "${local.code_deploy_role}"
  deployment_config_name = "CodeDeployDefault.LambdaAllAtOnce"

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "BLUE_GREEN"
  }
}

resource "aws_codedeploy_deployment_group" "E001" {
  app_name               = "${aws_codedeploy_app.backend_codedeploy.name}"
  deployment_group_name  = "E001"
  service_role_arn       = "${local.code_deploy_role}"
  deployment_config_name = "CodeDeployDefault.LambdaAllAtOnce"

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "BLUE_GREEN"
  }
}
resource "aws_codedeploy_deployment_group" "S001" {
  app_name               = "${aws_codedeploy_app.backend_codedeploy.name}"
  deployment_group_name  = "S001"
  service_role_arn       = "${local.code_deploy_role}"
  deployment_config_name = "CodeDeployDefault.LambdaAllAtOnce"

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "BLUE_GREEN"
  }
}

resource "aws_codedeploy_deployment_group" "S002" {
  app_name               = "${aws_codedeploy_app.backend_codedeploy.name}"
  deployment_group_name  = "S002"
  service_role_arn       = "${local.code_deploy_role}"
  deployment_config_name = "CodeDeployDefault.LambdaAllAtOnce"

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "BLUE_GREEN"
  }
}
