// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract SimpleBank {
    address public owner;

    event Deposited(address indexed user, uint amount);
    event Withdrawn(address indexed owner, uint amount);

    constructor() {
        owner = msg.sender; // Set the contract deployer as the owner
    }

    // Function to deposit money into the contract
    function deposit() external payable {
        require(msg.value > 0, "Deposit amount must be greater than zero");
        emit Deposited(msg.sender, msg.value);
    }

    // Function to withdraw money (Only Owner)
    function withdraw(uint _amount) external {
        require(msg.sender == owner, "Only the owner can withdraw funds");
        require(_amount <= address(this).balance, "Insufficient contract balance");

        payable(owner).transfer(_amount);
        emit Withdrawn(owner, _amount);
    }

    // Function to check contract balance
    function getBalance() external view returns (uint) {
        return address(this).balance;
    }
}
