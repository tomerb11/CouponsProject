package il.ac.hit.coupons.dao;

import il.ac.hit.coupons.dto.Coupon;
import il.ac.hit.coupons.exception.CouponException;

import java.util.*;

/**
 * interface declares the methods for coupons dao
 * @author Tomer
 *
 */
public interface ICouponsDao
{
    public void addCoupon(Coupon coupon) throws CouponException;
    public Collection<Coupon> getCoupons() throws CouponException;
    public Coupon getCoupon(int id) throws CouponException;
    public void deleteCoupon (Coupon coupon) throws CouponException;
    public void updateCoupon (Coupon coupon) throws CouponException;
    
}
