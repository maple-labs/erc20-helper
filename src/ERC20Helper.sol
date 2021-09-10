// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.7;

import { IERC20 } from "../lib/erc20/src/interfaces/IERC20.sol";

/**
 * @title Small Library to standardize erc20 token interactions. 
 * @dev   Code inspired from Uniswap TransferHelper.sol - GPL-2.0-or-later 
 * @dev   https://github.com/Uniswap/uniswap-v3-core/blob/b2c5555d696428c40c4b236069b3528b2317f3c1/contracts/libraries/TransferHelper.sol#L19
 * @dev   Acknowledgements to Solmate, OpenZeppelin, and Uniswap for inspiring this code.
 */
library ERC20Helper {

    /**************************/
    /*** Internal Functions ***/
    /**************************/

    function transfer(address token, address to, uint256 amount) internal returns (bool) {
        return _call(token, abi.encodeWithSelector(IERC20.transfer.selector, to, amount));
    }

    function transferFrom(address token, address from, address to, uint256 amount) internal returns (bool) {
        return _call(token, abi.encodeWithSelector(IERC20.transferFrom.selector, from, to, amount));
    }

    function approve(address token, address spender, uint256 amount) internal returns (bool) {
        return _call(token, abi.encodeWithSelector(IERC20.approve.selector, spender, amount));
    }

    function _call(address token, bytes memory data) private returns (bool success) {
        bytes memory returnData;
        (success, returnData) = token.call(data);

        return success && (returnData.length == 0 || abi.decode(returnData, (bool)));
    }

}
