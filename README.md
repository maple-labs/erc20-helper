# ERC20Helper

[![CircleCI](https://circleci.com/gh/maple-labs/erc20-helper/tree/main.svg?style=svg)](https://circleci.com/gh/maple-labs/erc20-helper/tree/main) [![License: AGPL v3](https://img.shields.io/badge/License-AGPL%20v3-blue.svg)](https://www.gnu.org/licenses/agpl-3.0)

**DISCLAIMER: Please do not use in production without taking the appropriate steps to ensure maximum security.**

**WARNING: Unlike other similar libraries, this  library does NOT REVERT ON FAILURES. Any contracts that inherit this code that expect the reversion to occur in this contract can have UNINTENDED AND POTENTIALLY CATASTROPHIC CONSEQUENCES.**

ERC20Helper is a basic library designed to be used as a middleware between general smart contracts and diverse ERC-20 tokens. It standardizes the behaviours of all commonly used implementations.

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
| Trail of Bits | [ToB Report - April 12, 2022](https://docs.google.com/viewer?url=https://github.com/maple-labs/maple-core/files/8507237/Maple.Finance.-.Final.Report.-.Fixes.pdf) |
| Code 4rena | [C4 Report - April 20, 2022](https://code4rena.com/reports/2022-03-maple/) |

## Bug Bounty

For all information related to the ongoing bug bounty for these contracts run by [Immunefi](https://immunefi.com/), please visit this [site](https://immunefi.com/bounty/maple/).

| Severity of Finding | Payout |
|---|---|
| Critical | $50,000 |
| High | $25,000 |
| Medium | $1,000 |

## Acknowledgements

These contracts were inspired by and/or directly modified from the following sources:

- [Solmate](https://github.com/Rari-Capital/solmate)
- [OpenZeppelin](https://github.com/OpenZeppelin/openzeppelin-contracts)
- [Uniswap-v3](https://github.com/Uniswap/uniswap-v3-core/blob/main/contracts/libraries/TransferHelper.sol)

---

<p align="center">
  <img src="https://user-images.githubusercontent.com/44272939/196706799-fe96d294-f700-41e7-a65f-2d754d0a6eac.gif" height="100" />
</p>

