from scripts.helpful_scripts import get_account
from brownie import AdvAuction, network, config
import yaml
import json

def deploy_adv_auction(front_end_update=False):
    account = get_account()
    adv_auction = AdvAuction.deploy({"from": account},
        publish_source=config["networks"][network.show_active()].get("verify", False),)

    print("Deployed Advertisement Auction!")
    if front_end_update:
        update_front_end()
    return adv_auction

def main():
    deploy_adv_auction(front_end_update=True)