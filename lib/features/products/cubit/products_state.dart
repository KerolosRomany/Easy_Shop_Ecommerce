abstract class ProductsStates {}

class InitialProductsState extends ProductsStates {}
class HomeSuccessfulGetAllProductsState extends ProductsStates {}
class ProductsSuccessfulGetResultsFromSearch extends ProductsStates {}
class ProductsSuccessfulGetSpecificBookState extends ProductsStates {}
class HomeSuccessfulGetFavoriteProductsState extends ProductsStates {}
class ProductsChangeFavoriteIconState extends ProductsStates {}
class SuccussfulRemoveFromFavState extends ProductsStates {}
class SuccessfulAddFavoriteState extends ProductsStates {}
class ProductSuccessfullProductAddedState extends ProductsStates {}
class ProductSuccessfulGetCartProductsState extends ProductsStates {}