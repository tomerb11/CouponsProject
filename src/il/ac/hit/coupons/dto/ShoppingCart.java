package il.ac.hit.coupons.dto;

import java.util.ArrayList;
import java.util.List;

/**
 * Class holds list of user's favorite coupons
 * @author Tomer
 *
 */
public class ShoppingCart {
	private List<Integer> shoppingCart = new ArrayList<>();

	/**
	 * method to receive favorites list of coupons
	 * @return favorite coupons list
	 */
	public List<Integer> getFavorites() {
		return shoppingCart;
	}

	/**
	 * method to add favorite coupon by id
	 * @param id
	 */
	public void addFavoriteCouponId(int id) {
		if (!shoppingCart.contains(id))
		{
			shoppingCart.add(id);
		}
	}
	
	/**
	 * method to remove favorite coupon from list by id
	 * @param id
	 */
	public void removeFavoriteCoupon(int id) {
		shoppingCart.remove(id);
	}
}
