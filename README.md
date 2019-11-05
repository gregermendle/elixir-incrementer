# Incrementer
**You must have elixir installed to run this application...**

Run the following to initialize and run the incrementer app:
```
./init
./start
```

If you would like to reset the numbers database you can run:
```
./reset
```

Run the following command to test the incrementer:
```
mix test
```

# Design

### What it does
This web service accepts requests like shown below to increment a value at a given key:
```
curl -X POST http://localhost:3333/increment -d 'key=abcdef&value=1'
```
Key `abcdef` will be incremented by `1`

### Storage
Data is stored within a `Map` inside of a `GenServer`. That state module is then incorporated into the applications supervision tree.

On initialization of the state module, a job is kicked off to sync the `GenServer`s state with a sqlite database every 10 seconds. Data sync happens in a seperate process to help mitigate time shift. This method does not completly mitigate the issue of time shift but helps it considerably.

The state that has been synced to the sqlite database is used on initialization to rehydrate the GenServer state.

### Whats missing?
1. Validation could be done to ensure only positive values are allowed to be passed to the endpoint... It is an incrementer after all.
2. More testing should be done to ensure that the genserver logic is sound and that the db sync works appropriately