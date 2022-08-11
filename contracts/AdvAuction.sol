//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract AdvAuction is Ownable, ReentrancyGuard {

    /* ========== STATE VARIABLES ========== */

    mapping(address => uint256) public playersMaxBids;
    uint256 public contractBalance;
    uint256 public lastBid;

    /* ========== EVENTS ========== */
    
    event PersonHasBeatenBid(bool check);

    /* ========== MUTATIVE FUNCTIONS ========== */

    /** @dev Makes a bid to the contract
      * Emits the PersonHasBeatenBid event
     */

    function makeBid() public payable nonReentrant {

        require(msg.value > lastBid, "Less than the previous bid.");
        contractBalance += msg.value;
        lastBid = msg.value;
        playersMaxBids[msg.sender] = msg.value;

        emit PersonHasBeatenBid(true);

    }

    /** @dev Transfers the accumulated balance to the owner's address
     */

    function withdrawStakes() private onlyOwner {
        if (contractBalance > 0) {
            (bool sent, bytes memory data) = (owner()).call{value: contractBalance}("");
            contractBalance = 0;
            require(sent, "Failed to send Ether");
        }
    }

    /* ========== VIEWS ========== */

    /** @dev Shows person's highest bid if there is one
      * @param playerAddr Address of a possible staker
      * @return playersBid Max bid of a staker
     */

    function getPlayersMaxBid(address playerAddr) public view returns(uint256 playersBid) {
        require(playersMaxBids[playerAddr] != 0, "This address has not staked yet!");
        return playersMaxBids[playerAddr];
    }

    /** @dev Shows the latest highest bid
      * @return lastbid
     */

    function getLastMaxBid() public view returns(uint256) {
        return lastBid;
    }
}