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

def update_front_end():
    with open('brownie-config.yaml', 'r') as brownie_config:
        config_dict = yaml.load(brownie_config, Loader=yaml.FullLoader)
        with open('./front_end/src/brownie-config.json', 'w') as brownie_config_json:
            json.dump(config_dict, brownie_config_json)
    print('Front end updated!')

def main():
    deploy_adv_auction(front_end_update=True)