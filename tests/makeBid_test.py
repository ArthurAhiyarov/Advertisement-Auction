from scripts.helpful_scripts import (
    get_account,
    LOCAL_BLOCKCHAIN_ENVIRONMENTS,
)
import time
from web3 import Web3
from brownie import network
import pytest

def test_makeBid_and_emit_PersonHasBeatenBid():
    #Arrange
    if network.show_active() not in LOCAL_BLOCKCHAIN_ENVIRONMENTS:
        pytest.skip()
    
    #Act

    new_bid = "1 ether"



    