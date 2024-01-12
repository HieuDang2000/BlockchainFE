// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ManagementCertificateToken {
    address public owner;

    struct ManagementCertificate {
        string name;
        uint256 yearGraduated;
        uint256 studentId;
        uint256 rank;
    }

    mapping(address => ManagementCertificate) public managementCertificates;

    event CertificateMinted(address indexed account, string name, uint256 yearGraduated, uint256 studentId, uint256 rank);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    modifier hasCertificate(address account) {
        require(managementCertificates[account].yearGraduated != 0, "No certificate found");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function mintCertificate(address account, string memory name, uint256 yearGraduated, uint256 studentId, uint256 rank) external onlyOwner {
        managementCertificates[account] = ManagementCertificate(name, yearGraduated, studentId, rank);
        emit CertificateMinted(account, name, yearGraduated, studentId, rank);
    }

    function getCertificate(address account) external view hasCertificate(account) returns (string memory, uint256, uint256, uint256) {
        ManagementCertificate memory certificate = managementCertificates[account];
        return (certificate.name, certificate.yearGraduated, certificate.studentId, certificate.rank);
    }
}
