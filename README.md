# ERC20Helper

[![CircleCI](https://circleci.com/gh/maple-labs/erc20-helper/tree/main.svg?style=svg)](https://circleci.com/gh/maple-labs/erc20-helper/tree/main) [![License: AGPL v3](https://img.shields.io/badge/License-AGPL%20v3-blue.svg)](https://www.gnu.org/licenses/agpl-3.0)

**DISCLAIMER: Please do not use in production without taking the appropriate steps to ensure maximum security.**

**WARNING: Unlike other similar libraries, this  library does NOT REVERT ON FAILURES. Any contracts that inherit this code that expect the reversion to occur in this contract can have UNINTENDED AND POTENTIALLY CATASTROPHIC CONSEQUENCES.** 

ERC20Helper is a basic library designed to be used as a middleware between general smart contracts diverse erc20 tokens. It standardizes the behaviours of all commonly used implementations.

The decision to intentionally not revert was so that this library can be more flexible for contracts that:
- Want to choose their own revert strings, or none at all (i.e. `require(ERC20Helper.transfer(asset, msg.sender, amount), "FOO:FAILED_TRANSFER");`).
- Want to use the returns as booleans (i.e. `require(ERC20Helper.transfer(asset1, msg.sender, amount) || ERC20Helper.transfer(asset2, msg.sender, amount));`).
- Do not care about the result of a transfer.

## Testing and Development
### Setup
```sh
git clone git@github.com:maple-labs/erc20-helper.git
cd erc20-helper
dapp update
make test
```
### Running Tests
- To run all tests: `make test` (runs `./test.sh`)
- To run a specific test function: `./test.sh -t <test_name>` (e.g., `./test.sh -t test_fundLoan`)

This project was built using [dapptools](https://github.com/dapphub/dapptools).

## Audit Reports
| Auditor | Report link |
|---|---|
| Trail of Bits | [ToB - Dec 28, 2021](https://docs.google.com/viewer?url=https://github.com/maple-labs/maple-core/files/7847684/Maple.Finance.-.Final.Report_v3.pdf) |
| Code 4rena | [C4 - Jan 5, 2022](https://code4rena.com/reports/2021-12-maple/) |

## Acknowledgements

These contracts were inspired by and/or directly modified from the following sources:

- [Solmate](https://github.com/Rari-Capital/solmate)
- [OpenZeppelin](https://github.com/OpenZeppelin/openzeppelin-contracts)
- [Uniswap-v3](https://github.com/Uniswap/uniswap-v3-core/blob/main/contracts/libraries/TransferHelper.sol)

---

<p align="center">
  <img src="https://user-images.githubusercontent.com/44272939/116272804-33e78d00-a74f-11eb-97ab-77b7e13dc663.png" height="100" />
</p>
