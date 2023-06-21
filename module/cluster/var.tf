
variable "region" {
  default = "us-east-1"
}
variable "vpc_cidr_block" {
  default = "10.10.0.0/16"
}
variable "azs_count" {
  default = 2
}

variable "asg_min" {
  default = 1
}
variable "asg_max" {
  default = 2
}
variable "asg_desired" {
  default = 1
}
variable "clu" {
  type    = "list"
  default = ["user", "user1", "user2"]
}
variable "json" {
  type = "list"
  default = ["event","finance","user"]
}
variable "lb-port" {
  type = "list"
  default = ["8080","8081","8082"]
}
variable "nl" {
type="list"
}
variable "lb-name" {
  type = "list"
  default =["hellotom","hellotom","hellotom"]
}
variable "task" {
  type = "list"
  default = ["user-task","fin-task","event-task"]
}
variable "cpu" {
  type = "list"
  default = ["512","512","512"]
}
variable "memory" {
  type = "list"
  default = [
    "1024",
    "1024",
    "1024"]
}
variable "ecs_logs" {
  default = ""
}