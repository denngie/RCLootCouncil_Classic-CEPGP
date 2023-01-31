# RCLootCouncil Classic - CEPGP
A module adding CEPGP support for RCLootCouncil Classic

How does it work? It inserts an extra column, showing the PR value of each member, in the voting frame. When you assign an item the calculcated GP value is added to the winner. The module reuses CEPGP's own functions for these calculations. The button/response text is forwarded to CEPGP and visible in CEPGP traffic. All loot will be visible in both RC LC history and CEPGP traffic.

## How to use
When you start a master looter session answer yes to use RC LC to handle loot and no to CEPGP. Master looter must have this addon, everyone in your loot council are optional depending on if they wanna see the PR column. Raid members only needs the standard RC LC Classic addon but are probably gonna want CEPGP addon as well.

## Known limitations
* Reawarding an item to change the winner does not subtract the GP award to the previous winner
* Switching back and forth between items in the voting frame results in the PR columning not auto updating after awarding an item and it switches to the next item (workaround: click the same item again)
* Discount is not supported
* If RC LC test mode is used it will not run the CEPGP add GP function
* If one of the following responses is used it will not run the CEPGP add GP function:
    * Disenchant
    * Banking
    * Free
    * Pass
    * Autopass
* If a button/response contains the word free the GP value is reduced to zero

## Credits
Shoutout to bagstone and his addon RCLootCouncil_PlusOne which was a big inspiration for this.
