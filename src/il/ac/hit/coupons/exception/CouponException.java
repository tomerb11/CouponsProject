package il.ac.hit.coupons.exception;

/**
 * custom exception class for coupons project
 * @author Niran
 *
 */
public class CouponException extends Exception
{
	private static final long serialVersionUID = 1L;

	/**
	 * primary constructor for exception class. sends messge to super for print
	 * @param str
	 */
	public CouponException(String str)
    {
        super(str);
    }
}
