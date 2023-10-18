abstract class CartStates {}

class InitialCartState extends CartStates {}
class CartSuccessfulGetCartBooksState extends CartStates {}
class CartSuccessfullBookAddedState extends CartStates {}
class CartSuccessfullRemovedBookState extends CartStates {}
class CartGetUpdatedTotalState extends CartStates {}
class CartSuccessfulGetSpecificProductState extends CartStates {}