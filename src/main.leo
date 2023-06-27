// The 'median_games' program.
program median_games.aleo {
  // A bid in an auction.
    // - `owner`     : The address of the account that owns the record associated with this bid.
    //                 This is separate from the address of the account that placed the bid.
    // - `gates`     : The value associated with the record (always zero).
    // - `bidder`    : The address of the account that placed the bid.
    // - `amount`    : The amount of the bid.
    // - `is_winner` : Whether the bid is the winning bid.
    // - 'place' : Which place is it
    // - 'median' ： median Value
    record Bid {
        owner: address,
        gates: u64,
        bidder: address,
        amount: u64,
        place: u64,
        median: u64,
        is_winner: bool,
    }

    // Returns a new bid.
    // - `bidder` : The address of the account that placed the bid.
    // - `amount` : The amount of the bid.
    // Requires that `bidder` matches the function caller.
    // The owner of the record is set to the entity responsible for running the auction (auction runner).
    // The address of the auction runner is aleo1fxs9s0w97lmkwlcmgn0z3nuxufdee5yck9wqrs0umevp7qs0sg9q5xxxzh.
    transition place_bid(bidder: address,median:u64) -> Bid {
        // Ensure the caller is the auction bidder.
        assert_eq(self.caller, bidder);
        // Return a new 'Bid' record for the auction bidder.
        return Bid {
            owner: aleo1d3dt3cctnhhuq3lqp7wxfmx8tkqun43cqmpn75pjur0sv5hdug9s0qmjxj,
            gates: 0u64,
            bidder: bidder,
            amount: 0u64,
            place: 0u64,
            median: median,
            is_winner: false,
        };
    }

    // Returns the winning bid.
    // - `first`  : The first bid.
    // - `second` : The second bid.
    // Requires that the function caller is the auction runner.
    // Assumes that the function is invoked only after the bidding period has ended.
    // In the event of a tie, the first bid is selected.
    transition resolve(last : Bid, second: Bid) -> Bid {
        // Ensure the caller is the auctioneer.
        assert_eq(self.caller, aleo1d3dt3cctnhhuq3lqp7wxfmx8tkqun43cqmpn75pjur0sv5hdug9s0qmjxj);
        // Resolve the winner of the auction.
        if (last.amount - last.median >= second.amount - last.median) {
             return Bid {
                owner: aleo1d3dt3cctnhhuq3lqp7wxfmx8tkqun43cqmpn75pjur0sv5hdug9s0qmjxj,
                gates: 0u64,
                bidder: second.bidder,
                amount: second.amount,
                place:  last.place+1u64,
                median:last.median,
                is_winner: false,
            };
        } else {
              return Bid {
                owner: aleo1d3dt3cctnhhuq3lqp7wxfmx8tkqun43cqmpn75pjur0sv5hdug9s0qmjxj,
                gates: 0u64,
                bidder: last.bidder,
                amount: last.amount,
                place: last.place+1u64,
                median:last.median,
                is_winner: false,
            };
        }
    }

    // Returns ownership of the bid to bidder.
    // - `bid` : The winning bid.
    // Requires that the function caller is the auction runner.
    // Assumes that the function is invoked only after all bids have been resolved.
    transition finish(bid: Bid) -> Bid {
        // Ensure the caller is the auctioneer.
        assert_eq(self.caller, aleo1d3dt3cctnhhuq3lqp7wxfmx8tkqun43cqmpn75pjur0sv5hdug9s0qmjxj);
        // Return 'is_winner' as 'true' in the winning 'Bid'.
        return Bid {
            owner: bid.bidder,
            gates: bid.gates,
            bidder: bid.bidder,
            amount: bid.amount,
            place: bid.place,
            median: bid.median,
            is_winner: true,
        };
    }
}
