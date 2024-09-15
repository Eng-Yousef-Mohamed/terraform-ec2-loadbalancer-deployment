
resource "aws_lb" "aws_lb" {
  name            = "lb-${var.Name}"
  internal        = false
  load_balancer_type = "application"
  security_groups = [var.security_group_id] #list
  subnets         = var.subnet_ids #list 
}

resource "aws_lb_listener" "aws_lb_listener" {
  load_balancer_arn = aws_lb.aws_lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

resource "aws_lb_target_group" "tg" {
  name     = "tg-${var.Name}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "instance"

}

# attach EC2 instances to a target group in an AWS Application Load Balancer (ALB)
resource "aws_lb_target_group_attachment" "target_group_attachment" {
  count = length(var.ec2_ids)
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = var.ec2_ids[count.index]
  port             = 80
}

