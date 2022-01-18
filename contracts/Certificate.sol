// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
pragma experimental ABIEncoderV2;

contract Certificate
{

    mapping(string => Certificatestruct[]) private hashes;

    struct Certificatestruct {
        string hash;
        string ipfshash;
    }

    event storedCertificate(bool done);

    function StoreCertificate(string memory hash, string memory ipfshash, string memory user) public {
        Certificatestruct memory tempstruct = Certificatestruct(hash, ipfshash);
        hashes[user].push(tempstruct);
        emit storedCertificate(true);
    }
    
    function verifyCertificateFromUser(string memory hashFromCertificate, string memory user) public view returns (bool)
    {
        bool isActualDocument = false;
        Certificatestruct[] memory hashesFromUser = hashes[user];
        for(uint i=0; i<hashesFromUser.length; i++)
        {
            if(keccak256(bytes(hashesFromUser[i].hash)) == keccak256(bytes(hashFromCertificate)))
            {
                isActualDocument = true;
            }
        }
        return isActualDocument;
    }

    function findCertificates(string memory user) public view returns (Certificatestruct[] memory)
    {
        return hashes[user];
    }

    function getBalance() public view returns(uint)
    {
    return address(this).balance;
    }
}