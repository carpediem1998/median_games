# median_games.aleo

## name 
Who has the closest number

## Summary

This game originated from Alan Ledu's "Guess 2/3 Average" game. Players who say the closest number to the average of all players will be the winner.


## Application Values
1. The rule of this game is easy and open for all players. Numbers given by players will be anonymously recorded and processed through smart contracts.

2. This game has a big potential to become a GameFi for a big or small community.


## User Flow
Game hoster starts a game session until all players in a community enter. Each player gives out a number and the player with closest number to the average number will see "you won" on his/her terminal.


## How to Build
To compile this Aleo program, run:
```bash
aleo build
```

## How to Run
```bash
leo run place_bid 'address'
```
After the moderator starts the game, participants/players submit wallet addresses to participate in the game. The system will return objects containing parameters such as game address, participant's own wallet address, guess value, total number, etc


```bash
leo run resolve 'Bid' 'Bid'
```
Participants/players submit the number closest to the average in the previous round and the guessed value of the current participant. The system returns the new number closest to the average. The first participant enters the same value for both parameters. If there is a next participant, continue to execute place_ Bid and resolve methods.

```bash
leo run finish 'Bid'
```
End the game, the moderator submits the approximate final average value, and the system returns information such as the guess value and wallet address submitted by the winner




## Parameter Description
```bash
Bid =>   {
       owner: address,
       gates: u64,
       bidder: address,
       amount: u64,
       place: u64,
       totel: u64,
       is_winner: bool,
}
```

`owner: address,`【Event address】

`gates: u64,`【commission】

`bidder: address,`【Player Address】

`amount: u64,`【Number of participants/players】

`place: u64,`【Guess value】

`totel: u64,`【total】

`is_winner: bool,`【Win or not (this value will be updated when the game ends)】



