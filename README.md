# Toksec
Tokenisation of financial instruments with a focus on information of main stakeholders

## tokenised securities
Etherium currently is the leading technology for tokenising securities. When dealing tokenised securities under the new Etherium standard ERC1400, we thought it would be efficient to have compliance functions embedded. For the time being, we have built notification functions to comply with tax obligations and AML/CFT legislation implementing FATF recommendations (recommendation 24 in particular).

### embedded compliance while maintaining and even enhancing privacy
When trading tokenised shares on the Toksec platform, the client can opt to notify his tax authority and/or the register of the beneficial owners of the company whose share have been traded with one click on the relevant button. Privacy on the blockchain level is maintained because the client declares his public keys to the tax authority and/or the company's register of beneficial owners. Privacy can even be enhanced when using multiple public keys.

#### publicly available information on the blockchain of any trade in tokenised securities
The following information of any trade is publicly available:
- public key of the seller
- public key of the buyer
- unit price at the time of sale
- number of units traded

#### notification to tax authority
If the client chooses to notify his tax authority, the interface pulls all relevant information from the underlying smart contract, i.e.:
- public key of the seller
- identity of the seller (name, first name, address, tax residence)
- unit price at the time of acquisition

#### notification to the company's register of beneficial owners
If the client chooses to notify the register of beneficial owners of the company whose tokenised shares have been traded, the interface pulls all relevant information from the underlying smart contract, i.e.:
- public key of the buyer
- identity of the buyer (name, first name, address)
- time of acquisition
