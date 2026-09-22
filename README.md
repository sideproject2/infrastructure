# Infrastructure

클라우드 인프라를 Terraform으로 관리하기 위한 저장소입니다.

현재는 AWS 또는 GCP 선택 전 단계이므로, 특정 클라우드에 종속되지 않는 환경 구조와 협업 규칙만 구성되어 있습니다.

## 제공 항목

- 개발 및 운영 환경의 프론트엔드·백엔드별 Terraform root module
- 서비스별 변수와 `terraform.tfvars.example`
- Terraform 포맷 및 검증을 위한 GitHub Actions workflow
- 재사용 모듈을 추가하기 위한 `modules/`
- Issue, Pull Request, Commit 및 Branch 협업 문서

## 구조

```text
.
├── .github/
│   └── workflows/
│       └── terraform-check.yml
├── environments/
│   ├── dev/
│   │   ├── frontend/
│   │   └── backend/
│   └── prod/
│       ├── frontend/
│       └── backend/
├── modules/
├── docs/
├── scripts/
├── .gitignore
├── README.md
└── versions.tf
```

각 `environments/{환경}/{서비스}` 디렉터리는 독립적인 Terraform root module입니다. 따라서 provider와 backend를 선택한 뒤에도 프론트엔드와 백엔드를 분리해 초기화하고 plan을 실행합니다.

## 로컬 검증

저장소 루트에서 다음 명령을 실행합니다.

```powershell
terraform fmt -check -recursive

terraform -chdir=environments/dev/frontend init -backend=false
terraform -chdir=environments/dev/frontend validate

terraform -chdir=environments/dev/backend init -backend=false
terraform -chdir=environments/dev/backend validate

terraform -chdir=environments/prod/frontend init -backend=false
terraform -chdir=environments/prod/frontend validate

terraform -chdir=environments/prod/backend init -backend=false
terraform -chdir=environments/prod/backend validate
```

## 환경 변수 적용

예시 파일을 복사한 뒤 환경에 맞는 값을 입력합니다.

```powershell
Copy-Item environments/dev/frontend/terraform.tfvars.example environments/dev/frontend/terraform.tfvars
Copy-Item environments/dev/backend/terraform.tfvars.example environments/dev/backend/terraform.tfvars
Copy-Item environments/prod/frontend/terraform.tfvars.example environments/prod/frontend/terraform.tfvars
Copy-Item environments/prod/backend/terraform.tfvars.example environments/prod/backend/terraform.tfvars
```

`terraform.tfvars`, Terraform state 파일, 인증 정보는 저장소에 커밋하지 않습니다.

## GitHub Actions

[Terraform Check](.github/workflows/terraform-check.yml)는 다음 작업을 자동으로 수행합니다.

- 전체 Terraform 파일 포맷 검사
- `dev/frontend` 환경 초기화 및 검증
- `dev/backend` 환경 초기화 및 검증
- `prod/frontend` 환경 초기화 및 검증
- `prod/backend` 환경 초기화 및 검증

## 문서

프로젝트 협업 정책은 `docs/`에서 확인할 수 있습니다.

- [Convention](docs/CONVENTION.md)
- [Workflow](docs/WORKFLOW.md)
- [Labels](docs/LABELS.md)

## 다음 단계

클라우드 플랫폼이 결정되면 다음 순서로 확장합니다.

1. 각 환경에 provider와 backend 추가
2. 원격 state 저장소 설정
3. 클라우드 리소스별 모듈 추가
4. `plan` 및 `apply` 권한과 배포 workflow 분리
