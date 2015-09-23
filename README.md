## Introduction

Application allows you to easly create Slack integrations.

## Technologies

##### Roda - http://roda.jeremyevans.net
##### Sequel - http://sequel.jeremyevans.net
##### Postgres
##### React
##### Bootstrap


## Setup

1. We use rvm in this project, so when you clone your repository you should have gemset created.
2. Setup .env file with values (some of them you need to obtain from slack integration - incoming/outcoming webhook):

  ```
DATABASE_URL
INCOMING_WEBHOOK
RESERVATION_CHANNEL
RACK_ENV
OUTGOING_TOKEN
  ```
3. gem install bundler
4. bundle
5. rake db:create
6. rake db:migrate
7. to run server: rackup

## Usage of the example reservation app
After you filled in proper env variables you need and added integrations on your slack panel, you can invoke the command from you slack channel (I recommend slash commands). 

Format of the text you type after slash command is: `DD/MM-HH-HH`

## Development
If you want to improve or add some integrations check issues or simply create one.

## Tests

`rspec spec`

## License

MIT
