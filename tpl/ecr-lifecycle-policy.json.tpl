{
  "rules": [
    {
      "rulePriority": 1,
      "description": "Keep image deployed with default tag '${image_tag}''",
      "selection": {
        "tagStatus": "tagged",
        "tagPrefixList": ["${image_tag}"],
        "countType": "imageCountMoreThan",
        "countNumber": 1
      },
      "action": {
        "type": "expire"
      }
    },
    {
      "rulePriority": 2,
      "description": "Keep last 2 any images",
      "selection": {
        "tagStatus": "any",
        "countType": "imageCountMoreThan",
        "countNumber": 2
      },
      "action": {
        "type": "expire"
      }
    }
  ]
}
