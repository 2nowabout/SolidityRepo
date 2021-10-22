// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Certificate
{

    mapping(string => string[]) private hashes;

    function StoreCertificate(string memory hash, string memory user) public {
        require
        hashes[user].push(hash);
    }
    
    function verifyCertificateFromUser(string memory hashFromCertificate, string memory user) public view returns (bool)
    {
        bool isActualDocument = false;
        string[] memory hashesFromUser = hashes[user];
        for(uint i=0; i<hashesFromUser.length; i++)
        {
            if(keccak256(bytes(hashesFromUser[i])) == keccak256(bytes(hashFromCertificate)))
            {
                isActualDocument = true;
            }
        }
        return isActualDocument;
    }

    function findCertificates(string memory user) public view returns (string[] memory)
    {
        return hashes[user];
    }
}