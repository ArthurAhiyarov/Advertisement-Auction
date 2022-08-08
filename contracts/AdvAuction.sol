//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract AdvAuction is Ownable, ReentrancyGuard {

    mapping(address => uint256) public players;
    uint256 public contractBalance;
    uint256 public lastBid;
    
    event PersonHasBeatenBid(bool check);

    function doBid() public payable nonReentrant returns (bool) {

        require(msg.value > lastBid, "Less than the previous bid.");
        contractBalance += msg.value;
        lastBid = msg.value;
        players[msg.sender] = msg.value;

        emit PersonHasBeatenBid(true);

    }

    function withdrawStakes() private OnlyOwner {
        if (contractBalance > 0) {
            contractBalance = 0;
            (bool sent, bytes memory data) = (owner()).call{value: contractBalance}("");
            require(sent, "Failed to send Ether");
        }
    }

    function getPlayersBid(address playerAddr) public view returns(uint256 playersBid) {
        require(players[playerAddr] != 0, "This address has not staked yet!");
        return players[playerAddr];
    }

}