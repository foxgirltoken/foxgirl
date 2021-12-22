/**
 *Submitted for verification at BscScan.com on 2021-12-17
*/

// SPDX-License-Identifier: Unlicensed 
// Unlicensed is not Open Source, can not be used/forked without permission 
// Contract created for https://Foxgirl.com by https://gentokens.com/ 


/*

  ______           _____ _      _ 
 |  ____|         / ____(_)    | |
 | |__ _____  __ | |  __ _ _ __| |
 |  __/ _ \ \/ / | | |_ | | '__| |
 | | | (_) >  <  | |__| | | |  | |
 |_|  \___/_/\_\  \_____|_|_|  |_|
                                  
                       
FoxGirl Token

https://Foxgirl.com
https://t.me/foxgirltoken

Name: FoxGirl
Symbol: FOXGIRL
Supply: 100,000,000,000,000

FoxGirl aims to be a leader in providing unique utility and features to the entire crypto space.
A platform for innovative products, a massive NFT marketplace, amazing games, comics, token listings,
verified token developers, utility bots, and so much more!
                                                                                                         
*/

pragma solidity 0.8.10;

interface IERC20 {
    
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

library SafeMath {
    

    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        return a + b;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return a - b;
    }

    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        return a * b;
    }
    
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return a / b;
    }

    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        unchecked {
            require(b <= a, errorMessage);
            return a - b;
        }
    }
    
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a / b;
        }
    }
    
}


abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        this; 
        return msg.data;
    }
}


library Address {
    
    function isContract(address account) internal view returns (bool) {
        uint256 size;
        assembly { size := extcodesize(account) }
        return size > 0;
    }

    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");
        (bool success, ) = recipient.call{ value: amount }("");
        require(success, "Address: unable to send value, recipient may have reverted");
    }
    
    function functionCall(address target, bytes memory data) internal returns (bytes memory) {
      return functionCall(target, data, "Address: low-level call failed");
    }
    
    function functionCall(address target, bytes memory data, string memory errorMessage) internal returns (bytes memory) {
        return functionCallWithValue(target, data, 0, errorMessage);
    }
    
    function functionCallWithValue(address target, bytes memory data, uint256 value) internal returns (bytes memory) {
        return functionCallWithValue(target, data, value, "Address: low-level call with value failed");
    }
    
    function functionCallWithValue(address target, bytes memory data, uint256 value, string memory errorMessage) internal returns (bytes memory) {
        require(address(this).balance >= value, "Address: insufficient balance for call");
        require(isContract(target), "Address: call to non-contract");
        (bool success, bytes memory returndata) = target.call{ value: value }(data);
        return _verifyCallResult(success, returndata, errorMessage);
    }
    
    function functionStaticCall(address target, bytes memory data) internal view returns (bytes memory) {
        return functionStaticCall(target, data, "Address: low-level static call failed");
    }
    
    function functionStaticCall(address target, bytes memory data, string memory errorMessage) internal view returns (bytes memory) {
        require(isContract(target), "Address: static call to non-contract");
        (bool success, bytes memory returndata) = target.staticcall(data);
        return _verifyCallResult(success, returndata, errorMessage);
    }


    function functionDelegateCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionDelegateCall(target, data, "Address: low-level delegate call failed");
    }
    
    function functionDelegateCall(address target, bytes memory data, string memory errorMessage) internal returns (bytes memory) {
        require(isContract(target), "Address: delegate call to non-contract");
        (bool success, bytes memory returndata) = target.delegatecall(data);
        return _verifyCallResult(success, returndata, errorMessage);
    }

    function _verifyCallResult(bool success, bytes memory returndata, string memory errorMessage) private pure returns(bytes memory) {
        if (success) {
            return returndata;
        } else {
            if (returndata.length > 0) {
                 assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert(errorMessage);
            }
        }
    }
}



interface IUniswapV2Factory {
    event PairCreated(address indexed token0, address indexed token1, address pair, uint);
    function feeTo() external view returns (address);
    function feeToSetter() external view returns (address);
    function getPair(address tokenA, address tokenB) external view returns (address pair);
    function allPairs(uint) external view returns (address pair);
    function allPairsLength() external view returns (uint);
    function createPair(address tokenA, address tokenB) external returns (address pair);
    function setFeeTo(address) external;
    function setFeeToSetter(address) external;
}

interface IUniswapV2Pair {
    event Approval(address indexed owner, address indexed spender, uint value);
    event Transfer(address indexed from, address indexed to, uint value);
    function name() external pure returns (string memory);
    function symbol() external pure returns (string memory);
    function decimals() external pure returns (uint8);
    function totalSupply() external view returns (uint);
    function balanceOf(address owner) external view returns (uint);
    function allowance(address owner, address spender) external view returns (uint);
    function approve(address spender, uint value) external returns (bool);
    function transfer(address to, uint value) external returns (bool);
    function transferFrom(address from, address to, uint value) external returns (bool);
    function DOMAIN_SEPARATOR() external view returns (bytes32);
    function PERMIT_TYPEHASH() external pure returns (bytes32);
    function nonces(address owner) external view returns (uint);
    function permit(address owner, address spender, uint value, uint deadline, uint8 v, bytes32 r, bytes32 s) external;
    event Burn(address indexed sender, uint amount0, uint amount1, address indexed to);
    event Swap(
        address indexed sender,
        uint amount0In,
        uint amount1In,
        uint amount0Out,
        uint amount1Out,
        address indexed to
    );
    event Sync(uint112 reserve0, uint112 reserve1);
    function MINIMUM_LIQUIDITY() external pure returns (uint);
    function factory() external view returns (address);
    function token0() external view returns (address);
    function token1() external view returns (address);
    function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);
    function price0CumulativeLast() external view returns (uint);
    function price1CumulativeLast() external view returns (uint);
    function kLast() external view returns (uint);
    function burn(address to) external returns (uint amount0, uint amount1);
    function swap(uint amount0Out, uint amount1Out, address to, bytes calldata data) external;
    function skim(address to) external;
    function sync() external;
    function initialize(address, address) external;
}

interface IUniswapV2Router01 {
    function factory() external pure returns (address);
    function WETH() external pure returns (address);
    function addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB, uint liquidity);
    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external payable returns (uint amountToken, uint amountETH, uint liquidity);
    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETH(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountToken, uint amountETH);
    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETHWithPermit(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountToken, uint amountETH);
    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapTokensForExactTokens(
        uint amountOut,
        uint amountInMax,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapExactETHForTokens(uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);
    function swapTokensForExactETH(uint amountOut, uint amountInMax, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
    function swapExactTokensForETH(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
    function swapETHForExactTokens(uint amountOut, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);

    function quote(uint amountA, uint reserveA, uint reserveB) external pure returns (uint amountB);
    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) external pure returns (uint amountOut);
    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) external pure returns (uint amountIn);
    function getAmountsOut(uint amountIn, address[] calldata path) external view returns (uint[] memory amounts);
    function getAmountsIn(uint amountOut, address[] calldata path) external view returns (uint[] memory amounts);
}

interface IUniswapV2Router02 is IUniswapV2Router01 {
    function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountETH);
    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountETH);

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable;
    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
}



contract FoxGirl is Context, IERC20 { 
    using SafeMath for uint256;
    using Address for address;



    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    function owner() public view virtual returns (address) {
        return _owner;
    }

    modifier onlyOwner() {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    function renounceOwnership() public virtual onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }


    /*

    Transfer Contract Ownership

    */


    event newContractOwner(address indexed previousOwner, address indexed newOwner);
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");

        // Remove previous owner mappings 
        _isLimitExempt[owner()] = false;
        _isExcludedFromFee[owner()] = false;
        _preLaunchAccess[owner()] = false;

        emit newContractOwner(_owner, newOwner);
        _owner = newOwner;

        // Add new owner mappings 
        _isLimitExempt[newOwner] = true;
        _isExcludedFromFee[newOwner] = true;
        _preLaunchAccess[newOwner] = true;
    }



    mapping (address => uint256) private _tOwned;
    mapping (address => mapping (address => uint256)) private _allowances;
    mapping (address => bool) public _isExcludedFromFee; 
    mapping (address => bool) public _preLaunchAccess;
    mapping (address => bool) public _isLimitExempt;

    // Blacklist: If 'noBlackList' is true wallets on this list can not buy - used for known bots
    mapping (address => bool) public _isBlacklisted;

    // Set contract so that blacklisted wallets cannot buy 
    bool public noBlackList = true;

    /*

    Meet the wallets...

    Wallet_FoxGirl: Team, Marketing & Development
    Wallet_Tokens:  Team Tokens, Promotions & Giveaways
    Wallet_LP:      Cake LP Destination Wallet for Auto Liquidity
    Wallet_Burn:    Tracking Burned Tokens to Reduce Total Supply
    
    */

    address payable public Wallet_FoxGirl = payable(0xec7D683353DAe73FE7ec79f9d71324A35c3286F9); 
    address payable public Wallet_LP = payable(0x9F9cE3a784D1b327296Cd2A351aB7C6DE5A68bd2);
    address payable public Wallet_Tokens = payable(0x9F9cE3a784D1b327296Cd2A351aB7C6DE5A68bd2); 
    address payable public constant Wallet_Burn = payable(0x000000000000000000000000000000000000dEaD); 


    uint256 private constant MAX = ~uint256(0);
    uint8 private constant _decimals = 18;
    uint256 private _tTotal = 10**14 * 10**_decimals;
    uint256 private OriginalSupply = _tTotal;
    string private constant _name = "FoxGirl"; 
    string private constant _symbol = unicode"FOXGIRL"; 

    // Counter for liquify trigger
    uint8 private txCount = 0;
    uint8 private swapTrigger = 10; 

    // Setting the initial fees
    uint256 public _Tax_On_Buy = 10;
    uint256 public _Tax_On_Sell = 10;

    // Fee distribution (total must = 100%)
    uint256 public Percent_FoxGirl = 70;
    uint256 public Percent_Burn = 0;
    uint256 public Percent_Token_Wallet = 10;
    uint256 public Percent_AutoLP = 20; 

    // Max possible fee on buy and sell
    uint256 public constant _Tax_On_Buy_MAX = 12; 
    uint256 public constant _Tax_On_Sell_MAX = 15;

    uint256 private swapBlock;
    bool public TradeOpen;


    // Wallet limits 
    

    // Max wallet holding (4% at launch)
    uint256 public _maxWalletToken = _tTotal * 4 / 100;
    uint256 private _previousMaxWalletToken = _maxWalletToken;

    // Maximum transaction amount (4% at launch)
    uint256 public _maxTxAmount = _tTotal * 4 / 100; 
    uint256 private _previousMaxTxAmount = _maxTxAmount;
                                     
                                     
    IUniswapV2Router02 public uniswapV2Router;
    address public uniswapV2Pair;
    bool public inSwapAndLiquify;
    bool public swapAndLiquifyEnabled = true;
    
    event SwapAndLiquifyEnabledUpdated(bool true_or_false);
    event SwapAndLiquify(
        uint256 tokensSwapped,
        uint256 ethReceived,
        uint256 tokensIntoLiqudity
        
    );
    
    modifier lockTheSwap {
        inSwapAndLiquify = true;
        _;
        inSwapAndLiquify = false;
    }
    
    constructor () {

        _owner = 0xec7D683353DAe73FE7ec79f9d71324A35c3286F9;
        emit OwnershipTransferred(address(0), _owner);

        _tOwned[owner()] = _tTotal;
        
        IUniswapV2Router02 _uniswapV2Router = IUniswapV2Router02(0x10ED43C718714eb63d5aA57B78B54704E256024E); 
        //IUniswapV2Router02 _uniswapV2Router = IUniswapV2Router02(0x9Ac64Cc6e4415144C455BD8E4837Fea55603e5c3); // TESTNET BSC        

        uniswapV2Pair = IUniswapV2Factory(_uniswapV2Router.factory())
            .createPair(address(this), _uniswapV2Router.WETH());
        uniswapV2Router = _uniswapV2Router;

    
        /*

        Set initial wallet mappings

        */


        // Wallet that are excluded from holding limits
        _isLimitExempt[owner()] = true;
        _isLimitExempt[address(this)] = true;
        _isLimitExempt[Wallet_FoxGirl] = true; 
        _isLimitExempt[Wallet_Burn] = true;


        // Wallets that are excluded from fees
        _isExcludedFromFee[owner()] = true;
        _isExcludedFromFee[address(this)] = true;
        _isExcludedFromFee[Wallet_FoxGirl] = true; 
        _isExcludedFromFee[Wallet_Burn] = true;

        // Wallets granted access before trade is oopen
        _preLaunchAccess[owner()] = true;

        emit Transfer(address(0), owner(), _tTotal);

    }

    function name() public pure returns (string memory) {
        return _name;
    }

    function symbol() public pure returns (string memory) {
        return _symbol;
    }

    function decimals() public pure returns (uint8) {
        return _decimals;
    }

    function totalSupply() public view override returns (uint256) {
        return _tTotal;
    }

    function balanceOf(address account) public view override returns (uint256) {
        return _tOwned[account];
    }

    function transfer(address recipient, uint256 amount) public override returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    function allowance(address theOwner, address theSpender) public view override returns (uint256) {
        return _allowances[theOwner][theSpender];
    }

    function approve(address spender, uint256 amount) public override returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(sender, _msgSender(), _allowances[sender][_msgSender()].sub(amount, "ERC20: transfer amount exceeds allowance"));
        return true;
    }

    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
        _approve(_msgSender(), spender, _allowances[_msgSender()][spender].add(addedValue));
        return true;
    }

    function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {
        _approve(_msgSender(), spender, _allowances[_msgSender()][spender].sub(subtractedValue, "ERC20: decreased allowance below zero"));
        return true;
    }

    

    // Turn fess on/off for a wallet - Default is false (Wallets pay fees!)
    event wallet_is_excluded_from_fee(address Wallet_Address, bool true_or_false);
    function excluded_From_Fee(address Wallet_Address, bool true_or_false) public onlyOwner {
        _isExcludedFromFee[Wallet_Address] = true_or_false;
        emit wallet_is_excluded_from_fee(Wallet_Address, true_or_false);

    }
    


    /*

    Blacklist - This is used to block a person from buying - known bot users are added to this
    list prior to launch. We also check for people using snipe bots on the contract before we
    add liquidity and block these wallets. We like all of our buys to be natural and fair.

    */

    // Blacklist - block wallets (ADD - COMMA SEPARATE MULTIPLE WALLETS)
    function blacklist_Add_Wallets(address[] calldata addresses) external onlyOwner {
       
        uint256 startGas;
        uint256 gasUsed;

    for (uint256 i; i < addresses.length; ++i) {
        if(gasUsed < gasleft()) {
        startGas = gasleft();
        if(!_isBlacklisted[addresses[i]]){
        _isBlacklisted[addresses[i]] = true;}
        gasUsed = startGas - gasleft();
    }
    }
    }



    // Blacklist - block wallets (REMOVE - COMMA SEPARATE MULTIPLE WALLETS)
    function blacklist_Remove_Wallets(address[] calldata addresses) external onlyOwner {
       
        uint256 startGas;
        uint256 gasUsed;

    for (uint256 i; i < addresses.length; ++i) {
        if(gasUsed < gasleft()) {
        startGas = gasleft();
        if(_isBlacklisted[addresses[i]]){
        _isBlacklisted[addresses[i]] = false;}
        gasUsed = startGas - gasleft();
    }
    }
    }


    /*

    You can turn the blacklist restrictions on and off.

    During launch, it's a good idea to block known bot users from buying. But these are real people, so 
    when the contract is safe (and the price has increased) you can allow these wallets to buy/sell by setting
    noBlackList to false

    */


    //Blacklist Switch - Turn on/off blacklisted wallet restrictions 
    event blacklisted_wallets_blocked(bool true_or_false);
    function blacklist_Switch(bool true_or_false) public onlyOwner {
        noBlackList = true_or_false;
        emit blacklisted_wallets_blocked(true_or_false);
    } 



    /*

    Manually set mappings

    */


    // Pre Launch Access - able to buy and sell before the trade is open 
    event wallet_pre_launch_access(address Wallet_Address, bool true_or_false);
    function mapping_preLaunchAccess(address Wallet_Address, bool true_or_false) external onlyOwner() {    
        _preLaunchAccess[Wallet_Address] = true_or_false;
        emit wallet_pre_launch_access(Wallet_Address, true_or_false);
    }

    // Add wallet to limit exempt list 
    event wallet_limit_exempt(address Wallet_Address, bool true_or_false);
    function mapping_LimitExempt(address Wallet_Address, bool true_or_false) external onlyOwner() {  
        _isLimitExempt[Wallet_Address] = true_or_false;
        emit wallet_limit_exempt(Wallet_Address, true_or_false);
    }


    /*
    
    When sending tokens to another wallet (not buying or selling) if noFeeToTransfer is true there will be no fee

    */


    bool public noFeeToTransfer = true;

    // Option to set fee or no fee for transfer (just in case the no fee transfer option is exploited in future!)
    // True = there will be no fees when moving tokens around or giving them to friends! (There will only be a fee to buy or sell)
    // False = there will be a fee when buying/selling/tranfering tokens
    // Default is true

    event noFeeOnTransfer(bool true_or_false);
    function set_Transfers_Without_Fees(bool true_or_false) external onlyOwner {
        noFeeToTransfer = true_or_false;
        emit noFeeOnTransfer(true_or_false);
    }

    
    // isPair - Add to pair (set to true) OR Remove from pair (set to false)

    mapping (address => bool) public _isPair;

    /*

    Setting as a pair indicates that it is an address used by an exchange to buy or sell tokens. 
    This setting is used so that we can have no-fee transfers between wallets but new
    pairings will take a fee on buys and sell

    */
 
    event wallet_set_as_pair(address Wallet_Address, bool true_or_false);
    function set_as_Pair(address Wallet_Address, bool true_or_false) external onlyOwner {
        _isPair[Wallet_Address] = true_or_false;
        emit wallet_set_as_pair(Wallet_Address, true_or_false);
    }



    /*

    FEES  

    */

    event setting_fees(uint256 Tax_On_Buy, uint256 Tax_On_Sell);
    function _set_Fees(uint256 Tax_On_Buy, uint256 Tax_On_Sell) external onlyOwner() {

  
        require(Tax_On_Buy <= _Tax_On_Buy_MAX, "Buy fee too high!");
        require(Tax_On_Sell <= _Tax_On_Sell_MAX, "Sell fee too high!");

        _Tax_On_Buy = Tax_On_Buy;
        _Tax_On_Sell = Tax_On_Sell;
        emit setting_fees(Tax_On_Buy, Tax_On_Sell);

    }


    function _set_Fee_Distribution_Percent__Total_100(uint256 FoxGirl_Wallet, uint256 Auto_Liquidity, uint256 Token_Wallet, uint256 Auto_Burn) external onlyOwner() {

        require((FoxGirl_Wallet + Auto_Liquidity + Token_Wallet + Auto_Burn) == 100, "Must add up to 100!");
   
        Percent_FoxGirl = FoxGirl_Wallet;
        Percent_Burn = Auto_Burn;
        Percent_Token_Wallet = Token_Wallet;
        Percent_AutoLP = Auto_Liquidity; 
        
    }


    /*

    Updating Wallets

    */


    //Update the FoxGirl wallet
    event updatedFoxGirlWallet(address indexed oldWallet, address indexed newWallet);
    function Wallet_Update_FoxGirl(address payable wallet) external onlyOwner() {
        // Can't be zero address
        require(wallet != address(0), "new wallet is the zero address");
        emit updatedFoxGirlWallet(Wallet_FoxGirl,wallet);

        // Update mapping on old wallet
        _isExcludedFromFee[Wallet_FoxGirl] = false; 

        Wallet_FoxGirl = wallet;
        // Update mapping on new wallet
        _isExcludedFromFee[Wallet_FoxGirl] = true;
    }

    //Update the Token wallet 
    event updatedTokenWallet(address indexed oldWallet, address indexed newWallet);
    function Wallet_Update_Tokens(address payable wallet) external onlyOwner() {
        // Can't be zero address
        require(wallet != address(0), "new wallet is the zero address");      
        emit updatedTokenWallet(Wallet_Tokens,wallet);
        Wallet_Tokens = wallet;

    }
   
    
    /*

    SwapAndLiquify Switches

    */
    
    // Toggle on and off to activate auto liquidity and the promo wallet 
    function set_Swap_And_Liquify_Enabled(bool true_or_false) public onlyOwner {
        swapAndLiquifyEnabled = true_or_false;
        emit SwapAndLiquifyEnabledUpdated(true_or_false);
    }

    // This will set the number of transactions required before the 'swapAndLiquify' function triggers
    event TokenTriggerNumberUpdate(uint8 number_of_transactions);
    function set_Number_Of_Transactions_Before_Liquify_Trigger(uint8 number_of_transactions) public onlyOwner {
        swapTrigger = number_of_transactions;
        emit TokenTriggerNumberUpdate(number_of_transactions);

    }
    


    // This function is required so that the contract can receive BNB from pancakeswap
    receive() external payable {}


    /*

    Wallet Limits

    */

    // Set the Max transaction (as percent of original supply) - Must be whole number, can not enter decimals
    event set_Max_Trans_Percent(uint256  max_Transaction_Percent);
    function set_Max_Transaction_Percent(uint256 max_Transaction_Percent) external onlyOwner() {

        _maxTxAmount = OriginalSupply * max_Transaction_Percent / 100;
        emit set_Max_Trans_Percent(_maxTxAmount);
    }

    
    // Set the maximum permitted wallet holding (as percent of original supply)
    event set_Max_Hold_Percent(uint256  max_Wallet_Holding_Percent);
    function set_Max_Wallet_Holding_Percent(uint256 max_Wallet_Holding_Percent) external onlyOwner() {

        _maxWalletToken = OriginalSupply * max_Wallet_Holding_Percent / 100;
        emit set_Max_Hold_Percent(_maxWalletToken);
    }


    // Open Trade - ONE WAY SWITCH! 
    function openTrade() external onlyOwner() {
        TradeOpen = true;
    }


    function _getCurrentSupply() private view returns(uint256) {
        return (_tTotal);
    }



    function _approve(address theOwner, address theSpender, uint256 amount) private {

        require(theOwner != address(0) && theSpender != address(0), "ERR: zero address");
        _allowances[theOwner][theSpender] = amount;
        emit Approval(theOwner, theSpender, amount);

    }

    function _transfer(
        address from,
        address to,
        uint256 amount
    ) private {



        if (!TradeOpen){
        require(_preLaunchAccess[from] || _preLaunchAccess[to], "Trade is not open yet, please come back later");
        }


        /*

        BLACKLIST RESTRICTIONS

        */
        
        if (noBlackList){
        require(!_isBlacklisted[from] && !_isBlacklisted[to], "This address is blacklisted. Transaction reverted.");
        }


        /*

        TRANSACTION AND WALLET LIMITS

        */
        

        // Limit wallet total
        if (!_isLimitExempt[to] &&
            from != owner()){
            uint256 heldTokens = balanceOf(to);
            require((heldTokens + amount) <= _maxWalletToken,"You are trying to buy too many tokens. You have reached the limit for one wallet.");}


        // Limit the maximum number of tokens that can be bought or sold in one transaction
        if (from != owner() && to != owner())
            require(amount <= _maxTxAmount, "You are trying to buy more than the max transaction limit.");


        require(from != address(0) && to != address(0), "ERR: Using 0 address!");
        require(amount > 0, "Token value must be higher than zero.");


        // SwapAndLiquify is triggered after every X transactions - this number can be adjusted using swapTrigger
        

        if(
            txCount >= swapTrigger && 
            !inSwapAndLiquify &&
            !_isPair[from] &&
            swapAndLiquifyEnabled &&
            block.number > swapBlock
            )
        {  
            
            
            uint256 contractTokenBalance = balanceOf(address(this));
            if(contractTokenBalance > _maxTxAmount) {contractTokenBalance = _maxTxAmount;}
            txCount = 0;
            swapAndLiquify(contractTokenBalance);
            swapBlock = block.number;
        }
        

        // Do we need to charge a fee?
        bool takeFee = true;
        bool isBuy;
        if(_isExcludedFromFee[from] || _isExcludedFromFee[to] || (noFeeToTransfer && !_isPair[to] && !_isPair[from])){
            takeFee = false;
        } else {
         
            // Buy or Sell Tax
            if(_isPair[from]){
                isBuy = true;
            }

            txCount++;

        }

        _tokenTransfer(from, to, amount, takeFee, isBuy);

    }
    
    function sendToWallet(address payable wallet, uint256 amount) private {
            wallet.transfer(amount);

        }


    function swapAndLiquify(uint256 contractTokenBalance) private lockTheSwap {


        // Distribute the accumuated fees based on the fee allocation percents

        // Process 'Token Fees' First

        if (Percent_Token_Wallet != 0){

            // Send Tokens to the token wallet - used for team tokens and giveaway promotions
            uint256 tokens_to_Wallet = contractTokenBalance * Percent_Token_Wallet / 100;
            _tOwned[Wallet_Tokens] = _tOwned[Wallet_Tokens] + tokens_to_Wallet; 
            _tOwned[address(this)] = _tOwned[address(this)] - tokens_to_Wallet;   
        
        }


        if (Percent_Burn != 0){

            // Send Tokens to the Burn Wallet 
            uint256 tokens_to_Burn = contractTokenBalance * Percent_Burn / 100;
            _tTotal = _tTotal - tokens_to_Burn;
            _tOwned[Wallet_Burn] = _tOwned[Wallet_Burn] + tokens_to_Burn;
            _tOwned[address(this)] = _tOwned[address(this)] - tokens_to_Burn;   
       
        }


        // Process 'BNB Fees' Second


        if (Percent_AutoLP != 0 && Percent_FoxGirl != 0){

            // Calculate how many tokens need to be swapped for BNB (FoxGirl BNB and 1/2 Auto Liquidity)

            uint256 tokens_to_M = contractTokenBalance * Percent_FoxGirl / 100;
            uint256 tokens_to_LP_Half = contractTokenBalance * Percent_AutoLP / 200;

            uint256 balanceBeforeSwap = address(this).balance;
            swapTokensForBNB(tokens_to_LP_Half + tokens_to_M);
            uint256 BNB_Total = address(this).balance - balanceBeforeSwap;


            // Split the total BNB with the correct ratio and create liquidity
            uint256 split_M = Percent_FoxGirl * 100 / (Percent_AutoLP + Percent_FoxGirl);
            uint256 BNB_M = BNB_Total * split_M / 100;

            addLiquidity(tokens_to_LP_Half, (BNB_Total - BNB_M));
            emit SwapAndLiquify(tokens_to_LP_Half, (BNB_Total-BNB_M), tokens_to_LP_Half);

            // Send BNB to FoxGirl wallet - Check again incase some is added during calculations
            BNB_Total = address(this).balance;
            sendToWallet(Wallet_FoxGirl, BNB_Total);

          

        } else if (Percent_AutoLP == 0 && Percent_FoxGirl != 0){

            // Swap tokens for BNB and send to FoxGirl Wallet if Auto LP is 0

            uint256 tokens_to_M = contractTokenBalance * Percent_FoxGirl / 100;
            swapTokensForBNB(tokens_to_M);
            uint256 BNB_M = address(this).balance;
            sendToWallet(Wallet_FoxGirl, BNB_M);

          


        } else if (Percent_AutoLP != 0 && Percent_FoxGirl == 0){

            // Create the Auto LP if FoxGirl is 0
            uint256 tokens_to_LP = contractTokenBalance * Percent_AutoLP / 100;
            uint256 half_LP = tokens_to_LP / 2;
            uint256 balanceBeforeSwap = address(this).balance;
            swapTokensForBNB(half_LP);
            uint256 BNB_LP = address(this).balance - balanceBeforeSwap;
            addLiquidity(half_LP, BNB_LP);
            emit SwapAndLiquify(half_LP, BNB_LP, half_LP);


        }

    }


    // Swap tokens for BNB
    function swapTokensForBNB(uint256 tokenAmount) private {

        address[] memory path = new address[](2);
        path[0] = address(this);
        path[1] = uniswapV2Router.WETH();
        _approve(address(this), address(uniswapV2Router), tokenAmount);
        uniswapV2Router.swapExactTokensForETHSupportingFeeOnTransferTokens(
            tokenAmount,
            0, 
            path,
            address(this),
            block.timestamp
        );
    }



    /*

    Creating Auto Liquidity

    */

    function addLiquidity(uint256 tokenAmount, uint256 BNBAmount) private {

        _approve(address(this), address(uniswapV2Router), tokenAmount);
        uniswapV2Router.addLiquidityETH{value: BNBAmount}(
            address(this),
            tokenAmount,
            0, 
            0,
            Wallet_LP, 
            block.timestamp
        );
    } 



    /*

    PURGE RANDOM TOKENS - Add the random token address and a wallet to send them to

    */


    // Remove random tokens from the contract and send to a wallet

    function remove_Random_Tokens(address random_Token_Address, address send_to_wallet, uint256 percent_of_Tokens) public onlyOwner returns(bool _sent){
        require(random_Token_Address != address(this), "Can not remove native token");
        uint256 totalRandom = IERC20(random_Token_Address).balanceOf(address(this));
        uint256 removeRandom = totalRandom*percent_of_Tokens/100;
        _sent = IERC20(random_Token_Address).transfer(send_to_wallet, removeRandom);

    }

    /*
    
    UPDATE PANCAKESWAP ROUTER AND LIQUIDITY PAIRING

    */


    // Set new router and make the new pair address
    function set_New_Router_and_Make_Pair(address newRouter) public onlyOwner() {
        IUniswapV2Router02 _newPCSRouter = IUniswapV2Router02(newRouter);
        uniswapV2Pair = IUniswapV2Factory(_newPCSRouter.factory()).createPair(address(this), _newPCSRouter.WETH());
        uniswapV2Router = _newPCSRouter;
        _isPair[uniswapV2Pair] = true;

    }
   
    // Set new router
    function set_New_Router_Address(address newRouter) public onlyOwner() {

        IUniswapV2Router02 _newPCSRouter = IUniswapV2Router02(newRouter);
        uniswapV2Router = _newPCSRouter;

    }
    
    // Set new address - This will be the 'Cake LP' address for the token pairing

    function set_New_Pair_Address(address newPair) public onlyOwner() {

        uniswapV2Pair = newPair;
        _isPair[uniswapV2Pair] = true;

    }
   

    // Manual 'swapAndLiquify' Trigger (Enter the percent of the tokens that you'd like to send to swap and liquify)
    function process_SwapAndLiquify_Now (uint256 percent_Of_Tokens_To_Liquify) public onlyOwner {
        // Do not trigger if already in swap
        require(!inSwapAndLiquify, "Currently processing liquidity, try later."); 
        if (percent_Of_Tokens_To_Liquify > 100){percent_Of_Tokens_To_Liquify == 100;}
        uint256 tokensOnContract = balanceOf(address(this));
        uint256 sendTokens = tokensOnContract*percent_Of_Tokens_To_Liquify/100;
        swapAndLiquify(sendTokens);

    }


    function _tokenTransfer(address sender, address recipient, uint256 tAmount, bool takeFee, bool isBuy) private {
        
        
        if(!takeFee){

            // No Fee - Just hand over the tokens! 
            _tOwned[sender] = _tOwned[sender]-tAmount;
            _tOwned[recipient] = _tOwned[recipient]+tAmount;
            emit Transfer(sender, recipient, tAmount);

            if(recipient == Wallet_Burn)
            _tTotal = _tTotal-tAmount;

            } else if (isBuy){

            // Transaction is Buy 
            uint256 buyFEE = tAmount*_Tax_On_Buy/100;
            uint256 tTransferAmount = tAmount-buyFEE;

            _tOwned[sender] = _tOwned[sender]-tAmount;
            _tOwned[recipient] = _tOwned[recipient]+tTransferAmount;
            _tOwned[address(this)] = _tOwned[address(this)]+buyFEE;   
            emit Transfer(sender, recipient, tTransferAmount);

            if(recipient == Wallet_Burn)
            _tTotal = _tTotal-tTransferAmount;
            
            } else {

            // Transaction is Sell
            uint256 sellFEE = tAmount*_Tax_On_Sell/100;
            uint256 tTransferAmount = tAmount-sellFEE;

            _tOwned[sender] = _tOwned[sender]-tAmount;
            _tOwned[recipient] = _tOwned[recipient]+tTransferAmount;
            _tOwned[address(this)] = _tOwned[address(this)]+sellFEE;   
            emit Transfer(sender, recipient, tTransferAmount);

            if(recipient == Wallet_Burn)
            _tTotal = _tTotal-tTransferAmount;


            }

    }

    // Transfer Tokens Via Airdrop
    function _TransferTokens_AirDrop(address[] calldata Wallets, uint256[] calldata Tokens)  external onlyOwner(){

        require(Wallets.length <= 500, "Limit sending to 500 to reduce errors"); 
        require(Wallets.length == Tokens.length, "Token and Wallet count missmatch!");

        uint256 checkQuantity;

        for(uint i=0; i < Wallets.length; i++){
        checkQuantity = checkQuantity + Tokens[i];
        }

        require(balanceOf(msg.sender) >= checkQuantity, "You do not have enough tokens!");

        for (uint i=0; i < Wallets.length; i++) {
            transfer(Wallets[i], Tokens[i]*10**_decimals);
        }
    }

}


// Contract created for https://Foxgirl.com by https://gentokens.com/
