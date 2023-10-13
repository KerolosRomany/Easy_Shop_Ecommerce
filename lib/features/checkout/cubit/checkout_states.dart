abstract class CheckoutStates {}

class InitialCheckoutState extends CheckoutStates {}
class SuccessfulChangeCityState extends CheckoutStates {}
class HomeSuccessfulGetCitiesState extends CheckoutStates {}
class HomeSuccessfulGetProfileDataState extends CheckoutStates {}
class CartSuccessfulGetCartBooksState extends CheckoutStates {}
class CartSuccessfulGetCheckoutState extends CheckoutStates {}
class CheckoutSelectCityState extends CheckoutStates {}
class CheckoutSuccessfulGetProfileDataState extends CheckoutStates {}