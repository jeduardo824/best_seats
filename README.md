# Best Seats App

![Gif](https://media.giphy.com/media/SvokzrsLVjdr1mGZOd/giphy.gif)

- Dependecies:
1. PostgreSQL >= 9.3
2. Ruby 2.7.1
3. Yarn 1.22.4 (but it may work with other versions)

- Demo: [Demo](https://www.loom.com/share/052a91aea68b4342aeffe82e9e54dfcc)

## Setup Your Local Environment

*NOTE:* If you wish to setup the project with Docker,
please check [Docker usage](#docker-usage) section

1. First, you need to have Postgres >= 9.3 installed and running.
You can obtain more information about those steps [here](https://www.postgresql.org/docs/12/tutorial-install.html)
2. You also need to have Ruby 2.7.1 installed. You can accomplish this in many ways, but the most famous are: [rbenv](https://github.com/rbenv/rbenv), [rvm](https://rvm.io/) and [asdf](https://github.com/asdf-vm/asdf)
3. Yarn is also a requirement. You can install it checking the [official documentation](https://classic.yarnpkg.com/en/docs/install) or using [asdf](https://github.com/asdf-vm/asdf)
4. Now, clone the project:
    `git clone https://github.com/jeduardo824/best_seats`
5. Open a Terminal window inside the folder that you downloaded the project.
6. If you don't have `bundler` installed, please do with `gem install bundler`.
7. If you don't have `foreman` installed, please do with `gem install foreman`.
8. Run `bundle install` to install the necessary gems.
9. Run `yarn install` to install the necessary JS libraries.
10. After this, you can set up your local database with `bundle exec rails db:setup`.
11. You should be ready to run your local server with `foreman start -f Procfile.dev`.

## Docker Usage

1. Clone the project:
    `git clone https://github.com/jeduardo824/best_seats`
2. Open a Terminal window inside the folder that you downloaded the project.
2. You need to have Docker installed and running to use it.
3. Run `./setup_dev`
4. When the process finishes, `docker-compose up` should work to have your local environment running.

## Common Issues

1. Problems with Database:
    Inside `config`, check the file `database.yml` and ensure that configurations like host and port are accordingly with your Postgres
2. Problems with `./setup_dev`:
    Check if you have the permissions to run the script. You can do that with `chmod +x setup_dev`

## Heroku

1. The application is also hosted in Heroku if you don't want to install it locally.
   You can access it on: https://best-seats-app.herokuapp.com/

## Tests

You can run the tests with `bundle exec rspec`. If you are using Docker, you should run `docker-compose run --rm bundle exec rspec`. 

## API Documentation
### Create Venue
Request: `POST /api/v1/venues`  
Body:  
```json
{
    "venue": {
        "title": "My Title",
        "rows": 10,
        "columns": 50,
        "available_seats": [
            {
                "row": "a",
                "column": 1
            },
            {
                "row": "b",
                "column": 5
            },
            {
                "row": "h",
                "column": 7
            }
        ]
    }
}
```

Response:
```json
{
    "message": "Venue created successfully.",
    "venue_id": 34
}
```

Status: `201`

### Get Best Seats
Request: `GET /api/v1/venues/:venue_id/best_seats`  
Parameters:  
1. `seats_quantity`: Desired quantity of seats (Integer)
2. `group_seats`: If seats should be grouped or not (Boolean) 
  
Ex: `/api/v1/venues/34/best_seats?seats_quantity=2&group_seats=false`

Response:
```json
{
    "success": "The best seats available are: [\"A1\", \"B5\"]",
    "best_seats": [
        {
            "id": 216,
            "row": 1,
            "column": 1,
            "label": "A1",
            "venue_id": 34
        },
        {
            "id": 217,
            "row": 2,
            "column": 5,
            "label": "B5",
            "venue_id": 34
        }
    ]
}
```

Status: `200`
