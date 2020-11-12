# Desafio de Movimentação de Contas:

### Objetivo
Desenvolver uma aplicação em linha de comando em Ruby, que calcule o balanço da conta corrente dos clientes, esta aplicação deve receber como parâmetro dois arquivos csv, um com as contas e outro com as transacoes.

### Execução

A aplicação deve receber dois parâmetros na linha de comando: o nome do arquivo de contas e o nome do arquivo de transações. Ex: ./contas.csv transacoes.csv

### Entrada
Os arquivos de entrada devem estar em formato CSV, sem cabeçalho, sem aspas e com campos delimitados por vírgula.

```bash
Formatos (Não deve conter cabeçalho)

Arquivo de contas (conta / saldo inicial Ex ->)

45678, 10000
5678, 20000

Arquivo de transacoes(o valor da segunda coluna pode ser negativo ou positivo)

45678, -10000
5678, 20000
```

### Requisitos para execução:

```bash
Ruby >= 2.7.2
```

#### Gems utilizadas

- Activerecord - Utilizado como ORM
- sqlite3 - Banco de dados Sql lite
- standalone_migrations - Para facilitar o processo de geração das migrations.
- money ruby - Para retornar o valor para o usuário final em BRL.

#### Passos para execução do projeto

Efetuar o clone do repositório com o comando a seguir:

```bash
git clone https://github.com/garibeiro1993/account_movement_challenge
```

#### Apos efetuar o clone do repositório execute:

```ruby
# 1 - Acessar diretório da aplicação:

cd account_movement_challenge

# 2 - Executar o bundle para instalar as GEMS

bundle install

# 3 - Criar o banco e executar as migrations:

rake db:create
rake db:migrate

# 4 - executar a aplicação passando os dois arquivos como parametro.

ruby app/main.rb app/accounts.csv app/transactions.csv

# 5 - a aplicação deve retornar algo parecido com a saída a seguir:

Saldo final de R$-2,00 na conta 669
Saldo final de R$377,90 na conta 1098
Saldo final de R$130,52 na conta 2222
Saldo final de R$-4,00 na conta 2345

```

### Considerações finais:

Acredito ter cumprido todos os requisitos funcionais do sistema, foi um desafio muito bacana, trabalhar com ruby puro adicionando o active record foi algo que com certeza agregou muito e fugiu do que estava habituado, neste projeto utilizei o padrão de operation/services para criação das contas, transações e movimentações, isolando a criação dessas entidades, também utilizei um padrão de modules/namespaces para organizar a estrutura destas operations.

## License
[MIT](https://choosealicense.com/licenses/mit/)
