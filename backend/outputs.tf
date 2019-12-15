output "api_id" {
  value = module.api.id
}
output "api_domain_name" {
  value = aws_acm_certificate.api.domain_name
}
output "api_execution_arn" {
  value = module.api.execution_arn
}
output "api_invoke_url" {
  value = module.deployment.invoke_url
}
output "api_stage_id" {
  value = module.deployment.stage_id
}
output "rule_target_arn" {
  value = {
    m002: aws_cloudwatch_event_target.codebuild.arn
    m003: aws_cloudwatch_event_target.codepipeline.arn
  }
}