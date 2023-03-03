// SPDX-License-Identifier: CC-BY-SA-4.0

pragma solidity ^0.8.7;

contract AccessControl {
    // Depending on the role, an account will be able to call a function or be disallowed to call it
    // role => account => bool

    // emit event when a role has been assigned to a acount
    event GrantRole(bytes32 indexed role, address indexed account);
    event RevokeRole(bytes32 indexed role, address indexed account);

    // The first thing that we need to do is store whether account has a role or not 
    mapping(bytes32 => mapping(address => bool)) public roles;

    bytes32 private constant ADMIN = keccak256(abi.encodePacked("ADMIN"));
    bytes32 private constant USER = keccak256(abi.encodePacked("USER"));

    modifier onlyAdmin {
        require(roles[ADMIN][msg.sender], "Only admin can assign roles!");
        _;
    }

    constructor() {
        _grantRole(ADMIN, msg.sender);
    }

    // @audit RIGHT NOW IT'S BETTER TO USE PRIVATE
    // @audit BUT I THINK THAT ANOTHER CONTRACT
    // @audit WILL USE THIS FUNCTION SO LEAVE IT TO INTERNAL
    function _grantRole(bytes32 _role, address _account) internal {
        roles[_role][_account] = true;
        emit GrantRole(_role, _account);
    }

    function _revokeRole(bytes32 _role, address _account) internal {
        roles[_role][_account] = false;
        emit RevokeRole(_role, _account);
    } 

    function grantRole(bytes32 _role, address _account) external onlyAdmin {
        _grantRole(_role, _account);
    }

    function revokeRole(bytes32 _role, address _account) external onlyAdmin {
        _revokeRole(_role, _account);
    }

}