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

    $("#userBalance").text(web3.eth.getBalance(web3.eth.coinbase).e);
    $("#userAddress").text(web3.eth.coinbase);
    // web3.setProvider(new web3.providers.HttpProvider('http://' + BasicAuthUsername + ':' + BasicAuthPassword + '@localhost:8545'));
    return toksec.initContract();

  },
  initContract: function(){
    $.getJSON('Toksec.json', function(data) {
      // var artefact = data

      // console.log("data", data);
      // toksec.artefact = artefact;
      // console.log(TruffleContract(artefact))
      toksec.ctrct = TruffleContract(data);
      // // Set the provider for our contract.
      toksec.ctrct.setProvider(web3.currentProvider);
      // toksec.ctrct= web3.eth.contract(data.abi);

      // return App.markAdopted();
   
      // console.log("ctrc",toksec.ctrct);
      // toksec.ctrct=  web3.eth.contract(data.abi).at("0xd565adb65f1e73793229d24d9c68d1df29cd11be");


      return toksec.writeData();

  
    });
    


    // $("#companyName").text( toksec.contract.company())

  },
  writeData: function(){
    // toksec.ctrct.company.call()
    toksec.ctrct.deployed().then(function(instance) {
      console.log("instace",instance)
      instance.company.call();
    })
    .then(function(companyName) {
      console.log(companyName);
      $("#companyName").text(companyName);

      }).catch(function(err) {
        console.log(err.message);
    });
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
        labels: ['53%', '36%', '11%'],
        series: [53, 36, 11]
    });



  }
};