from scripts.helpful_scripts import (
    LOCAL_BLOCKCHAIN_ENVIRONMENTS,
)
from brownie import network
from scripts.deploy import deploy_adv_auction
import pytest


@pytest.fixture()
def lottery_contract():
    return deploy_adv_auction()