
# Projeto  Cinema📝

## Descrição

Projeto de CRUD utilizando a arquitetura MVC, com Flutter sendo a View e uma API Rest em Nest contendo Models, Controllers e uma camada adicional de Services onde estão as regras de negócio.

### Funcionalidades:

-   O usuário pode criar um novo filme informando o nome do filme, a classificação, o tipo, a duração e a sala;
-   O usuário pode fazer o upload de uma foto e adicionar no filme, como cartaz;
-   O usuário editar o filme criado;    
-   O usuário excluir o filme;      

_**Com o filme criado, é possível:**_

-   _Listar todos os filmes;_
-   _Criar sessões em cada filme, inserindo a data e o horário da sessão;

## Tecnologias usadas

Front-end:

> Desenvolvido usando: Flutter, Material.

Back-end:

> Desenvolvido usando: Nest, Postgress.


## Instalando Dependências

> Backend cd src api-ab

```npm install
Configure o .env seguindo o modelo do arquivo .env.example

```

> Frontend cd src/webapp

```
npm install

```

## Executando a aplicação

> Backend

```
npm run start:dev

```

> Frontend

```

npm run start

