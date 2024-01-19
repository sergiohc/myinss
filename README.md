# Cálculo do INSS para 2024

Este projeto fornece meios para calcular o desconto do INSS

## Exemplo de Cálculo

1. **Primeira faixa salarial:** Para salários até R$1.412,00, a alíquota do INSS é de 7,5%. Portanto, o desconto do INSS para essa faixa é de R$1.412,00 x 0,075 = R$ 105,90.

2. **Segunda faixa salarial:** Para a parcela do salário que vai de R$1.412,01 até R$2.666,68, a alíquota do INSS é de 9%. Portanto, o desconto do INSS para essa faixa é de (R$2.666,68 – R$1.412,00) x 0,09 = R$ 112,92.

3. **Terceira faixa salarial:** Para a parcela do salário que vai de R$2.666,69 até R$3.000,00, a alíquota do INSS é de 12%. Portanto, o desconto do INSS para essa faixa é de (R$3.000,00 – R$2.666,68) x 0,12 = R$ 39,99.

**Somando os descontos de todas as faixas salariais, o total do INSS a recolher é de** R$ 105,90 + R$ 112,92 + R$ 39,99 = R$ 258,81.

## Este app usa Docker, caso não o tenha siga ...

Você precisará ter o [Docker instalado](https://docs.docker.com/get-docker/).
Ele está disponível no Windows, macOS e na maioria das distribuições do Linux. Se você é novo no
Docker e quer aprender em detalhes, confira os [links de recursos adicionais](#aprenda-mais-sobre-docker-e-ruby-on-rails) perto do final deste
README.

Você também precisará habilitar o suporte ao Docker Compose v2 se estiver usando o Docker
Desktop. No Linux nativo sem o Docker Desktop, você pode [instalá-lo como um plugin
do Docker](https://docs.docker.com/compose/install/linux/). Ele está geralmente
disponível há algum tempo e é estável. Este projeto usa específicos [Docker Compose v2 recursos](https://nickjanetakis.com/blog/optional-depends-on-with-docker-compose-v2-20-2)
que só funcionam com o Docker Compose v2 2.20.2+.

Se você estiver usando o Windows, espera-se que você esteja seguindo dentro
do [WSL ou WSL2](https://nickjanetakis.com/blog/a-linux-dev-environment-on-windows-with-wsl-2-docker-desktop-and-more).
Isso porque vamos executar comandos shell. Você sempre pode modificar
esses comandos para o PowerShell, se quiser.


#### Clone este repositório em qualquer lugar que desejar:

```sh
git clone git@github.com:sergiohc/myinss.git
cd myinss
```

#### Copie o arquivo .env de exemplo:

```sh
cp .env.example .env
```

## Configuração do Projeto

1. Construa e inicie os serviços do Docker:

```bash
docker compose up --build
```

2. Em outro terminal, execute o seguinte comando para configurar o banco de dados:

```bash
./run db:setup
```

3. Acesse a aplicação em seu navegador:

```
http://localhost:3000/
```

## Executando Testes

Para executar os testes, siga os passos abaixo:

1. Inicie os serviços do Docker, se ainda não estiverem em execução:

```bash
docker compose up
```

2. Em outro terminal, execute os testes com o seguinte comando:

```bash
./run rspec:test
```

Você também pode executar um teste específico, por exemplo:

```bash
./run rspec:test spec/sidekiq/update_salary_job_spec.rb
```

Comandos completos podem ser usados normalmente, por exemplo:

```bash
docker compose run --rm web bundle exec rspec
```

## Depuração

Para depuração em tempo real, use `binding.remote_pry` e em outra aba execute `./run shell` seguido de `pry-remote`.

## Meus contatos
```bash
Telephone: (41) 99825-4341 - preferência para whatsapp
E-mail: sergioh.c@live.com
linkedin: https://www.linkedin.com/in/sergiohc/
```
