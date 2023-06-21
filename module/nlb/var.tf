variable "subnet-id" {
  default = "subnet-7822c80e"
}
variable "sg-nlb" {
  default = "sg-0170d5affdddc9f21"
}
  variable "vpc-id"{
    default = "vpc-6052e104"
  }
variable "nlb-m" {
  type = "list"
  default = ["8080","8081","8082",]
}
variable "nlm-mm" {
  type = "list"
  default = ["80","82","83"]
}