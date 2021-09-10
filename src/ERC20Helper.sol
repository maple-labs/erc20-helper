// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.7;

import { IERC20 } from "../lib/erc20/src/interfaces/IERC20.sol";

/// @title Small Library to standardize erc20 token interactions
library ERC20Helper {

    /**************************/
    /*** Internal Functions ***/
    /**************************/

    function transfer(address token, address to, uint256 amount) internal returns (bool) {
        // Inspired by Uniswap - GPL-2.0-or-later
        // https://github.com/Uniswap/uniswap-v3-core/blob/b2c5555d696428c40c4b236069b3528b2317f3c1/contracts/libraries/TransferHelper.sol#L19
        return _call(token, abi.encodeWithSelector(IERC20.transfer.selector, to, amount));
    }

    function transferFrom(address token, address from, address to, uint256 amount) internal returns (bool) {
        return _call(token, abi.encodeWithSelector(IERC20.transferFrom.selector, from, to, amount));
    }

    function approve(address token, address spender, uint256 amount) internal returns (bool) {
        return _call(token, abi.encodeWithSelector(IERC20.approve.selector, spender, amount));
    }

    function _call(address token, bytes memory data) private returns (bool success) {
        // Inspired by Solmate - AGPL-3.0-only
        // https://github.com/Rari-Capital/solmate/blob/370f014278419d6d11687decfa9d2b30d173d4c3/src/erc20/SafeERC20.sol#L15
        bytes memory returnData;
        (success, returnData) = token.call(data);

        return success && (returnData.length == 0 || abi.decode(returnData, (bool)));
    }

}
