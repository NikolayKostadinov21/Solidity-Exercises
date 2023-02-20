// SPDX-License-Identifier: CC-BY-SA-4.0

pragma solidity ^0.8.7;

contract MerkleProof {
    function verify(
        bytes32[] memory proof, // array of hashes that need to be computed
        bytes32 root, // the merkle root itself
        bytes32 leaf, // the hash of the element of the array that was used to construct the merkle tree
        uint index // the index in the array where the element is stored
    ) public pure returns (bool) { //the funtion will return true if it can recreate the merkle root from the proof, lead and index, otherwise -> false
        bytes32 hash = leaf;

        for (uint i; i < proof.length; i++) {
            // if the index is even, then we need to append the proof element to our current hash
            // and then update our hash
            if (index % 2 == 0) {
                hash = keccak256(abi.encodePacked(hash, proof[i]));
            } else {
                hash = keccak256(abi.encodePacked(proof[i], hash));
            }

            index /= 2;
        }

        // recompute merkle root
        return hash == root;

    }
}