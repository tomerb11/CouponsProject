package il.ac.hit.coupons.dao.imp;

import il.ac.hit.coupons.dao.IDao;
import il.ac.hit.coupons.dto.Coupon;
import il.ac.hit.coupons.dto.User;
import il.ac.hit.coupons.exception.CouponException;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.AnnotationConfiguration;

/**
 * class that access the database and retrieve and set information for coupons and users tables 
 * @author Tomer
 *
 */
public class MySqlDao implements IDao
{
	private static IDao instance;
	private SessionFactory factory = new AnnotationConfiguration().configure().buildSessionFactory();
	private Session session = null;
	private Transaction tx = null;
	
	/**
	 * no argument constructor  
	 */
	private MySqlDao() {}
	
	public static IDao getInstance()
	{
		if(instance==null)
		{
			instance = new MySqlDao();
		}
		return instance;
	}
	
	/**
	 * @return the factory
	 */
	public SessionFactory getFactory() {
		return factory;
	}
	
	/**
	 * return all coupons that stored in the database
	 */
	@SuppressWarnings("unchecked")
	public Collection<Coupon> getCoupons() throws CouponException 
	{
		List<Coupon> couponsArray = new ArrayList<Coupon>();    

		try
		{
			session = factory.openSession();
			couponsArray = session.createQuery("from Coupon ").list(); 
		}
		finally
		{
			session.close();
		}
		
		return couponsArray;
	}

	/**
	 * add new coupon to the database
	 */
	public void addCoupon(Coupon ob) throws CouponException
	{
		Transaction tx = null;

		try
		{
			session = factory.openSession();
			tx = session.beginTransaction();
			if(session.contains(ob))
			{
				throw new CouponException("Coupon already exists");
			}
			else
			{
				session.save(ob);
				tx.commit();
			}
		}
		finally
		{
			session.close();
		}
	}

	/**
	 * get a single coupon from the database according it's id
	 * @return coupon object
	 */
	@Override
	public Coupon getCoupon(int id) throws CouponException {
		Coupon couponIterator, couponToReturn = null;
		List<Coupon> couponsList = (List<Coupon>) getCoupons();
		Iterator<Coupon> i = couponsList.iterator();

		while(i.hasNext()) {
			couponIterator = i.next();
			if(couponIterator.getId() == id) {
				couponToReturn = couponIterator;
				break;
			}
		}

		return couponToReturn;
	}

	/**
	 * delete coupon from the data base
	 */
	@Override
	public void deleteCoupon(Coupon coupon) throws CouponException {

		try
		{
			session = factory.openSession();
			tx = session.beginTransaction();
			session.delete(coupon);
			tx.commit();

		}
		finally
		{
			session.close();
			factory.close();
		}

	}

	/**
	 * update existing coupon in the database 
	 */
	@Override
	public void updateCoupon(Coupon coupon) throws CouponException {

		try
		{
			session = factory.openSession();
			tx = session.beginTransaction();
			session.update(coupon);
			tx.commit();
		}

		finally
		{
			session.close();
			factory.close();
		}

	}
	
	/**
	 * check if user exists in the database
	 */
	@Override
	public boolean isUserExists(String userName, String password)
	{
		session = factory.openSession();
		tx = session.beginTransaction();
		boolean flag = false;
		Iterator<User> i = getUsersArray().iterator();
		User userToCheck;

		while (i.hasNext()){
			userToCheck = (User) i.next();
			if (userToCheck.getUserName().equals(userName) && userToCheck.getPassword().equals(password))
			{
				flag = true;
				break;
			}
		}

		return flag;
	}
	
	/**
	 * gets all the users from the database
	 *  @return list of all the user that stored in the database
	 */
	@SuppressWarnings("unchecked")
	public List<User>  getUsersArray(){
		List <User> usersArray = new ArrayList<User>();
		
		session = factory.openSession();
		usersArray = session.createQuery("from User").list();
		session.close();
		
		return usersArray;
	}
}
