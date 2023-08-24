// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.7;

contract ERC20TrueReturner {

    function transfer(address, uint256) external pure returns (bool) {
        return true;
    }

    function transferFrom(address, address, uint256) external pure returns (bool) {
        return true;
    }

    function approve(address, uint256) external pure returns (bool) {
        return true;
    }

}

contract ERC20FalseReturner {

    function transfer(address, uint256) external pure returns (bool) {
        return false;
    }

    function transferFrom(address, address, uint256) external pure returns (bool) {
        return false;
    }

    function approve(address, uint256) external pure returns (bool) {
        return false;
    }

}

contract ERC20NoReturner {

    function transfer(address, uint256) external {}

    function transferFrom(address, address, uint256) external {}

    function approve(address, uint256) external {}

}

contract ERC20Reverter {

    function transfer(address, uint256) external pure returns (bool success) {
        success = false;
        require(false);
    }

    function transferFrom(address, address, uint256) external pure returns (bool success) {
        success = false;
        require(false);
    }

    function approve(address, uint256) external pure returns (bool success) {
        success = false;
        require(false);
    }

}
