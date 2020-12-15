resource "aws_iam_role" "web_service_task_role" {
  name = "web-service-ecs-task-role"
 
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [{
    "Action": "sts:AssumeRole",
    "Principal": {
      "Service": "ecs-tasks.amazonaws.com"
    },
    "Effect": "Allow",
    "Sid": ""
  }]
}
EOF
}
 
resource "aws_iam_policy" "web_service" {
  name        = "web-service-task-policy"
  description = "Policy that controls IAM permissions for the task"
 
 policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
        "Effect": "Allow",
        "Action": [
            "s3:ListAllMyBuckets",
            "s3:GetBucketLocation"
        ],
        "Resource": "*"
    }
  ]
}
EOF
}
 
resource "aws_iam_role_policy_attachment" "web-service-task-role-policy-attachment" {
  role       = aws_iam_role.web_service_task_role.name
  policy_arn = aws_iam_policy.web_service.arn
}

resource "aws_iam_role" "web_service_task_execution_role" {
  name = "web-service-ecs-task-execution-role"
 
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [{
    "Action": "sts:AssumeRole",
    "Principal": {
      "Service": "ecs-tasks.amazonaws.com"
    },
    "Effect": "Allow",
    "Sid": ""
  }]
}
EOF
}
 
resource "aws_iam_role_policy_attachment" "web-service-task-execution-role-policy-attachment" {
  role       = aws_iam_role.web_service_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
