# API

## Stack & Features

* Ruby 3.1.1
* Rails 7.0.3
* API mode
* Postgres
* Puma
* Handling CORS
* RSpec testing framework
* Redis
* Sidekiq
* Swagger

## Getting Started

```bash
git clone git@gitlab.codica.com:developer-cheats/backend/awesome-api.git my-api
```

Ask the teach lead for the `master.key`

```bash
docker-compose up --build
```

## Links

|Name|Link|
|---|---|
|API (Rails)|http://localhost:3000|
|Admin Panel|http://localhost:3000/admin|
|API Documentation|http://localhost:3000/api-docs/index.html|
|Sidekiq Dashboard|http://localhost:3000/admin/sidekiq|
|Show Emails|http://localhost:3000/letter_opener|
|Preview Emails|http://localhost:3000/rails/mailers|

## Commands

`script/backend` - start development environment and attach to backend

`yarn docker:status` - show status of running containers

`yarn build` - build project

`yarn up` - start development environment (you can use `-d` option for silence mode)

`yarn stop` - stop containers

`yarn down` - down containers

`yarn docker:exec <command>` - execute command inside container

`yarn bash` - go inside the container to execute commands

`yarn c` - run Ruby console inside the container

`yarn routes` - show all routes (you can find all matches `yarn routes | grep <resource_name>`)

`yarn g:migration <migration_name>` - generate migration

`yarn db:migrate` - run migrations

`yarn db:rollback` - run migration rollback

`yarn db:seed` - run seeds

`yarn db:reset` - run reset the database (drop, create, migrate, seed)

`yarn annotate` - run Annotate models and serializers

`yarn docs` - run Swagger docs generating

`yarn rspec` - run Rspec

`yarn rubocop` - run Rubocop (you can use `-a` option to fix some issues)

`yarn audit` - run bundle-audit

`yarn brakeman` - run Brakeman

`yarn linters` - run all tests (rspec, rubocop, audit, brakeman)

## Credantials

```
docker-compose exec backend rails credentials:edit
```

```
docker-compose exec backend rails credentials:edit --environment staging
```

```
docker-compose exec backend rails credentials:edit --environment production
```

```
docker-compose exec backend rails credentials:edit --environment development
```

```
docker-compose exec backend rails credentials:edit --environment test
```
