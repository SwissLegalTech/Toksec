var toksec = artifacts.require("Toksec");

module.exports = function(deployer) {
  // deployment steps
  deployer.deploy(toksec,"Mercedes AG", 4000).then(function(instance){console.log("Instance: ", instance); })
};