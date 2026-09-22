variable "environment" {
  description = "배포 환경 이름입니다."
  type        = string
  default     = "dev"
}

variable "name" {
  description = "백엔드 인프라 리소스에 사용할 기본 이름입니다."
  type        = string
  default     = "backend"
}

variable "tags" {
  description = "태그 또는 라벨을 지원하는 백엔드 리소스에 적용할 공통 메타데이터입니다."
  type        = map(string)
  default     = {}
}
