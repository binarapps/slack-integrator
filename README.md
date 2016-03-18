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
PULL_REQUEST_CHANNEL
PULL_REQUEST_INCOMING_WEBHOOK
PULL_REQUEST_OUTGOING_TOKEN
GITHUB_TOKEN - token from some 'master' user on the github
REPOSITORY_URL - example: `https://github.com/`
  ```
3. gem install bundler
4. bundle
5. rake db:create
6. rake db:migrate
7. Application can use users whitelisting. Create `authorized_users.yml` in `configurations` folder and list users which should be whitelisted for registration. Uncomment proper line in `register_user.rb`.
8. to run server: rackup

## Usage of the example reservation app
After you filled in proper env variables you need and added integrations on your slack panel, you can invoke the command from you slack channel (I used slash commands).

Format of the text you type after slash command is: `DD/MM-HH-HH`

## Usage of the pull request automatic assigment
First of all you need to fill in proper `.env` variables and choose the channel you want to add integration to. On the slack side you need to setup `incoming webhook` and `slash commands` - as outgoing token.
Also rememmber that you have to provide `GITHUB_TOKEN`. It is the alpha version of the integration, so it should be changed later to more generic way of authorization.
Pull request will be assigned to each user that will register in the system.

Usage of the integration: `/your_slash_command_from_slack <url_to_the_pull_request>`

## Development
If you want to improve or add some integrations check issues or simply create one.

## New slack integration
Application structure has been prepared to easly add new integrations.

1. Create `your_integration_name.rb` file in `apps` folder.
2. Create a service witch your funcionality in `services` folder.
3. If you need to create a model for some object create it in `models` folder, create a migration and add it to `models.rb` file.
4. Create slack configuration in `configurations` folder.
5. Initialize a bot in `roda-app.rb` with `opts[:your_bot_name] = Slackbotsy::Bot.new(YOUR_CONFIG)`
6. You can now use this bot to post message with `PostToSlack.say(:your_bot_name, message)`. Note that posting to slack works only in production enviroment. To change this, go into `app/services/post_to_slack.rb`.

## Food integration
1. Create file 'places.yml'
2. Add there your restaurants. Schema:
  name:
    full_name: ''
    phone: '
    schema: ''
    menu: ''
  Where:
    name is a word called in slack to order from that place
    schema is suggested example of order
3. Run rake places:create

## Tests
`rake db:create RACK_ENV=test`
`rake db:migrate RACK_ENV=test`
`rspec spec`

## Migrations

migrations are generated using a rake task. To generate your migration invoke
`rake generate:migration['Create events']`
under some shells like zsh you need to escape `[`, call it like this 
`rake generate:migration\['Hehe Axzsdasdasd'\]`
## License

MIT
