resource "aws_ecr_repository" "ecr-demo" {
  name = "samplerepo"
}

# resource "aws_ecr_lifecycle_policy" "ecr_policy" {
#   repository = aws_ecr_repository.ecr-demo.name
#   policy     = local.ecr_policy
# }

# #This is the policy defining the rules for images in the repo
# locals {
#   ecr_policy = jsonencode({
#     "rules" : [
#       {
#         "rulePriority" : 1,
#         "description" : "Expire images older than 14 days",
#         "selection" : {
#           "tagStatus" : "any",
#           "countType" : "sinceImagePushed",
#           "countUnit" : "days",
#           "countNumber" : 14
#         },
#         "action" : {
#           "type" : "expire"
#         }
#       }
#     ]
#   })
# }
