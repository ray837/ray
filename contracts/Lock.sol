// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

 

contract Lock {
 
      struct User {
        bytes32 passwordHash;
        bool exists;
      }  
    
    mapping(string => User) private users;
    
    event UserRegistered(string email);
    
    function registerUser(string memory email, bytes32 passwordHash) public {
        require(!users[email].exists, "User already registered");
        users[email] = User(passwordHash, true);
        emit UserRegistered(email);
    }
    
    function loginUser(string memory email, bytes32 passwordHash) public view returns(bool) {
        return users[email].exists && users[email].passwordHash == passwordHash;
    }
    
    function deleteUser(string memory email,bytes32 passwordHash) public {
        require(users[email].exists && users[email].passwordHash == passwordHash, "Not allowed to delete");
        delete users[email];
    }
    
    function changePassword(string memory email, bytes32 newPasswordHash) public {
        require(users[email].exists, "User does not exist");
        users[email].passwordHash = newPasswordHash;
    }

}