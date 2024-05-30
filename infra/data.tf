# The attribute `${data.aws_caller_identity.current.account_id}` will be current account number.
data "aws_caller_identity" "current" {}

# The attribute `${data.aws_region.current.name}` will be current region
data "aws_region" "current" {}