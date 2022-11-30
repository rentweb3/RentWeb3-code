// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

/**
  Purpose       :   Create a sale contract that has presale and public sale features where you can set price of each NFT
  Pre-requisite :   whitelist contract address made by rentweb3 for presale part
  Compatible with ERC-721 standard ( ERC-1155 is coming soon )           
 */

// Help taken from Manav Vagdoda (vagdonic.github.io)


/**
  Purpose       :   Create a whitelist contract to perform whitelisting of NFT collection.
                    This will later be used by sale factory during presale to see if the person who wants to buy tokens is whitelisted or not. 
 */
interface IWhitelist {

    function addAddressToWhitelist()external  ;
    function getMaxWhitelistedAddresses() external returns (uint);
    function isWhitelisted(address user) external  returns (bool);
    function setWhitelistStartTime(uint _time)  external  ;
    function setWhitelistEndTime(uint _time) external ;
    function WhitelistByPrivilege(address _user)  external;
}

contract WhitelistFactory is IWhitelist{
    string public name;
    string public symbol;
    
    // Max number of whitelisted addresses allowed
    uint public maxWhitelistedAddresses;

    // Create a mapping of whitelistedAddresses
    // if an address is whitelisted, we would set it to true, it is false by default for all other addresses.
    mapping(address => bool) whitelistedAddresses;

    // numAddressesWhitelisted would be used to keep track of how many addresses have been whitelisted
    // NOTE: Don't change this variable name, as it will be part of verification
    uint public numAddressesWhitelisted;

    // Setting the Max number of whitelisted addresses
    // User will put the value at the time of deployment
    address public owner;
    // whitelist sales start and end time
    uint public startTime;
    uint public endTime;
    string public baseURI;
    uint public totalSupply;

    constructor(
        string memory _name,
        string memory _symbol,
        uint _maxWhitelistedAddresses,
        address _owner,
        string memory _baseURI,
        uint _totalSupply,
        uint _startTime,
        uint _endTime
        ) {
    // Demo Data for testing
    // "seemal","sam",100,0x7bD5EBac8A1dD13f3698C7ddFC77803CdE039BA6,"//ipfs/QmVK3Cnfpuou3rg71kgBFxqo1rSmsBvCFCw9upHntbQhU6/",10,1665933948,1668042730
        maxWhitelistedAddresses =  _maxWhitelistedAddresses;
        name=_name;
        symbol=_symbol;
        owner = _owner;
        baseURI=_baseURI;
        startTime=_startTime;
        endTime=_endTime;
        totalSupply=_totalSupply;
        
    }

    /**
        addAddressToWhitelist - This function adds the address of the sender to the
        whitelist
     */
    function addAddressToWhitelist() override external {
        // check if the user has already been whitelisted
        require(block.timestamp >= startTime,"Whitelisting has not started yet");
        require(block.timestamp < endTime,"Whitelisting has ended");
        
        require(!whitelistedAddresses[msg.sender], "Sender has already been whitelisted");
        // check if the numAddressesWhitelisted < maxWhitelistedAddresses, if not then throw an error.
        require(numAddressesWhitelisted < maxWhitelistedAddresses, "More addresses cant be added, limit reached");
        whitelistedAddresses[msg.sender] = true;       
        numAddressesWhitelisted += 1;

    }
    function WhitelistByPrivilege(address _user) override external onlyOwner{
        whitelistedAddresses[msg.sender] = true;
        numAddressesWhitelisted += 1;
        
    }
    modifier onlyOwner{
        require(msg.sender==owner);
        _;
    }

    function getMaxWhitelistedAddresses() override external view returns (uint){
        return maxWhitelistedAddresses;
    }
    function isWhitelisted(address user) override external  view returns (bool){
        return whitelistedAddresses[user]==true;
    }
   
    function setWhitelistStartTime(uint _time) override external onlyOwner  {
        startTime=_time;
    }
    function setWhitelistEndTime(uint _time) override external onlyOwner {
        endTime=_time;
    }

}
pragma solidity ^0.8.6;

/*
 It's an ERC-721 equivalent for Tron Blockchain 
 It's lengthy because we can not use pre-built smart contracts published on github and import them ( like openzeppelin)
 So we have  to write everything in a single file
For details about each function , visit TRC-721 documentation here at https://developers.tron.network/docs/trc-721 
*/

library SafeMath {
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    function sub(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    function div(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        uint256 c = a / b;

        return c;
    }

    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    function mod(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

contract Context {
    constructor() {}

    function _msgSender() internal view returns (address) {
        return msg.sender;
    }

    function _msgData() internal view returns (bytes memory) {
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        return msg.data;
    }
}

library Address {
    /**
     * @dev Converts an `address` into `address payable`. Note that this is
     * simply a type cast: the actual underlying value is not changed.
     *
     * _Available since v2.4.0._
     */
    function toPayable(address account) internal pure returns (address) {
        return address(uint160(account));
    }

    /**
     * @dev Replacement for Solidity's `transfer`: sends `amount` wei to
     * `recipient`, forwarding all available gas and reverting on errors.
     *
     * https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[Learn more].
     *
     * IMPORTANT: because control is transferred to `recipient`, care must be
     * taken to not create reentrancy vulnerabilities. Consider using
     * {ReentrancyGuard} or the
     * https://solidity.readthedocs.io/en/v0.5.11/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern].
     *
     * _Available since v2.4.0._
     */
}

library Counters {
    using SafeMath for uint256;

    struct Counter {
        // This variable should never be directly accessed by users of the library: interactions must be restricted to
        // the library's function. As of Solidity v0.5.2, this cannot be enforced, though there is a proposal to add
        // this feature: see https://github.com/ethereum/solidity/issues/4637
        uint256 _value; // default: 0
    }

    function current(Counter storage counter) internal view returns (uint256) {
        return counter._value;
    }

    function increment(Counter storage counter) internal {
        // The {SafeMath} overflow check can be skipped here, see the comment at the top
        counter._value += 1;
    }

    function decrement(Counter storage counter) internal {
        counter._value = counter._value.sub(1);
    }
}

abstract contract ITRC721 {
    event Transfer(
        address indexed from,
        address indexed to,
        uint256 indexed tokenId
    );
    event Approval(
        address indexed owner,
        address indexed approved,
        uint256 indexed tokenId
    );
    event ApprovalForAll(
        address indexed owner,
        address indexed operator,
        bool approved
    );

    /**
     * @dev Returns the number of NFTs in `owner`'s account.
     */
    function balanceOf(address owner)
        public
        view
        virtual
        returns (uint256 balance);

    /**
     * @dev Returns the owner of the NFT specified by `tokenId`.
     */
    function ownerOf(uint256 tokenId)
        public
        view
        virtual
        returns (address owner);

    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId
    ) public virtual;

    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) public virtual;

    function approve(address to, uint256 tokenId) public virtual;

    function getApproved(uint256 tokenId)
        public
        view
        virtual
        returns (address operator);

    function setApprovalForAll(address operator, bool _approved) public virtual;

    function isApprovedForAll(address owner, address operator)
        public
        view
        virtual
        returns (bool);

    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes memory data
    ) public virtual;
}

abstract contract ITRC721Metadata is ITRC721 {
    function name() external view virtual returns (string memory);

    function symbol() external view virtual returns (string memory);

    function tokenURI(uint256 tokenId)
        external
        view
        virtual
        returns (string memory);
}

contract TRC721 is Context, ITRC721 {
    using SafeMath for uint256;
    using Address for address;
    using Counters for Counters.Counter;

    bytes4 private constant _TRC721_RECEIVED = 0x5175f878;

    // Mapping from token ID to owner
    mapping(uint256 => address) private _tokenOwner;

    // Mapping from token ID to approved address
    mapping(uint256 => address) private _tokenApprovals;

    // Mapping from owner to number of owned token
    mapping(address => Counters.Counter) private _ownedTokensCount;

    // Mapping from owner to operator approvals
    mapping(address => mapping(address => bool)) private _operatorApprovals;

    bytes4 private constant _INTERFACE_ID_TRC721 = 0x80ac58cd;

    constructor() {
        // register the supported interfaces to conform to TRC721 via
        //        _registerInterface(_INTERFACE_ID_TRC721);
    }

    function balanceOf(address owner) public view override returns (uint256) {
        require(
            owner != address(0),
            "TRC721: balance query for the zero address"
        );

        return _ownedTokensCount[owner].current();
    }

    function ownerOf(uint256 tokenId) public view override returns (address) {
        address owner = _tokenOwner[tokenId];
        require(
            owner != address(0),
            "TRC721: owner query for nonexistent token"
        );

        return owner;
    }

    function approve(address to, uint256 tokenId) public override {
        address owner = ownerOf(tokenId);
        require(to != owner, "TRC721: approval to current owner");

        require(
            _msgSender() == owner || isApprovedForAll(owner, _msgSender()),
            "TRC721: approve caller is not owner nor approved for all"
        );

        _tokenApprovals[tokenId] = to;
        emit Approval(owner, to, tokenId);
    }

    function getApproved(uint256 tokenId)
        public
        view
        override
        returns (address)
    {
        require(
            _exists(tokenId),
            "TRC721: approved query for nonexistent token"
        );

        return _tokenApprovals[tokenId];
    }

    function setApprovalForAll(address to, bool approved) public override {
        require(to != _msgSender(), "TRC721: approve to caller");

        _operatorApprovals[_msgSender()][to] = approved;
        emit ApprovalForAll(_msgSender(), to, approved);
    }

    function isApprovedForAll(address owner, address operator)
        public
        view
        override
        returns (bool)
    {
        return _operatorApprovals[owner][operator];
    }

    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) public override {
        //solhint-disable-next-line max-line-length
        require(
            _isApprovedOrOwner(_msgSender(), tokenId),
            "TRC721: transfer caller is not owner nor approved"
        );

        _transferFrom(from, to, tokenId);
    }

    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId
    ) public override {
        safeTransferFrom(from, to, tokenId, "");
    }

    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes memory _data
    ) public override {
        require(
            _isApprovedOrOwner(_msgSender(), tokenId),
            "TRC721: transfer caller is not owner nor approved"
        );
        _safeTransferFrom(from, to, tokenId, _data);
    }

    function _safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes memory _data
    ) internal {
        _transferFrom(from, to, tokenId);
        //        require(_checkOnTRC721Received(from, to, tokenId, _data), "TRC721: transfer to non TRC721Receiver implementer");
    }

    function _exists(uint256 tokenId) internal view returns (bool) {
        address owner = _tokenOwner[tokenId];
        return owner != address(0);
    }

    function _isApprovedOrOwner(address spender, uint256 tokenId)
        internal
        view
        returns (bool)
    {
        require(
            _exists(tokenId),
            "TRC721: operator query for nonexistent token"
        );
        address owner = ownerOf(tokenId);
        return (spender == owner ||
            getApproved(tokenId) == spender ||
            isApprovedForAll(owner, spender));
    }

    function _safeMint(address to, uint256 tokenId) internal {
        _safeMint(to, tokenId, "");
    }

    function _safeMint(
        address to,
        uint256 tokenId,
        bytes memory _data
    ) internal {
        _mint(to, tokenId);
        //        require(_checkOnTRC721Received(address(0), to, tokenId, _data), "TRC721: transfer to non TRC721Receiver implementer");
    }

    function _mint(address to, uint256 tokenId) internal virtual {
        require(to != address(0), "TRC721: mint to the zero address");
        require(!_exists(tokenId), "TRC721: token already minted");

        _tokenOwner[tokenId] = to;
        _ownedTokensCount[to].increment();

        emit Transfer(address(0), to, tokenId);
    }

    function _burn(address owner, uint256 tokenId) internal virtual {
        require(
            ownerOf(tokenId) == owner,
            "TRC721: burn of token that is not own"
        );

        _clearApproval(tokenId);

        _ownedTokensCount[owner].decrement();
        _tokenOwner[tokenId] = address(0);

        emit Transfer(owner, address(0), tokenId);
    }

    function _burn(uint256 tokenId) internal virtual {
        _burn(ownerOf(tokenId), tokenId);
    }

    function _transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) internal virtual {
        require(
            ownerOf(tokenId) == from,
            "TRC721: transfer of token that is not own"
        );
        require(to != address(0), "TRC721: transfer to the zero address");

        _clearApproval(tokenId);

        _ownedTokensCount[from].decrement();
        _ownedTokensCount[to].increment();

        _tokenOwner[tokenId] = to;

        emit Transfer(from, to, tokenId);
    }

    function _clearApproval(uint256 tokenId) private {
        if (_tokenApprovals[tokenId] != address(0)) {
            _tokenApprovals[tokenId] = address(0);
        }
    }
}

contract TRC721Metadata is Context, TRC721, ITRC721Metadata {
    // Token name
    string private _name;

    // Token symbol
    string private _symbol;

    // Base URI
    string private _baseURI;

    // Optional mapping for token URIs
    mapping(uint256 => string) private _tokenURIs;

    bytes4 private constant _INTERFACE_ID_TRC721_METADATA = 0x5b5e139f;

    /**
     * @dev Constructor function
     */
    constructor(string memory name, string memory symbol) {
        _name = name;
        _symbol = symbol;

        // register the supported interfaces to conform to TRC721 via
        //_registerInterface(_INTERFACE_ID_TRC721_METADATA);
    }

    function name() external view override returns (string memory) {
        return _name;
    }

    function symbol() external view override returns (string memory) {
        return _symbol;
    }

    function tokenURI(uint256 tokenId)
        external
        view
        virtual
        override
        returns (string memory)
    {
        require(
            _exists(tokenId),
            "TRC721Metadata: URI query for nonexistent token"
        );

        string memory _tokenURI = _tokenURIs[tokenId];

        // Even if there is a base URI, it is only appended to non-empty token-specific URIs
        if (bytes(_tokenURI).length == 0) {
            return "";
        } else {
            // abi.encodePacked is being used to concatenate strings
            return string(abi.encodePacked(_baseURI, _tokenURI));
        }
    }

    function _setTokenURI(uint256 tokenId, string memory _tokenURI) internal {
        require(
            _exists(tokenId),
            "TRC721Metadata: URI set of nonexistent token"
        );
        _tokenURIs[tokenId] = _tokenURI;
    }

    function _setBaseURI(string memory baseURI) internal {
        _baseURI = baseURI;
    }

    function baseURI() virtual external view returns (string memory) {
        return _baseURI;
    }

    function _burn(address owner, uint256 tokenId) internal virtual override {
        super._burn(owner, tokenId);

        // Clear metadata (if any)
        if (bytes(_tokenURIs[tokenId]).length != 0) {
            delete _tokenURIs[tokenId];
        }
    }
}

/**
 * @title TRC721MetadataMintable
 * @dev TRC721 minting logic with metadata.
 */
abstract contract TRC721MetadataMintable is TRC721, TRC721Metadata {
    function _burn(address owner, uint256 tokenId)
        internal
        virtual
        override(TRC721, TRC721Metadata)
    {
        super._burn(owner, tokenId);
    }

    function mintWithTokenURI(
        address to,
        uint256 tokenId,
        string memory tokenURI
    ) public returns (bool) {
        _mint(to, tokenId);
        _setTokenURI(tokenId, tokenURI);
        return true;
    }
}

/**
 * @title TRC721Mintable
 * @dev TRC721 minting logic.
 */
contract TRC721Mintable is TRC721 {
    function mint(address to, uint256 tokenId) public returns (bool) {
        _mint(to, tokenId);
        return true;
    }

    function safeMint(address to, uint256 tokenId) public returns (bool) {
        _safeMint(to, tokenId);
        return true;
    }

    function safeMint(
        address to,
        uint256 tokenId,
        bytes memory _data
    ) public returns (bool) {
        _safeMint(to, tokenId, _data);
        return true;
    }
}

// "bitcoin prime x4","bitcoin3","ipfs://QmVK3Cnfpuou3rg71kgBFxqo1rSmsBvCFCw9upHntbQhU6/"

contract TRC721Complete is TRC721MetadataMintable {
    constructor(
        string memory name,
        string memory symbol,
        string memory _baseURI
    ) public TRC721Metadata(name, symbol) {
        _setBaseURI(_baseURI);
    }

    function _burn(address owner, uint256 tokenId)
        internal
        virtual
        override( TRC721MetadataMintable)
    {}
    
}

contract Sale is TRC721Complete{

    //    The Variable Names are simple enough to understand
    IWhitelist whitelistContract;    // an Interface object that we will use to access the already deployed whitelist contract through the deployed address
    uint256  openingTime;
    uint256  closingTime;
    address public  owner;
    uint256 public presaleMintRate;
    uint256 public publicMintRate;
    string public baseExtension = ".json";
    address PLATFORM_BENEFICIARY=0xbe68eE8a43ce119a56625d7E645AbAF74652d5E1; // the platform owner address that will receive the 1% tax on each mint.
    uint MINTING_FEE_FRACTION=100; // 100th fraction means  we are taking just 1% fee on each minting
   
    uint public totalSupply;
    mapping(uint =>uint) updatedNFTPrice;
    enum Stage {locked, presale, publicsale}

 // The modifier that when applied on functions , they can only be executed by the platform owner 
 // - one usecase can be the withdrawl of all the money present in smart contract by cutting minting fees
      
    modifier onlyBeneficiary{ 
      require(PLATFORM_BENEFICIARY==msg.sender);
      _;
    } 
    modifier onlyOwner{
        require(owner==msg.sender,"You are not the owner");
        _;
    }

    // demo data to initialize with
    // TVm22VuHmhxAuxN9f1LfpmrJTWS8aAYG9R,"Bitcoin Prime","bitcoin",TJHYbk7q2EuMJJZeEF6cxPBEDg9kG1sR1j,"ipfs://QmVK3Cnfpuou3rg71kgBFxqo1rSmsBvCFCw9upHntbQhU6/",1665914714,1665919507,1000000,1000000,10

    // It is Just a constructor accepting various parameters and initailizing some variables for future
    constructor(
      address whitelistContractAddress,
      string memory name,
      string memory symbol,
      address _owner,
      string memory _baseURI,
      uint startTime,
      uint endTime,
      uint _presaleMintRate,
      uint _publicMintRate,
      uint _totalSupply
      
      ) 
      TRC721Complete(name, symbol,_baseURI)
      {
      whitelistContract=IWhitelist(whitelistContractAddress); // accessing already deployed whitelist contract to lookup addresses if they are whitelisted when people attempt to mint tokens in Presale
      owner = _owner;
      PLATFORM_BENEFICIARY=msg.sender;
      openingTime=startTime;
      closingTime=endTime;
      presaleMintRate=_presaleMintRate;
      publicMintRate=_publicMintRate;
      totalSupply=_totalSupply;
              
    }

    
    // get NFT price based upon the current stage of sale ( Presale , public sale )
    // it also adds platform fee to the original price of the NFT to mint ( and that's how we earn )

    function getNFTPrice(uint tokenId)public view returns(uint){
      uint price=0;
      if(checkStage()==Stage.presale)
        price=presaleMintRate;
      
      else if (checkStage()==Stage.publicsale)
        price=publicMintRate;
      
      if(updatedNFTPrice[tokenId]!=0)
        price=updatedNFTPrice[tokenId];
        uint minting_fee = price/MINTING_FEE_FRACTION;
        price =  price+ minting_fee;

      return price;

    }

    // the Platform owner can withdraw all the money earned by the minting of NFTs
    function withdraw()public onlyBeneficiary{
           payable(PLATFORM_BENEFICIARY).transfer(address(this).balance);
    }
    // simple functionality by name
    function MintThisToken(uint tokenId)internal {
      // If the token is already minted , we can not mint again
     if(!_exists(tokenId)) 
        mintWithTokenURI(msg.sender,tokenId,string(abi.encodePacked( integerToString(tokenId) ,baseExtension) ) );
     
    }
    /*
    
     NFT Purchase according to the stage and mint status
     
     There can be two cases
     
          - Token is not minted
          - Token is already Minted and now it's ownership can be transferred      
    */

    function purchaseThisToken(uint tokenId)public payable{
      // can not mint before time
      require(checkStage()!=Stage.locked,"Sale has not started yet");
      if(checkStage()==Stage.presale){ 
           require(isWhitelisted(msg.sender),"PRESALE:You are not Whitelisted !");         
         }

      uint _price=getNFTPrice(tokenId);
      require(msg.value>=_price,"Insufficient Funds sent for Token Purchase");

      MintThisToken(tokenId);

      // For transfer of token , the users have to allow the smart contract for transfrerring their tokens

      if(ownerOf(tokenId)!=msg.sender){
        // if the token owner is has not approved smart contract that it can transfer tokens to any other person
        // the transfer / purchase will be failed
        require(getApproved(tokenId)==address(this),"Token is not available to transfer");
        address tokenOwner = ownerOf(tokenId);
        this.safeTransferFrom(ownerOf(tokenId),msg.sender,tokenId);
        // deducting the platform fee and sending ramaining amount to the owner of that token
        _price=updatedNFTPrice[tokenId];
        uint minting_fee = _price/MINTING_FEE_FRACTION;
        uint amountToSend = _price- minting_fee;
        payable(tokenOwner).transfer(amountToSend);

      }
      else{
         payable(PLATFORM_BENEFICIARY).transfer(_price);
      }

    }

    // The NFT owner can set the price of NFT that it can be purchased for
    function setNFTPrice(uint tokenId,uint price)public {
      require(ownerOf(tokenId)==msg.sender,"Only Owners can change Price of NFT");
      updatedNFTPrice[tokenId]=price;

    }

  

   




  // The Creator can start a sale after initial presale and public sale 
  function TimedCrowdsale(uint256 _openingTime, uint256 _closingTime) public onlyOwner{
    require(_openingTime >= block.timestamp,"Invalid Sale Opening Time");
    require(_closingTime >= _openingTime,"Invalid Sale Closing Time");
    openingTime = _openingTime;
    closingTime = _closingTime;
  }

// Helping and Utility functions
  
    function integerToString(uint256 _i) internal pure returns (string memory str) {
      if (_i == 0)
      {
        return "0";
      }
      uint256 j = _i;
      uint256 length;
      while (j != 0)
      {
        length++;
        j /= 10;
      }
      bytes memory bstr = new bytes(length);
      uint256 k = length;
      j = _i;
      while (j != 0)
      {
        bstr[--k] = bytes1(uint8(48 + j % 10));
        j /= 10;
      }
      str = string(bstr);
}


    function checkStage() public view returns (Stage stage){
      if(block.timestamp < openingTime) {
        stage = Stage.locked;
        return stage;
      }
      else if(block.timestamp >= openingTime && block.timestamp <= closingTime) {
        stage = Stage.presale;
        return stage;
      }
      else if(block.timestamp >= closingTime) {
        stage = Stage.publicsale;
        return stage;
        }
    }

    // Check if some address is whitelisted 
    function isWhitelisted(address addressToCheck) public returns (bool) {
    if(whitelistContract.isWhitelisted(addressToCheck))
        return true;
    return false;

    }

    // Platform Owner can set the address in which he / she can receive funds from smart contracts 
    function setPLATFORM_BENEFICIARY(address newBeneficiary)public onlyBeneficiary{
      PLATFORM_BENEFICIARY=newBeneficiary;
    }
    // Set NFT Minting fee in fraction
    // 100 means 100/100 = 1%
    // 10 means 100/10   = 10%
    // 20 means 100/20   = 5%

    function setMINTING_FEE_FRACTION(uint newFee)public onlyBeneficiary{
      MINTING_FEE_FRACTION=newFee;
    }
    function startTime()public view returns(uint){
      return openingTime;
    }
    
    function endTime()public view returns(uint){
      return closingTime;
    }
    function isTokenIdExists(uint tokenId)public view returns(bool){
      if(_exists(tokenId)==true)
        return true;
      return false;
    }
    
}
