package il.ac.hit.coupons.dao;

/**
 * combine the two interfaces of dao to one interface so that they can both be inherited and instantiated from one interface
 * @author Tomer
 *
 */
public interface IDao extends ICouponsDao, IUsersDao {
	
}
