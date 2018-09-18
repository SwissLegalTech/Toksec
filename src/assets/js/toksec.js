console.log("toksec loaded...");
toksec = { 
  web3Provider: null,
  // contracts:{},
  initWeb3: function() {
 
    if (typeof web3 !== 'undefined') {
      web3 = new Web3(web3.currentProvider);
    } else {
      //If no provider set, use local ganache
      web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));
    }
    // if (typeof web3 !== 'undefined') {
    //     toksec.web3Provider = web3.currentProvider;
    //   } else { 
    //     toksec.web3Provider = new Web3.providers.HttpProvider('http://localhost:8545');
    //   }
    //   web3 = new Web3(toksec.web3Provider);
    toksec.user = web3.eth.coinbase;
    $("#userBalance").text(web3.eth.getBalance(toksec.user).e);
    $("#userAddress").text(toksec.user);
    // web3.setProvider(new web3.providers.HttpProvider('http://' + BasicAuthUsername + ':' + BasicAuthPassword + '@localhost:8545'));
    return toksec.initContract();

  },
  initContract: function(){
    toksec.contract = web3.eth.contract([
      {
        "constant": true,
        "inputs": [],
        "name": "totalSupply",
        "outputs": [
          {
            "name": "",
            "type": "uint256"
          }
        ],
        "payable": false,
        "stateMutability": "view",
        "type": "function"
      },
      {
        "constant": false,
        "inputs": [
          {
            "name": "from",
            "type": "address"
          },
          {
            "name": "to",
            "type": "address"
          },
          {
            "name": "value",
            "type": "uint256"
          }
        ],
        "name": "transferFrom",
        "outputs": [
          {
            "name": "",
            "type": "bool"
          }
        ],
        "payable": false,
        "stateMutability": "nonpayable",
        "type": "function"
      },
      {
        "constant": true,
        "inputs": [
          {
            "name": "index",
            "type": "uint256"
          }
        ],
        "name": "offerInfo",
        "outputs": [
          {
            "name": "",
            "type": "uint256"
          },
          {
            "name": "",
            "type": "address"
          }
        ],
        "payable": false,
        "stateMutability": "view",
        "type": "function"
      },
      {
        "constant": true,
        "inputs": [],
        "name": "company",
        "outputs": [
          {
            "name": "",
            "type": "string"
          }
        ],
        "payable": false,
        "stateMutability": "view",
        "type": "function"
      },
      {
        "constant": true,
        "inputs": [
          {
            "name": "owner",
            "type": "address"
          }
        ],
        "name": "balanceOf",
        "outputs": [
          {
            "name": "",
            "type": "uint256"
          }
        ],
        "payable": false,
        "stateMutability": "view",
        "type": "function"
      },
      {
        "constant": false,
        "inputs": [
          {
            "name": "to",
            "type": "address"
          },
          {
            "name": "value",
            "type": "uint256"
          }
        ],
        "name": "transfer",
        "outputs": [
          {
            "name": "",
            "type": "bool"
          }
        ],
        "payable": false,
        "stateMutability": "nonpayable",
        "type": "function"
      },
      {
        "constant": false,
        "inputs": [
          {
            "name": "price",
            "type": "uint256"
          },
          {
            "name": "amount",
            "type": "uint256"
          }
        ],
        "name": "listOffer",
        "outputs": [],
        "payable": false,
        "stateMutability": "nonpayable",
        "type": "function"
      },
      {
        "constant": false,
        "inputs": [
          {
            "name": "offerNumber",
            "type": "uint256"
          },
          {
            "name": "amountPurchased",
            "type": "uint256"
          }
        ],
        "name": "buyOffer",
        "outputs": [],
        "payable": true,
        "stateMutability": "payable",
        "type": "function"
      },
      {
        "constant": true,
        "inputs": [],
        "name": "nbOffers",
        "outputs": [
          {
            "name": "",
            "type": "uint256"
          }
        ],
        "payable": false,
        "stateMutability": "view",
        "type": "function"
      },
      {
        "constant": false,
        "inputs": [
          {
            "name": "amount",
            "type": "uint256"
          }
        ],
        "name": "newIssuance",
        "outputs": [],
        "payable": false,
        "stateMutability": "nonpayable",
        "type": "function"
      },
      {
        "constant": true,
        "inputs": [],
        "name": "issuable",
        "outputs": [
          {
            "name": "",
            "type": "bool"
          }
        ],
        "payable": false,
        "stateMutability": "view",
        "type": "function"
      },
      {
        "inputs": [
          {
            "name": "company",
            "type": "string"
          },
          {
            "name": "nbShares",
            "type": "uint256"
          }
        ],
        "payable": false,
        "stateMutability": "nonpayable",
        "type": "constructor"
      },
      {
        "anonymous": false,
        "inputs": [
          {
            "indexed": true,
            "name": "from",
            "type": "address"
          },
          {
            "indexed": true,
            "name": "to",
            "type": "address"
          },
          {
            "indexed": false,
            "name": "value",
            "type": "uint256"
          }
        ],
        "name": "Transfer",
        "type": "event"
      },
      {
        "anonymous": false,
        "inputs": [
          {
            "indexed": true,
            "name": "owner",
            "type": "address"
          },
          {
            "indexed": true,
            "name": "spender",
            "type": "address"
          },
          {
            "indexed": false,
            "name": "value",
            "type": "uint256"
          }
        ],
        "name": "Approval",
        "type": "event"
      },
      {
        "anonymous": false,
        "inputs": [
          {
            "indexed": true,
            "name": "purchaser",
            "type": "address"
          },
          {
            "indexed": true,
            "name": "seller",
            "type": "address"
          },
          {
            "indexed": false,
            "name": "price",
            "type": "uint256"
          },
          {
            "indexed": false,
            "name": "amount",
            "type": "uint256"
          }
        ],
        "name": "toksecPurchase",
        "type": "event"
      }
    ]);

    toksec.instance = toksec.contract.at("0xd565adb65f1e73793229d24d9c68d1df29cd11be");
    // $.getJSON('Toksec.json', function(data) {
    //   // var artefact = data

    //   // console.log("data", data);
    //   // toksec.artefact = artefact;
    //   // console.log(TruffleContract(artefact))
    //   toksec.ctrct = TruffleContract(data);
    //   // // Set the provider for our contract.
    //   toksec.ctrct.setProvider(web3.currentProvider);
    //   // toksec.ctrct= web3.eth.contract(data.abi);

    //   // return App.markAdopted();
   
    //   // console.log("ctrc",toksec.ctrct);
    //   // toksec.ctrct=  web3.eth.contract(data.abi).at("0xd565adb65f1e73793229d24d9c68d1df29cd11be");


    //   return toksec.writeData();

  
    // });
    


    // $("#companyName").text( toksec.contract.company())
      toksec.writeData();
  },
  writeData: function(){
    toksec.refreshTime = new Date();
    $("#companyName").text(toksec.instance.company());
    $("#companyIdentifier").text("FR081240182431840");
    $(".companyNbShares").text(toksec.instance.totalSupply());

    $("#userShares").text(toksec.instance.balanceOf(web3.eth.coinbase));
    // toksec.ctrct.deployed().then(function(instance) {
    //   console.log("instace",instance)
    //   instance.company.call();
    // })
    // .then(function(companyName) {
    //   console.log(companyName);
    //   $("#companyName").text(companyName);

    //   })
    // .then(function(adopters) {
    //   for (i = 0; i < adopters.length; i++) {
    //     if (adopters[i] !== '0x0000000000000000000000000000000000000000') {
    //       $('.panel-pet').eq(i).find('button').text('Pending...').attr('disabled', true);
    //     }
    //   }
    // }).catch(function(err) {
    //   console.log(err.message);
    // });
  

  },
  initDashboardPageCharts: function() {

    var dataPreferences = {
        series: [
            [25, 30, 20, 25]
        ]
    };

    var optionsPreferences = {
        donut: true,
        donutWidth: 40,
        startAngle: 0,
        total: 100,
        showLabel: false,
        axisX: {
            showGrid: false
        }
    };

    Chartist.Pie('#chartPreferences', dataPreferences, optionsPreferences);

    Chartist.Pie('#chartPreferences', {
        labels: ['53%', '25%', '13%','9%'],
        series: [53, 25, 13, 9]
    });



  },
  showNotification: function(icon, text, type) {
    $.notify({
        icon: "nc-icon " + icon,
        message: "<br> <b>"+ text + "</b><br> ID: " + toksec.user + "<br>&nbsp;&nbsp&nbsp;&nbsp&nbsp;&nbsp;" + $("#name").val() + " " + $("#surname").val()
    }, {
        type: type,
        timer: 8000,
        placement: {
            from: "top",
            align: "right"
        }
    });
  },
};