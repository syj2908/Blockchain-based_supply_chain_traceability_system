contract Manager {
    address public id;
    string passwd;
    bool public valid = true;

    constructor(address _id, string memory _passwd) {
        id = _id;
        passwd = _passwd;
    }

    function deleteManager() public returns (bool) {
        valid = false;
        if (valid == false) return true;
        else return false;
    }

    //     function deleteLender(address id) public returns (bool) {
    //     //删除指定放贷者
    //     for (uint256 i = 0; i < lenders.length; i++) {
    //         if (lenders[i].id() == id) {
    //             bool result = lenders[i].deleteLender();
    //             emit DeleteLender(id, result);
    //             return result;
    //         }
    //     }
    // }

    // function deleteBorrower(address id) public returns (bool) {
    //     //删除指定借贷者
    //     for (uint256 i = 0; i < borrowers.length; i++) {
    //         if (borrowers[i].id() == id) {
    //             bool result = borrowers[i].deleteBorrower();
    //             emit DeleteBorrower(id, result);
    //             return result;
    //         }
    //     }
    // }

    // function deleteManager(address id) public returns (bool) {
    //     //删除指定管理员
    //     for (uint256 i = 0; i < lenders.length; i++) {
    //         if (managers[i].id() == id) {
    //             bool result = managers[i].deleteManager();
    //             emit DeleteManager(id, result);
    //             return result;
    //         }
    //     }
    // }
}
