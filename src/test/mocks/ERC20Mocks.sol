// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.7;

contract ERC20TrueReturner {

    function transfer(address to_, uint256 value_) external pure returns (bool success_) {
        return true;
    }

    function transferFrom(address from_, address to_, uint256 value_) external pure returns (bool success_) {
        return true;
    }

    function approve(address to_, uint256 value_) external pure returns (bool success_) {
        return true;
    }

}

contract ERC20FalseReturner {

    function transfer(address to_, uint256 value_) external pure returns (bool success_) {
        return false;
    }

    function transferFrom(address from_, address to_, uint256 value_) external pure returns (bool success_) {
        return false;
    }

    function approve(address to_, uint256 value_) external pure returns (bool success_) {
        return false;
    }

}

contract ERC20NoReturner {

    function transfer(address to_, uint256 value_) external {}

    function transferFrom(address from_, address to_, uint256 value_) external {}

    function approve(address to_, uint256 value_) external {}

}

contract ERC20Reverter {

    function transfer(address to_, uint256 value_) external pure returns (bool success_) {
        require(false);
    }

    function transferFrom(address from_, address to_, uint256 value_) external pure returns (bool success_) {
        require(false);
    }

    function approve(address to_, uint256 value_) external pure returns (bool success_) {
        require(false);
    }

}
