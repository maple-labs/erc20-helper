// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.7;

interface IERC20 {

    function transfer(address, uint256) external pure returns (bool);

    function transferFrom(address, address, uint256) external pure returns (bool);

    function approve(address, uint256) external pure returns (bool);

}
