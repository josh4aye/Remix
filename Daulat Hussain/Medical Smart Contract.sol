// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

contract MecidalHistory
{
    struct Patient
    {
        string name;
        uint age;
        string [] conditions;
        string [] allergies;
        string [] medications;
        string [] procedures;
    }

    mapping (address => Patient) public patients;

    function addPatient(
        string memory _name,
        uint _age,
        string [] memory _conditions,
        string [] memory _allergies,
        string [] memory _medications,
        string [] memory _procedures        
    ) public{
        Patient memory patient = Patient
        ({
            name: _name,
            age: _age, 
            conditions: _conditions, 
            allergies: _allergies, 
            medications: _medications,
            procedures: _procedures
        });

        patients[msg.sender] = patient;   
    }

    function updatePatient(
        string [] memory _conditions,
        string [] memory _allergies,
        string [] memory _medications,
        string [] memory _procedures
    ) public view {
        Patient memory patient = patients[msg.sender];
        patient.conditions = _conditions;
        patient.allergies = _allergies;
        patient.medications = _medications;
        patient.procedures = _procedures;
    }

    function getPatient(address _patientAddress) public view returns(
        string memory,
        uint,
        string [] memory,
        string [] memory,
        string [] memory,
        string [] memory
    ) {
        Patient memory patient = patients[_patientAddress];
        return (patient.name, patient.age, patient.conditions, patient.allergies, patient.medications, patient.procedures);
    }

}