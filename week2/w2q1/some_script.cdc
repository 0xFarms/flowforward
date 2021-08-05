import SomeContract from ./some_contract.cdc

pub fun main() {
  // Area 4
  // variables with read scope - a, b, c, e from SomeContract. Any other vars created inside this func
  // variables with write scope - a, any other vars created inside this func
  // function access - all contracts can access main(). it's a script so it only has read access to other contracts
}