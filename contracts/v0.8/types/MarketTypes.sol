// SPDX-License-Identifier: Apache-2.0
pragma solidity >=0.4.25 <=0.8.15;

import "./CommonTypes.sol";

/// @title Filecoin market actor types for Solidity.
/// @author Zondax AG
library MarketTypes {
    struct WithdrawBalanceParams {
        bytes provider_or_client;
        uint256 tokenAmount;
    }

    struct WithdrawBalanceReturn {
        uint256 amount_withdrawn;
    }

    struct GetBalanceReturn {
        uint256 balance;
        uint256 locked;
    }

    struct GetDealDataCommitmentParams {
        uint64 id;
    }

    struct GetDealDataCommitmentReturn {
        bytes data;
        uint64 size;
    }

    struct GetDealClientParams {
        uint64 id;
    }

    struct GetDealClientReturn {
        bytes client;
    }

    struct GetDealProviderParams {
        uint64 id;
    }

    struct GetDealProviderReturn {
        bytes provider;
    }

    struct GetDealLabelParams {
        uint64 id;
    }

    struct GetDealLabelReturn {
        string label;
    }

    struct GetDealTermParams {
        uint64 id;
    }

    struct GetDealTermReturn {
        int64 start;
        int64 end;
    }

    struct GetDealEpochPriceParams {
        uint64 id;
    }

    struct GetDealEpochPriceReturn {
        uint256 price_per_epoch;
    }

    struct GetDealClientCollateralParams {
        uint64 id;
    }

    struct GetDealClientCollateralReturn {
        uint256 collateral;
    }

    struct GetDealProviderCollateralParams {
        uint64 id;
    }

    struct GetDealProviderCollateralReturn {
        uint256 collateral;
    }

    struct GetDealVerifiedParams {
        uint64 id;
    }

    struct GetDealVerifiedReturn {
        bool verified;
    }

    struct GetDealActivationParams {
        uint64 id;
    }

    struct GetDealActivationReturn {
        int64 activated;
        int64 terminated;
    }

    struct PublishStorageDealsParams {
        CommonTypes.ClientDealProposal[] deals;
    }

    struct PublishStorageDealsReturn {
        uint64[] ids;
        bytes valid_deals;
    }
}
