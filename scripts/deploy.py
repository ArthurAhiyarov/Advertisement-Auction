from scripts.helpful_scripts import get_account
from brownie import AdvAuction, network, config

def deploy_adv_auction():
    account = get_account()
    adv_auction = AdvAuction.deploy({"from": account},
        publish_source=config["networks"][network.show_active()].get("verify", False),)

    print("Deployed lottery!")
    return adv_auction

def main():
    deploy_adv_auction()