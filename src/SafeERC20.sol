// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity >=0.8.0;

import { IERC20 } from "./interfaces/IERC20.sol";

/**
 *  @title Small library to standardize erc20 token interactions.
 */
library SafeERC20 {

    /**********************************************************************************************/
    /*** Internal Functions                                                                     ***/
    /**********************************************************************************************/

    function safeTransfer(address token, address to, uint256 amount) internal {
        require(
            _call(token, abi.encodeCall(IERC20.transfer, (to, amount))),
            "SafeERC20/transfer-failed"
        );
    }

    function safeTransfer(IERC20 token, address to, uint256 amount) internal {
        safeTransfer(address(token), to, amount);
    }

    function safeTransferFrom(address token, address from, address to, uint256 amount) internal {
        require(
            _call(token, abi.encodeCall(IERC20.transferFrom, (from, to, amount))),
            "SafeERC20/transfer-from-failed"
        );
    }

    function safeTransferFrom(IERC20 token, address from, address to, uint256 amount) internal {
        safeTransferFrom(address(token), from, to, amount);
    }

    function safeApprove(address token, address spender, uint256 amount) internal {
        bytes memory approvalCall
            = abi.encodeCall(IERC20.approve, (spender, amount));

        // Try to call approve with amount, if that doesn't work, set to 0 and then to amount.
        if (!_call(token, approvalCall)) {
            require(
                _call(token, abi.encodeCall(IERC20.approve, (spender, 0))),
                "SafeERC20/approve-zero-failed"
            );
            require(
                _call(token, approvalCall),
                "SafeERC20/approve-amount-failed"
            );
        }
    }

    function safeApprove(IERC20 token, address spender, uint256 amount) internal {
        safeApprove(address(token), spender, amount);
    }

    /**********************************************************************************************/
    /*** Private Functions                                                                      ***/
    /**********************************************************************************************/

    function _call(address token, bytes memory data_) private returns (bool success) {
        if (token.code.length == 0) return false;

        bytes memory returnData;
        ( success, returnData ) = token.call(data_);

        return success && (returnData.length == 0 || abi.decode(returnData, (bool)));
    }

}
