//SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0 <0.9.0;

contract Doc{

  struct Document {
        string hash;
        string name;
        address[] status;
    }
Document [] doc;
mapping(address =>mapping(string =>Document[])) private users;
mapping(address =>Document[]) private Mydocs;

 function store(string calldata _hash,string calldata _name) public {
    users[msg.sender][_name].push(Document(_hash, _name,new address[](0)));
    Mydocs[msg.sender].push(Document(_hash,_name,new address[](0)));
 }

function getall() external view returns(Document[] memory) {
    return Mydocs[msg.sender];
}
function getDocumentHash(string calldata _name) external view returns (Document[] memory) {
        return users[msg.sender][_name];
    }
 
 struct DocumentInfo {
        string ipfsHash;
        string name;
        address sender;
        bool verified;
    }
     
mapping (address=> DocumentInfo [] ) verifierDocs;
 
mapping(string=>address) verifiers;

function isVerifier(string calldata uname) external view returns (bool){
return verifiers[uname] !=address(0);
}


function reg_verifier(string calldata _uname) public{
  if(verifiers[_uname]==address(0)){
    
        verifiers[_uname]=msg.sender;
        }
    
}


function getVerifier(string calldata uname) external view returns (address) {
return verifiers[uname];
}

function get_vdocs() external view returns(DocumentInfo[] memory) {

return verifierDocs[msg.sender];
}

function Share(address reciver,string memory ipfs,string memory file) public {
 DocumentInfo memory newDoc = DocumentInfo(ipfs, file, msg.sender, false);
 verifierDocs[reciver].push(newDoc);
}



function attestDocument(address a,string calldata _name) public {
    Document[] storage docs = users[a][_name];
     require(docs.length > 0, "No documents found for the given name.");
     Document storage dod = docs[docs.length - 1];
     address[] storage status = dod.status;
    status.push(msg.sender);
   Document[] storage dods =Mydocs[a];
    Document storage dodd = dods[docs.length - 1];
    address[] storage statu = dodd.status;
    statu.push(msg.sender);
}

}