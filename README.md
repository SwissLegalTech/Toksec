# Toksec

Tokenisation of financial instruments with a focus on information of main stakeholders

## Tokenised securities

Tokenised Securities are the the digital transcription, generally on a blockchain platform, of existing financial titles. On the one hand the conversion to those new platforms induce legal and technical challenges. On the other hand, they are expected to facilitate trading, reduce paperwork, allievate regulatory hurdles, and ultimately reshape existing markets. 

## Embedded compliance while maintaining and even enhancing privacy

Toksec is a platform designed to facilitate the trading of tokenised securities with built in notification functions to comply with tax obligations and AML/CFT legislation implementing FATF recommendations (recommendation 24 in particular). When trading tokenised shares on the Toksec platform, only volumes, prices and public keys are stored on the platform. The user can opt to notify his tax authority and/or the register of the beneficial owners of the company whose share have been traded with one click. Privacy is maintained as personnal information and reporting happens only off-chain and on a voluntary basis, as it is the case currently. Privacy can even be enhanced when using multiple public keys.

### Publicly available information on the blockchain of any trade in tokenised securities

In the current implementation, the following information of any trade is publicly available:

- Public key of the seller
- Public key of the buyer
- Unit price at the time of sale
- Number of units traded
- Date and time of the trade

### Notification to tax authority

If the user chooses to notify his tax authority, the interface pulls all relevant information, i.e.:

- Public key of the seller
- Identity of the seller (first name, last name, address, tax residence)
- Unit selling price and at the time of acquisition

#### Notification to the company's register of beneficial owners

If the user chooses to notify the register of beneficial owners of the company whose tokenised shares have been traded, the interface pulls all relevant information, i.e.:

- Public key of the buyer
- Identity of the buyer (first name, last name, address, country of residence)
- Time of acquisition

## Technical aspects

Toksec is a web platform in conjuction with an Ethereum Smart Contract. The Smart Contract is compliant with the ERC20 standard and aims to implement the upcoming ERC1400 standard, with additionnal compliance functions. It leverages openzeppelin libraries.

## Contact Us

If you are interested in the project, feel free to contact us :

- Xavier Lavayssière - xavier @ ecan . fr
- Ralph Sutter - sutter.ralph @ epost . ch