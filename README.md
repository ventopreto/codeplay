# Codeplay

## Sobre o projeto
Codeplay é um sistema de gestão de aulas e cursos. No seu estado atual, o projeto conta apenas com algumas funcionalidades básicas:
## Requisitos Necessários:

* Ruby 3.0.1
* Rails 6.1.3.2
* Yarn

### Gems adicionais
<ul>
  <li>Testes</li>
  <ul>
    <li>Rspec</li>
    <li>Capybara</li>
    <li>Shouda Matchers</li>
  </ul>
</ul>
<ul>
  <li>Autenticação/Autorização</li>
  <ul>
    <li>Devise</li>
  </ul>
</ul>

## Funcionalidades
### Usuários administradores
* Administrador autenticado pode cadastrar professores, cursos e aulas
* Administrador autenticado pode deletar professores, cursos e aulas
* Administrador autenticado pode editar professores, cursos e aulas
* Visitantes podem visualizar cursos na página inicial e detalhes de uma aula;
* Usuários autenticados podem comprar cursos.

### visitantes
* Podem ver cursos disponiveis
* Registrar-se
* Logar
* 
### Estudantes
* Comprar cursos
* Ver cursos e aulas

## Para executar o projeto:
* Clone em sua máquina

```shell
git clone git@github.com:ventopreto/codeplay.git
```

### Instale as dependências
```shell
cd codeplay
bin/setup
```
Atente-se que o comando bin/setup vai executar o comando yarn install.

### Configure o Banco de Dados
Realize a criação de dados preexistentes no banco de dados com o comando
```shell
rails db:seed
```

### Execute a aplicação
```shell
rails s
```
### Acesse
```shell
http://localhost:3000
```

### Demais observações
* Usuários administradores só podem ser cadastrados via console.
Para logar com um usuário administrador pré-cadastrado acesse ```http://localhost:3000/user/sign_in``` e faça login na aplicação com o email e senha abaixo:
```
email: admin@mercadores.com.br, senha: 123456
```
* Professores podem ser cadastrados normalmente via homepage

* Também é possível cadastrar estudantes via homepage ```http://127.0.0.1:3000/students/sign_up```
```
email: employee1@corpname.com.br, senha: 123456
```

## API

### Lista de opções de frete
#### get '/api/v1/courses'

* Retorna uma lista de cursos:
#### Possíveis respostas
* HTTP Status: 200
Exemplo:
```
[
  {
    "name": "Curso de Ruby",
    "description": "Curso basico de rails",
    "code": "ruby-2020",
    "price": "300.0",
    "enrollment_deadline": "2020-09-30",
    "status": "Publicado",
    "instructor": {
      "id": 1,
      "name": "Gustavo Guanabara",
      "email": "guanabara@codeplay.com",
      "bio": "Akshashk",
      "created_at": "2020-09-30T20:55:42.002Z",
      "updated_at": "2020-09-30T20:55:42.002Z"
    }
  }
]
```

### show
#### get '/api/v1/courses/ruby-2020'

* Retorna um cursos especifico:
#### Possíveis respostas
* HTTP Status: 200
Exemplo:
```
{
  "id": 1,
  "name": "Curso de Ruby",
  "description": "Curso basico de rails",
  "code": "ruby-2020",
  "price": "300.0",
  "enrollment_deadline": "2020-09-30",
  "created_at": "2020-09-30T20:56:17.076Z",
  "updated_at": "2020-09-30T20:56:17.076Z",
  "instructor_id": 1,
  "status": "Publicado"
}


