pragma solidity 0.5.10;
pragma experimental ABIEncoderV2;

contract MyContract {
 
   
    address[] public users;
    address public master;
    constructor() public {
        master=msg.sender;
        users.push(msg.sender);
        
    }
    
    function addUser(address newUser) public {
        if(msg.sender==master){
            users.push(newUser);
        }
        
        
    }
    
    function isUser(address ad) public view returns(bool){
        for(uint i=0;i<users.length;i++){
            if(ad==users[i]){
                return(true);
            }
            
        }
        
        return(false);
    }
    
    mapping(address=>int[]) public dataC;
    mapping(address=>int) public numberC;
    int[] public gabarito;
    function submitRespostas(int[] memory respostas) public {
        for(uint i=0;i<respostas.length;i++){
            dataC[msg.sender].push(respostas[i]);
            
        }
        
    }
    
    function submitNumber(int number,address can) public {
            if(isUser(msg.sender)==true){
                numberC[can]=number;
            }
            

    }
    
    function submitGabarito(int[] memory vet) public {
            if(isUser(msg.sender)==true){
            for(uint i=0;i<vet.length;i++){
                gabarito.push(vet[i]);    
            }
            }

    }
    
    function corrige(address can) public view returns(uint){
        uint cont=0;
        for(uint i=0;i<dataC[can].length;i++){
            if((dataC[can][i]/numberC[can])==gabarito[i]){
                cont++;
            }
        }
        return(cont);
        
    }
    
}