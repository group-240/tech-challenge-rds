# Tech Challenge - RDS

Repositório responsável pelo banco de dados PostgreSQL na AWS.

## O que este repositório cria

- **RDS PostgreSQL** - Banco de dados relacional.
- **Security Group** - Regras de firewall para o banco.

## Dependências

| Dependência | Descrição |
|-------------|-----------|
| tech-challenge-infra | VPC e Subnets (via remote state) |
| Terraform >= 1.10.0 | Ferramenta de IaC |

## Secrets Necessários (GitHub)
- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `AWS_SESSION_TOKEN` (obrigatório para AWS Academy Learner Lab)
- `DB_USERNAME` - Usuário do PostgreSQL
- `DB_PASSWORD` - Senha do PostgreSQL

## Outputs

Este repositório exporta outputs usados por outros repositórios:
- RDS Endpoint
- RDS Port
- Database Name
