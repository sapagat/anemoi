# Anemoi

Directions for those that decide not to use a smartphone.

## Usage

Send an SMS explaining where you are and where you want to go separated by a comma:

```
masquefa 45 benimaclet, bar clandestino benimaclet
```

You will receive an SMS explaining how to arrive. *For now, the system believes you are walking*

First section will contain the destination so that you make sure it is the one you searched for:

```
Carrer del Poeta Asins, 9, 46020 València, Valencia, Spain (0.5 km);
```

The following sections contain the different steps to reach your destination:

```
Head south on Carrer de Masquefa toward Carrer del Poeta Ricard Sanmartí (0.4 km);Turn right onto Carrer del Músic Belando (83 m);Turn left onto Carrer del Baró de San Petrillo (35 m);Turn left onto Carrer del Poeta AsinsDestination will be on the left (10 m)
```

Notice that Twilio will compose more than one SMS if the message exceeds 160 characters.

## Development & Test

Requirements:

- Docker + docker-compose

**IMPORTANT** Your first need to configure the Directions API key in `environment/directions.prod`. You can find an example in `environment/directions.example`.


Boot web server on http://localhost:8080:

```
docker-compose up
```

You can use the webhook in development making use of `ngrok`: https://ngrok.com/

Run tests:

```
docker-compose run --rm app bundle exec rspec
```

## Production

### Deploy app

The app can be deployed to Heroku easily (not the only way)

- https://devcenter.heroku.com/articles/getting-started-with-ruby#deploy-the-app

You should set up the directions API_KEY as an environment variable.

```
DIRECTIONS_API_KEY=<your_key>
```

### Directions API set up

- Follow the steps here until you reach the point in which you obtain a API_KEY: https://developers.google.com/maps/documentation/directions/start

- Enable Directions API from developer console

### Twilio set up

- Create an account (trial is a good starting point)
- Obtain a phone number for sending and receiving SMS.
- Here https://www.twilio.com/console/phone-numbers/incoming you can find how to configure the webhook:

```
HTTP POST <your_base_url>/webhook
```

Notice that `your_base_url` includes the schema, host and port.
