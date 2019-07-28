# -----------------------------------------------
# Dynamodb Random Id
# -----------------------------------------------
resource "random_id" "dynamodb" {
  byte_length = 2
}

# -----------------------------------------------
# Dynamodb Table - Users
# -----------------------------------------------
resource "aws_dynamodb_table" "users" {
  name           = "${local.dynamodb_name_users}"
  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "id"
  attribute {
    name = "id"
    type = "S"
  }

  lifecycle {
    prevent_destroy = true
  }
}

# -----------------------------------------------
# Dynamodb Table - GroupWords
# -----------------------------------------------
resource "aws_dynamodb_table" "group_words" {
  name           = "${local.dynamodb_name_groupwords}"
  billing_mode   = "PROVISIONED"
  read_capacity  = 3
  write_capacity = 1
  hash_key       = "id"
  range_key      = "word"
  # stream_enabled   = true
  # stream_view_type = "NEW_AND_OLD_IMAGES"

  attribute {
    name = "id"
    type = "S"
  }

  attribute {
    name = "word"
    type = "S"
  }
  attribute {
    name = "nextTime"
    type = "S"
  }
  attribute {
    name = "lastTime"
    type = "S"
  }

  local_secondary_index {
    name               = "lsiIdx1"
    range_key          = "nextTime"
    projection_type    = "INCLUDE"
    non_key_attributes = ["times"]
  }

  local_secondary_index {
    name            = "lsiIdx2"
    range_key       = "lastTime"
    projection_type = "KEYS_ONLY"
  }

  server_side_encryption {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }
}

# -----------------------------------------------
# Dynamodb Table - UserGroups
# -----------------------------------------------
resource "aws_dynamodb_table" "user_groups" {
  name           = "${local.dynamodb_name_userGroups}"
  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "userId"
  range_key      = "groupId"
  attribute {
    name = "userId"
    type = "S"
  }
  attribute {
    name = "groupId"
    type = "S"
  }

  global_secondary_index {
    name               = "gsiIdx1"
    hash_key           = "groupId"
    write_capacity     = 1
    read_capacity      = 1
    projection_type    = "INCLUDE"
    non_key_attributes = ["userId"]
  }
}

resource "aws_dynamodb_table" "words" {
  name           = "${local.dynamodb_name_words}"
  billing_mode   = "PROVISIONED"
  read_capacity  = 3
  write_capacity = 1
  hash_key       = "word"

  attribute {
    name = "word"
    type = "S"
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_dynamodb_table" "history" {
  name           = "${local.dynamodb_name_history}"
  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "userId"
  range_key      = "timestamp"
  attribute {
    name = "userId"
    type = "S"
  }
  attribute {
    name = "timestamp"
    type = "S"
  }
}
