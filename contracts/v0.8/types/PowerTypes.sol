// SPDX-License-Identifier: Apache-2.0
pragma solidity >=0.4.25 <=0.8.17;

import "./CommonTypes.sol";

/// @title Filecoin power actor types for Solidity.
/// @author Zondax AG
library PowerTypes {
    struct CreateMinerParams {
        bytes owner;
        bytes worker;
        CommonTypes.RegisteredPoStProof window_post_proof_type;
        bytes peer;
        bytes[] multiaddrs;
    }
    struct CreateMinerReturn {
        /// Canonical ID-based address for the actor.
        bytes id_address;
        /// Re-org safe address for created actor.
        bytes robust_address;
    }
    struct MinerCountReturn {
        int64 miner_count;
    }
    struct MinerConsensusCountReturn {
        int64 miner_consensus_count;
    }
}