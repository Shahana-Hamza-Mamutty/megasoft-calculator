# README

The app consists of one Home page with calculator, one admin page to fetch reports and one API for mathematical operations. Its deployed in heroku and is accessible via https://megasoft-calc.herokuapp.com/. Please follow the steps to setup via docker. Please dont forget to edit the application.yml.example as application.yml and add config variables. In case running in docker DB_USERNAME, DB_PASSWORD and DB_NAME are not necessary. Home page url - https://megasoft-calc.herokuapp.com/, Admin url - https://megasoft-calc.herokuapp.com/megasoft/admin, Calculate API - https://megasoft-calc.herokuapp.com/megasoft/api/v1/calculator/calculate.

To Setup the file in local:

* Install docker

* Clone or download the code from repo.

* Change application.yml.example file to application.yml file. Location of this file root_folder/config/application.yml.

* Run `docker-compose build` from root directory

* Run `docker-compose up`

* Run `docker-compose run app rake db:create db:migrate`

* Run `docker-compose run app rake db:seed`

* You can now access the application in `localhost:3000`

* For test cases set up test db by, Run `docker-compose run -e "RAILS_ENV=test" app rake db:create db:migrate`

* To run test cases, `docker-compose run app bundle exec rspec`

## API
Used for evaluating an operation with two inputs. Inputs are passed as comma separated string. A sample of request body to calculate sum of 2 and 3 is as follow. The api is `/megasoft/api/v1/calculator/calculate`. 

Request Body

```json
{
  "input": "2,3",
  "operator": "+"
}
```
Request Headers

```sh
Content-Type: application/json
Authorization: Token token=7381a978f7dd7f9a1117
```

Different operators available are:

```json
{
  "add": "+",
  "subtract": "-",
  "multiply": "*",
  "divide": "/",
  "cuberoot": "cbrt",
  "square_root": "sqrt",
  "factorial": "!",
  "power": "^"
}
```
