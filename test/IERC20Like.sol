// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.7;

interface IERC20Like {

    function allowance(address owner_, address spender_) external view returns (uint256 allowance_);

    function balanceOf(address owner_) external view returns (uint256 balance_);

}
