# Pokémon API Consumer

This project is a Rails application that consumes data from the Pokémon API (https://pokeapi.co/docs/v2).

## Installation

1. Cloning the Repository
`git clone <repository_url>`

2. Installing Dependencies
`bundle install`

3. Running the Rake Task to Update Pokémon Data
`bundle exec rake pokemon:update_list`

This rake task fetches and populates the database with Pokémon data from the API. 

*To update the list with the most current data from the API, run the rask task again.*

## Usage

To start the Rails server, run the following command:
`rails server`

You can now access the application at http://localhost:3000.

Navigate to http://localhost:3000/pokemons to view the list of Pokémon.

Click on a Pokémon from the list to view its details at http://localhost:3000/pokemons/:id.

