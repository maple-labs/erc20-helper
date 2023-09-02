// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity >=0.8.0;

import { IERC20, SafeERC20 } from "../../src/SafeERC20.sol";

contract SafeERC20Wrapper {

    function safeTransfer(address token, address to, uint256 amount) external {
        SafeERC20.safeTransfer(token, to, amount);
    }

    function safeTransferIERC20(IERC20 token, address to, uint256 amount) external {
        SafeERC20.safeTransfer(token, to, amount);
    }

    function safeTransferFrom(address token, address from, address to, uint256 amount) external {
        SafeERC20.safeTransferFrom(token, from, to, amount);
    }

    function safeTransferFromIERC20(IERC20 token, address from, address to, uint256 amount) external {
        SafeERC20.safeTransferFrom(token, from, to, amount);
    }

    function safeApprove(address token, address spender, uint256 amount) external {
        SafeERC20.safeApprove(token, spender, amount);
    }

    function safeApproveIERC20(IERC20 token, address spender, uint256 amount) external {
        SafeERC20.safeApprove(token, spender, amount);
    }

}
