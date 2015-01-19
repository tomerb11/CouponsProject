package il.ac.hit.coupons.dto;

import il.ac.hit.coupons.exception.CouponException;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Id;

/**
 * class for coupon type holds field to represent specific coupon
 * @author Tomer
 */
@Entity
public class Coupon
{
	@Id
    private int id;
    private String name;
    private String description;
    private String couponType;
    private int availableAmount;
	private Date expireDate;
	private String expireTime;
    private double discountPercentage;
    private double originalPrice;
    private double priceAfterDiscount;
    private String location;
	private double latitude;
    private double longitude;
    
    /**
     * no argument constructor
     */
	public Coupon()
    {
    	super();	
    }
    
	
	/**
	 * primary constructor for coupon. uses setters to initialiaze fields
	 * @param name
	 * @param description
	 * @param couponType
	 * @param availableAmount
	 * @param expireDate
	 * @param expireTime
	 * @param discountPercentage
	 * @param originalPrice
	 * @param location
	 * @param lantitude
	 * @param longitude
	 * @throws CouponException
	 */
    public Coupon(String name, String description , String couponType, int availableAmount, Date expireDate, String expireTime,
			double discountPercentage, double originalPrice, String location, double lantitude, double longitude) throws CouponException {
		super();
		setName(name);
		setOriginalPrice(originalPrice);
		setDescription(description);
		setCouponType(couponType);
		setAvailableAmount(availableAmount);
		setExpireDate(expireDate);
		setExpireTime(expireTime);
		setDiscountPercentage(discountPercentage);
		setLocation(location);
		setLatitude(lantitude);
		setLongitude(longitude);
		calculatePriceAfterDiscount();
	}

    /**
     * getter method for price after discount field
     * @return priceAfterDiscount
     */
	public Double getPriceAfterDiscount() {
		return priceAfterDiscount;
	}

	/**
	 * method that calculates price after a given discount percentage and saves in member field
	 */
	public void calculatePriceAfterDiscount()
	{
		this.priceAfterDiscount =  originalPrice - ( (discountPercentage / 100)  * originalPrice);
	}
	
	/**
	 * setter method for priceAfterDiscount field
	 * @param priceAfterDiscount
	 */
	public void setPriceAfterDiscount(double priceAfterDiscount) {
		this.priceAfterDiscount =  priceAfterDiscount;
	}

	/**
	 * getter method for couponType field
	 * @return couponType
	 */
	public String getCouponType() {
		return couponType;
	}

	/**
	 * setter method for couponType
	 * @param typeOfCoupon
	 * @throws CouponException
	 */
	public void setCouponType(String typeOfCoupon) throws CouponException {
		if (typeOfCoupon == "")
		{
			throw new CouponException("You need to choose category of coupon!");
		}
		this.couponType = typeOfCoupon;
	}
    
	/**
	 * getter method for available units of coupon
	 * @return 
	 */
    public int getAvailableAmount() {
 		return availableAmount;
 	}

    /**
     * setter method for available units of coupon
     * @param availableAmount
     * @throws CouponException
     */
 	public void setAvailableAmount(int availableAmount) throws CouponException {
 		if(availableAmount < 0)
		{
			throw new CouponException("availableAmount cannot be negetive");
		}
 		this.availableAmount = availableAmount;
 	}
 	
 	/** 
 	 * getter method for location in google maps
 	 * @return location of coupon
 	 */
 	public String getLocation() {
		return location;
	}

 	/**
 	 * setter method for google maps location
 	 * @param location
 	 * @throws CouponException
 	 */
	public void setLocation(String location) throws CouponException {
		if (location == "")
		{
			throw new CouponException("You need to choose the location of the coupon");
		}
		this.location = location;
	}
    
	/**
	 * getter method for location latitude
	 * @return location latitude
	 */
	public double getLatitude() {
		return latitude;
	}

	/**
	 * setter method for location latitude
	 * @param latitude
	 */
	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}

	/**
	 * getter method for location longitude
	 * @return longitude of coupon
	 */
	public double getLongitude() {
		return longitude;
	}

	/**
	 * setter method for location longitude of coupon
	 * @param longitude
	 */
	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}

	/**
	 * getter method for expire date of coupon
	 * @return expire date of coupon
	 */
	public Date getExpireDate() {
		return expireDate;
	}

	/**
	 * setter method for expire date of coupon
	 * @param expireDate
	 * @throws CouponException
	 */
	public void setExpireDate(Date expireDate) throws CouponException {
		if (expireDate == null)
		{
			throw new CouponException("You need to enter expire date of the coupon");
		}
		this.expireDate = expireDate;
	}

	/**
	 * getter method for expire time of coupon
	 * @return expire time coupon
	 */
	public String getExpireTime() {
		return expireTime;
	}

	/**
	 * setter method for expire time of coupon
	 * @param expireTime
	 * @throws CouponException
	 */
	public void setExpireTime(String expireTime) throws CouponException {
		if (expireTime == "")
		{
			throw new CouponException("You need to enter expire time of the coupon");
		}
		this.expireTime = expireTime;
	}

	/**
	 * getter method for discount percentage of coupon
	 * @return discount percentage of coupon
	 */
	public Double getDiscountPercentage() {
		return discountPercentage;
	}

	/**
	 * setter method for discount percentage of coupon
	 * @param discountPrecentage
	 */
	public void setDiscountPercentage(double discountPrecentage) {
		this.discountPercentage = discountPrecentage;
	}

	/**
	 * getter method for original price of coupon
	 * @return origina price of coupon
	 */
	public Double getOriginalPrice() {
		return originalPrice;
	}

	/**
	 * setter method for original price of coupon. validates input variable 
	 * @param originalPrice
	 * @throws CouponException
	 */
	public void setOriginalPrice(double originalPrice)  throws CouponException {
		if(originalPrice < 0)
		{
			throw new CouponException("Original price cannot be negetive");
		}
		this.originalPrice = originalPrice;
	}

	/**
	 * getter method for id of coupon
	 * @return id of coupon
	 */
    public int getId()
    {
        return id;
    }
    
    /**
     * getter method for name of coupon
     * @return name of coupon
     */
    public String getName()
    {
        return name;
    }
    
    /**
     * getter method of description of coupon
     * @return description of coupon
     */
    public String getDescription()
    {
        return description;
    }
    
    /**
     * setter method for id of coupon
     * @param id
     */
	public void setId(int id) {
		this.id = id;
	}

	/**
	 * setter method for name of coupon. validates string before save
	 * @param name
	 * @throws CouponException
	 */
	public void setName(String name) throws CouponException {
		if(name == "")
		{
			throw new CouponException("Name of coupon cannot be empty!");
		}
		this.name = name;		
	}

	/**
	 * setter method for descrption of coupon
	 * @param description
	 * @throws CouponException
	 */
	public void setDescription(String description) throws CouponException {
		if(name == "" || description.length() > 120)
		{
			throw new CouponException("Description of coupon cannot be empty!");
		}
		this.description = description;
	}

	/**
	 * override toString for coupon type
	 */
	@Override
	public String toString() {
		return "Coupon [id=" + id + ", name=" + name + ", description="
				+ description + ", couponType=" + couponType
				+ ", availableAmount=" + availableAmount + ", expireDate="
				+ expireDate + ", expireTime=" + expireTime
				+ ", discountPercentage=" + discountPercentage
				+ ", originalPrice=" + originalPrice + ", priceAfterDiscount="
				+ priceAfterDiscount + ", location=" + location + ", latitude="
				+ latitude + ", longitude=" + longitude + "]";
	}

	/**
	 * method to print coupon type to html
	 * @return
	 */
	public String toHtml() {
		StringBuilder output = new StringBuilder();
		output.append("<html><center><h2><i>Name : " + getName() + "</h2></i></center></html>");
		output.append("<html><center>Description : " + getDescription() + "<br></center></html>");
		output.append("<html><center>Category : " + getCouponType() + "<br></center></html>");
		output.append("<html><center>Available units : " + getAvailableAmount() + "<br></center></html>");
		output.append("<html><center>Expire time : " + getExpireTime() + "<br></center></html>");
		output.append("<html><center>Expire date : " + getExpireDate() + "<br></center></html>");
		output.append("<html><center>Discount : " + getDiscountPercentage() + "%" + "<br></center></html>");
		output.append("<html><center>Original price : " + getOriginalPrice() + "<br></center></html>");
		output.append("<html><center>Price after discount : " + getPriceAfterDiscount() + "<br></center></html>");
		output.append("<html><center>Location  : " + getLocation() + "<br><br><br></center></html>");
		
		return output.toString();
	}
}