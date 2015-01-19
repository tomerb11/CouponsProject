package il.ac.hit.coupons.dto;

import javax.persistence.Entity;
import javax.persistence.Id;

/**
 * class for user type holds fields to represent specific user
 * @author Tomer
 *
 */
@Entity
public class User {
	

	@Id
	private int userId;
	private String firstName;
	private String lastName;
	private String userName;
	private String password;
	private String city;
	
	public User() {		
	}
	
	/**
	 * primary constructor for user type. uses setters to validate fields before saving
	 * @param userId id 
	 * @param firstName firstname
	 * @param lastName lastname
	 * @param userName username
	 * @param password password
	 * @param city city
	 */
	public User(int userId, String firstName, String lastName, String userName,
			String password, String city) {
		super();
		setUserId(userId);
		setFirstName(firstName);
		setLastName(lastName);
		setUserName(userName);
		setPassword(password);
		setCity(city);
	}
	
	/**
	 * getter method for user id
	 * @return user id
	 */
	public int getUserId() {
		return userId;
	}

	/**
	 * setter method for user id
	 * @param userId
	 */
	public void setUserId(int userId) {
		this.userId = userId;
	}

	/**
	 * getter method for user first name
	 * @return first name of user
	 */
	public String getFirstName() {
		return firstName;
	}
	
	/**
	 * setter method for first name of user
	 * @param firstName
	 */
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	
	/**
	 * getter method for user last name
	 * @return
	 */
	public String getLastName() {
		return lastName;
	}
	
	/**
	 * setter method for last name of user
	 * @param lastName
	 */
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	
	/**
	 * getter method for user's username
	 * @return
	 */
	public String getUserName() {
		return userName;
	}
	
	/**
	 * setter method for username of user
	 * @param userName
	 */
	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	/**
	 * getter method of user's password
	 * @return
	 */
	public String getPassword() {
		return password;
	}
	
	/**
	 * setter method for user's password
	 * @param password
	 */
	public void setPassword(String password) {
		this.password = password;
	}
	
	/**
	 * getter method for user's city
	 * @return
	 */
	public String getCity() {
		return city;
	}
	
	/**
	 * setter method for user's city
	 * @param city
	 */
	public void setCity(String city) {
		this.city = city;
	}
}
