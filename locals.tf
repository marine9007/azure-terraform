locals {
  suffix = random_string.suffix.result
  common_tags = merge(
    var.tags,
    {
      Environment = var.environment
      Location    = var.location
    }
  )
}

