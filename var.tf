variable "cluster-name" {
  type    = list(string)
  default = ["user", "user1", "user2"]
}
variable "json" {
  type    = list(string)
  default = ["event", "finance", "user"]
}
variable "lb-port" {
  type    = list(string)
  default = ["8080", "8081", "8082"]
}

variable "lb-name" {
  type    = list(string)
  default = ["hellotom", "hellotom", "hellotom"]
}
variable "task" {
  type    = list(string)
  default = ["user-task", "fin-task", "event-task"]
}
variable "cpu" {
  type    = list(string)
  default = ["512", "512", "512"]
}
variable "memory" {
  type = list(string)
  default = [
    "1024",
    "1024",
  "1024"]
}

variable "subnet-id" {
  default = "subnet-7822c80e"
}

variable "sg-nlb" {
  default = "sg-faac1c9c"
}
variable "vpc-id" {
  default = "vpc-6052e104"
}
variable "nlb-m" {
  type    = list(string)
  default = ["8080", "8081", "8082", ]
}
variable "nlm-mm" {
  type    = list(string)
  default = ["80", "82", "83"]
}
variable "days" {
  default = 7
}
variable "engine" {
  default = "aurora-postgresql"
}
variable "db_name" {
  default = "kishore"
}

variable "username" {
  default = "Ebizoncloud"
}
variable "password" {
  default = "pvkishore"
}
variable "available_az" {
  type    = list(string)
  default = ["us-east-1d", "us-east-1b"]
}
variable "sg-id" {
  default = "sg-08605275a29dab0fe"
}
variable "value" {
  default = "192.0.3.233"
}
variable "hosted_zone" {
  default = "kishorepvk.tk"
}
variable "records" {
  default = "https://www.kishorepvk.tk"
}
variable "bucket" {
  default = "kishorepvk"
}
variable "routetable" {
  default = "rtb-62b5d606"
}
variable "s3-bucket" {
  default = "pvkbuckettf"
}

variable "db_subnet" {
  type    = list(string)
  default = ["subnet-79b88452", "subnet-48050911"]
}
