pragma solidity 0.5.10;
pragma experimental ABIEncoderV2;

contract MyContract {
 
   
    address[] public users;//usuarios organizadores,responsáveis por postar o gabarito
    address public master;//usuario owner(criador do contrato)
    constructor() public {
        master=msg.sender; //define owner
        users.push(msg.sender);//owner também é user(organizador)
        
    }
    
    function addUser(address newUser) public {//função para adicionar novo usuario organizador
        if(msg.sender==master){//somente o owner pode adicionar novo organizador
            users.push(newUser);
        }
        
        
    }
    
    function isUser(address ad) public view returns(bool){//função para verificar se uma carteira é de um organizador
        for(uint i=0;i<users.length;i++){
            if(ad==users[i]){
                return(true);
            }
            
        }
        
        return(false);
    }
    
    mapping(address=>int[]) public dataC;//dados das provas de cada candidato mapeados por seus endereços de carteira
    mapping(address=>int) public numberC;//numero embaralhador de cada candidato também mapeados por seus endereços
    int[] public gabarito; //declaração do gabarito oficial a ser definido depois 
    function submitRespostas(int[] memory respostas) public {//função para um candidato enviar suas respostas da prova
        for(uint i=0;i<respostas.length;i++){
            dataC[msg.sender].push(respostas[i]);//msg.sender=endereço da carteira
            
        }
        
    }
    //função para um organizador enviar o numero embaralhador do candidato vinculado ao address can
    function submitNumber(int number,address can) public {
            if(isUser(msg.sender)==true){//verifica se quem chama a função é um organizador
                numberC[can]=number;
            }
            

    }
    
    function submitGabarito(int[] memory vet) public {//função para enviar gabarito oficial da prova
            if(isUser(msg.sender)==true){//verifica se quem chama a função é um organizador
            for(uint i=0;i<vet.length;i++){
                gabarito.push(vet[i]);    
            }
            }

    }
    //função que corrige a prova do candidato com address "can" de acordo com seu numero embaralhador e o gabarito oficial 
    function corrige(address can) public view returns(uint){
        uint cont=0;
        for(uint i=0;i<dataC[can].length;i++){
            if((dataC[can][i]/numberC[can])==gabarito[i]){//retorna ao valor primário(desembaralhado) da resposta do candidato
                cont++;//contabiliza pontuação
            }
        }
        return(cont);
        
    }
    
}
