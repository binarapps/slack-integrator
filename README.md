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
TEST_DATABASE_URL
RESERVATION_INCOMING_WEBHOOK
RESERVATION_CHANNEL
RACK_ENV
RESERVATION_OUTGOING_TOKEN
  ```
3. gem install bundler
4. bundle
5. rake db:create
6. rake db:migrate
7. Application can use users whitelisting. Create `authorized_users.yml` in `configurations` folder and list users which should be whitelisted for registration. Uncomment proper line in `register_user.rb`.
8. to run server: rackup

## Usage of the example reservation app
After you filled in proper env variables you need and added integrations on your slack panel, you can invoke the command from you slack channel (I recommend slash commands).

Format of the text you type after slash command is: `DD/MM-HH-HH`

## Development
If you want to improve or add some integrations check issues or simply create one.

## New slack integration
Application structure has been prepared to easly add new integrations.

1. Create `your_integration_name.rb` file in `apps` folder.
2. Create a service witch your funcionality in `services` folder.
3. If you need to create a model for some object create it in `models` folder, create a migration and add it to `models.rb` file.
4. Create slack configuration in `configurations` folder.
5. Initialize a bot in `roda-app.rb` with `opts[:your_bot_name] = Slackbotsy::Bot.new(YOUR_CONFIG)`
6. You can now use this bot to post message with `PostToSlack.say(:your_bot_name, message)`

## Food integration
1. Create file 'places.yml'
2. Add there your restaurants. Schema:
  name:
    full_name: ''
    phone: '
    schema: ''
    menu: ''
  Where name is a word called in slack to order from that place
3. Run rake places:create

## Tests
`rake db:create RACK_ENV=test`
`rake db:migrate RACK_ENV=test`
`rspec spec`

## License

MIT
