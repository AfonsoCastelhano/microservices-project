resource "aws_sqs_queue" "product_events_dlq" {
  name = "afonso-product-events-dlq"
}

resource "aws_sqs_queue" "product_events" {
  name                      = "afonso-product-events"
  visibility_timeout_seconds = 60
  receive_wait_time_seconds  = 20

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.product_events_dlq.arn
    maxReceiveCount     = 5
  })
}
