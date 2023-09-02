// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity >=0.8.0;

contract ERC20ApproveSetToZero {

    mapping(address => mapping(address => uint256)) public allowances;

    function approve(address spender, uint256 amount) external returns (bool) {
        require(
            allowances[msg.sender][spender] == 0 || amount == 0,
            "ERC20/approve-set-to-non-zero"
        );
        allowances[msg.sender][spender] = amount;
        return true;
    }
}

contract ERC20ApproveFailOnSetToAmount {

    mapping(address => mapping(address => uint256)) public allowances;

    function approve(address spender, uint256 amount) external returns (bool) {
        require(amount == 0, "ERC20/approve-set-to-non-zero");
        allowances[msg.sender][spender] = amount;
        return true;
    }
}

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
