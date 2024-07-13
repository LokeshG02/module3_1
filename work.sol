// write a smart contract that implements the require(), assert() and revert() statements
// consider a simple school grading system or a small local store. The project doesn't have to be extensive; 
//just 3-4 functions using all three error handlers will suffice.
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SchoolGrading {
    address public teacher;
    uint public grade;
    bool public gradeSet;

    constructor() {
        teacher = msg.sender;
    }

    modifier onlyTeacher() {
        require(msg.sender == teacher, "Only teacher can perform this action");
        _;
    }

    function setGrade(uint newGrade) external onlyTeacher {
        require(newGrade >= 0 && newGrade <= 100, "Grade must be between 0 and 100");
        grade = newGrade;
        gradeSet = true;
    }

    function getGrade() external view returns (uint) {
        require(gradeSet, "Grade has not been set");
        return grade;
    }

    function updateTeacher(address newTeacher) external {
        require(msg.sender == teacher, "Only the current teacher can update");
        assert(newTeacher != address(0)); // To Check that the new teacher address is not zero
        teacher = newTeacher;
    }

    
}
