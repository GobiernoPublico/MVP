// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract GobiernoPublico {
    uint public proposalCount = 0;

    struct Proposal {
        uint id;
        string description;
        uint yesVotes;
        uint noVotes;
        uint deadline;
        bool exists;
    }

    mapping(uint => Proposal) public proposals;
    mapping(uint => mapping(address => bool)) public hasVoted;

    event ProposalCreated(uint id, string description, uint deadline);
    event Voted(uint proposalId, address voter, bool support);

    modifier proposalExists(uint id) {
        require(proposals[id].exists, "Propuesta no existe");
        _;
    }

    function createProposal(string calldata description, uint durationMinutes) external {
        uint deadline = block.timestamp + (durationMinutes * 1 minutes);
        proposals[proposalCount] = Proposal(proposalCount, description, 0, 0, deadline, true);
        emit ProposalCreated(proposalCount, description, deadline);
        proposalCount++;
    }

    function vote(uint proposalId, bool support) external proposalExists(proposalId) {
        Proposal storage p = proposals[proposalId];
        require(block.timestamp < p.deadline, "Votacion cerrada");
        require(!hasVoted[proposalId][msg.sender], "Ya has votado");

        if (support) {
            p.yesVotes++;
        } else {
            p.noVotes++;
        }
        hasVoted[proposalId][msg.sender] = true;

        emit Voted(proposalId, msg.sender, support);
    }

    function getProposal(uint proposalId) external view proposalExists(proposalId) returns (
        string memory description,
        uint yesVotes,
        uint noVotes,
        uint deadline,
        bool active
    ) {
        Proposal memory p = proposals[proposalId];
        return (
            p.description,
            p.yesVotes,
            p.noVotes,
            p.deadline,
            block.timestamp < p.deadline
        );
    }
}
