![](https://www.estudar.org.br/wp-content/themes/fundacao-estudar-2/images/logo-header.png)

#### Bem-vindo à aplicação de teste

Agradeço tanto a oportunidade de participar do processo seletivo como de aprender com o desafio.
A aplicação está diposnível também no [Heroku](https://pure-forest-53924.herokuapp.com)*

*Ainda com problemas no redis :\

#### Environment
```
Docker version 19.03.12
docker-compose version 1.25.5

OU

Rails Version: 5.2.1
Ruby Version: 2.5.3
Mysql version: 5.7 or higher
Redis version: 4.0 or higher
```

#### Setup
No arquivo .env coloque uma senha para o banco na variável `DB_PASSWORD`.

Em seguida execute:
```
docker-compose up
```

Depois de iniciado, crie o banco e execute as migrações com:
```
 docker-compose run web bash -c 'bin/setup'
 docker-compose run web bash -c 'rails db:migrate'
```

Agora acesse [localhost:3000](localhost:3000)

