const savingsBank = artifacts.require("SavingsBank");
const attacker = artifacts.require("Attacker");

// user accounts = account[0], account[1], account[2]
// attacker account = account[9]

module.exports = async function(deployer) {

  // Set the current blockchain account
  const accounts = await web3.eth.getAccounts();
  // deploy a savings bank contract
  await deployer.deploy(savingsBank, {from: accounts[0]});
  //access information about your deployed contract instance
  const instance = await savingsBank.deployed();

  // deploy a attacker contract and pass savings bank contract instance
  await deployer.deploy(attacker, instance.address, {from: accounts[9]});
}