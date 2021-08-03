{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "kms",
      "Effect": "Allow",
      "Action": [
        "kms:Decrypt"
      ],
      "Resource": [
        "${kms_key_arn}"
      ]
    }
  ]
}
