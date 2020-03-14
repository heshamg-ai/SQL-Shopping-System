------------------------------------------------unregistered User--------------------------------------------------
--done
GO
CREATE PROC customerRegister 
@username varchar(20),
@ﬁrst_name varchar(20),
@last_name varchar(20),
@password varchar(20),
@email varchar(50),
@out int Output
AS

if(exists (select * from Users where username = @username))
begin 
set @out='1'
end 

else 
begin 

if(exists (select * from Users where email = @email))
begin 
set @out = '2'
end 

else
begin 

INSERT INTO Users(username,ﬁrst_name,last_name,password,email)
values(@username,@ﬁrst_name,@last_name,@password,@email)
INSERT INTO Customer (username)
values (@username)


end

end 



select * from Users

drop proc customerRegister
--EXEC customerRegister 'ahmed.ashraf',​ 'ahmed', 'ashraf', 'pass123',​ 'ahmed@yahoo.com' 
declare @outp int 
exec customerRegister 'ammar.yasser', 'ammar',' yasser', 'pass4','a' , @outp output
print @outp




--done
GO
CREATE PROC vendorRegister 
@username varchar(20),
@ﬁrst_name varchar(20),
@last_name varchar(20),
@password varchar(20),
@email varchar(50),
@company_name varchar(20), 
@bank_acc_no varchar(20),
@out int Output
AS


if(exists (select * from Users where username = @username))
begin 
set @out='1'
end 

else 
begin 

if(exists (select * from Users where email = @email))
begin 
set @out = '2'
end 

else
begin 


INSERT INTO Users(username,ﬁrst_name,last_name,password,email)
values(@username,@ﬁrst_name,@last_name,@password,@email)
INSERT INTO Vendor (username,bank_acc_no,company_name)
values (@username,@bank_acc_no,@company_name)

end 
end

drop proc vendorRegister
EXEC vendorRegister 'eslam.mahmod', 'eslam' ​, 'mahmod','pass1234', 'hopa@gmail.com' ,'Market',​132132513
--exec vendorRegister  'hadeel.adel' ,'hadeel' ,'adel' ,'pass13' ,'hadeel.adel@guc.edu.eg', 'Dello', '47449349234' 

-------------------------------------------------registered User----------------------------------------------------
select * from Vendor
go
--done
CREATE PROC userLogin 
@username varchar(20), 
@password varchar(20),
@success bit OUTPUT , 
@type int OUTPUT
AS
DECLARE @user varchar(20)
SELECT @user = u.username 
from Users u
where u.username = @username and u.password = @password

if(@user is null)
begin
SET @success= 0 
SET @type = -1
print 'SUCCESS: ' + CAST(@success AS VARCHAR(10))
print 'TYPE: ' + CAST(@type AS VARCHAR(10))

end
else 
begin 
		DECLARE @u varchar(20)
		SET @success = 1
		SELECT @u = c.username
		from Customer c
		where c.username = @username 

		if(@u is not null)
		SET @type = 0 
		else 
		begin 
			SELECT @u = v.username
			from Vendor v
			where v.username = @username 

			if(@u is not null)
			SET @type = 1
			else
			begin 
				SELECT @u = a.username
				from Admins a
				where a.username = @username

				if(@u is not null)
				SET @type = 2
				else
				SET @type = 3
			end
	  end
	  print 'SUCCESS: '+ CAST(@success AS VARCHAR(10))
	  print 'TYPE: ' + CAST(@type AS VARCHAR(10))
end

select * from Users
select * from Customer
select * from Admins
select * from Vendor
select * from Delivery_Person


declare @success bit declare @type int exec userLogin 'eslam.mahmod','pass123',@success output, @type output
declare @success bit declare @type int exec userLogin 'eslam.mahmod','pass1234',@success output, @type output
declare @success bit declare @type int exec userLogin 'ahmed.ashraf','pass123',@success output, @type output
declare @success bit declare @type int exec userLogin 'ahmed.ashraf','pass',@success output, @type output










declare @success bit 
declare @type int 
EXEC userLogin 'eslam.mahmoud' ,'pass1234' , @success output , @type output
print @success 
print @type

--done
GO
CREATE PROC addMobile 
@username varchar(20), 
@mobile_number int,
@out int output
AS
if(exists (select * from User_mobile_numbers where username=@username and mobile_number=@mobile_number))
begin set @out='1' end 

else 
INSERT INTO User_mobile_numbers VALUES (@mobile_number,@username)

drop proc addMobile
declare @out int 
EXEC addMobile ​ 'ahmed.ashraf' , ​'0',@out output print @out
--EXEC addMobile ​ 'ahmed.ashraf' ,​ 0124262652 
SELECT * FROM User_mobile_numbers

--done
GO
CREATE PROC addAddress 
@username varchar(20), 
@address varchar(100)
AS 
INSERT INTO User_Addresses VALUES (@address,@username)

--EXEC addAddress 'ahmed.ashraf', ​'nasr city'
select * from User_Addresses

------------------------------------------------------CUSTOMER------------------------------------------------------


GO
--done
CREATE PROC showProducts 
AS
select p.*
FROM Product p
order by p.price 

exec showProducts

--done
GO 
CREATE PROC ShowProductsbyPrice 
AS
SELECT p.product_name,p.product_description,p.price,p.final_price,p.color
from Product p
order by price
exec ShowProductsbyPrice

--done
GO
CREATE PROC searchbyname 
@text varchar(20)
as
SELECT p.product_name,p.product_description,p.price,p.final_price,p.color 
from Product p
where product_name = @text
exec searchbyname 'blue pen'

--done
GO
CREATE PROC AddQuestion 
@serial int, 
@customer varchar(20), 
@Question varchar(50)
AS 
INSERT INTO Customer_Question_Product(serial_no,customer_name,question)
values (@serial,@customer,@Question)
--exec AddQuestion 1,'ahmed.ashraf'​ ,  'size?'
select * from Customer_Question_Product



--done
GO 
CREATE PROC addToCart 
@customername varchar(20), 
@serial int,
@out int output
AS 
if(not exists (select * from Product where serial_no = @serial))
begin set @out = '1' 
end 
	else
	begin
		if(exists (select * from CustomerAddstoCartProduct where customer_name = @customername and serial_no=@serial))
		begin set @out = '3' end else begin
		if(exists (select * from Product where serial_no = @serial and available ='0'))
		begin set @out = '2' end 

		else
		begin
		INSERT INTO CustomerAddstoCartProduct 
		VALUES(@serial,@customername)

		end
	end 
	end

drop proc addToCart

declare @out int 
exec addToCart 'm7mda4raf999' , 3016,@out output 
print @out
select * from CustomerAddstoCartProduct
delete from CustomerAddstoCartProduct
select * from Product


--done
GO 
CREATE PROC removefromCart 
@customername varchar(20), 
@serial int,
@out int output
AS 
if(not exists (select * from CustomerAddstoCartProduct where customer_name = @customername and serial_no=@serial))
begin set @out ='1' end 

else
begin
delete 
FROM CustomerAddstoCartProduct 
where @serial=CustomerAddstoCartProduct.serial_no AND @customername=CustomerAddstoCartProduct.customer_name
end 

exec removefromCart 'm7mda4raf999',3015
select * from CustomerAddstoCartProduct

--done
GO 
CREATE PROC createWishlist 
@customername varchar(20), 
@name varchar(20)
AS
INSERT INTO Wishlist VALUES(@customername,@name)
exec createWishlist 'ammar.yasser','stationary'
select * from Wishlist
select * from Users

--done
GO
CREATE PROC AddtoWishlist 
@customername varchar(20), @wishlistname varchar(20), @serial int, @out int output
AS
if(exists(select * from Wishlist_Product where serial_no = @serial and wish_name = @wishlistname))
	begin set @out = '1' 
	end

	else
	begin 
		if(not exists (select * from Wishlist where name = @wishlistname and username = @customername))
		begin set @out = '2' 
		end 

		else
		begin 
			if(not exists (select * from Product where serial_no = @serial))
			begin set @out = '3' 
			end 

			else
			begin 
			INSERT INTO Wishlist_Product VALUES(@customername,@wishlistname,@serial)
			end 

		end 
	end 

	drop proc AddtoWishlist
exec AddtoWishlist 'muhammad.ehab','fashion',​2011
select * from Wishlist
select * from Wishlist_Product
select * from Customer
select * from Product
exec viewMyCart 'm7mda4raf999'

--done
GO 
CREATE PROC  removefromWishlist
@customername varchar(20), @wishlistname varchar(20), @serial int, @out int output 
AS
if(not exists (select * from Wishlist where username = @customername and name = @wishlistname))
begin set @out ='1' end

else
begin 
if(not exists (select * from Product where serial_no = @serial))
begin set @out ='2' end

else
begin 
delete
from  Wishlist_Product
where @serial=Wishlist_Product.serial_no AND @customername=Wishlist_Product.username AND @wishlistname=Wishlist_Product.wish_name

end

end


drop proc removefromWishlist
exec removefromWishlist 'muhammad.ehab',​ '',​ ''
select * from Wishlist_Product
select * from Wishlist
select * from Todays_Deals
--done
GO
CREATE PROC showWishlistProduct
@customername varchar(20), @name varchar(20)
AS
SELECT p.product_name,p.product_description,p.price,p.final_price,p.color
FROM product p INNER JOIN Wishlist_Product w on w.serial_no=p.serial_no
where w.username=@customername AND w.wish_name=@name
--exec showWishlistProduct 'ahmed.ashraf' , ​'fashion'

GO
CREATE PROC showProductsinAllWishlists
@customername varchar(20)
AS
select p.*
FROM product p INNER JOIN Wishlist_Product w on w.serial_no=p.serial_no
where w.username=@customername

exec showProductsinAllWishlists 'muhammad.ehab'
drop proc showProductsinAllWishlists
select * from CustomerAddstoCartProduct
select * from Orders

--done
GO	
CREATE PROC viewMyCart
@customer varchar(20)
AS
select p.*
FROM product p INNER JOIN CustomerAddstoCartProduct cp ON p.serial_no=cp.serial_no
where cp.customer_name=@customer

exec viewMyCart 'ammar.yasser'


--done
GO
CREATE PROC calculatepriceOrder
@customername varchar(20),
@sum decimal(10,2) output
AS
SELECT @sum=SUM(final_price)
from product p INNER JOIN CustomerAddstoCartProduct cp ON p.serial_no=cp.serial_no
where cp.customer_name=@customername

declare @sum decimal(10,2)
exec calculatepriceOrder 'ahmed.ashraf',@sum output
print @sum

--done
GO 
CREATE PROC emptyCart
@customername varchar(20)
AS
delete
from CustomerAddstoCartProduct
where @customername=CustomerAddstoCartProduct.customer_name

exec emptyCart 'ahmed.ashraf'
exec viewMyCart 'muhammad.ehab'
select * from Orders

--done 
GO
CREATE PROC makeOrder 
@customername varchar(20),
@order_id int Output,
@totalprice decimal(10,2) Output,
@out int output
AS
if(not exists (select * from CustomerAddstoCartProduct where customer_name = @customername))
begin set @out ='1' end 

else 
begin


--total price of the order
EXEC calculatepriceOrder @customername , @totalPrice OUTPUT

--date of the order
declare @date datetime
SET @date = CURRENT_TIMESTAMP

insert INTO Orders (customer_name,total_amount,order_date)
values (@customername,@totalPrice,@date)


--get the order id
SELECT @order_id = max(O.order_no) 
from Orders O
---set customer order id in products
UPDATE TableA
SET TableA.customer_username = @customername, TableA.customer_order_id = @order_id
FROM Product AS TableA  
	 inner join CustomerAddstoCartProduct AS TableB
	 ON TableA.serial_no = TableB.serial_no 
where TableB.customer_name = @customername



--temporary table for cart customer username
SELECT * 
INTO #cart_customerusername
FROM CustomerAddstoCartProduct
WHERE customer_name = @customername

--EMPTY CART
EXEC emptyCart @customername 

--SET AVAILIBILTY OF PRODUCTS = 0 
UPDATE Product 
SET available = 0
where customer_order_id = @order_id and customer_username = @customername

--remove the ordered products from other carts
DELETE 
FROM CustomerAddstoCartProduct
where serial_no IN (select serial_no from #cart_customerusername)

end

drop proc makeOrder

declare @order_id int declare @total decimal(10,2) 
exec makeOrder 'm7mda4raf999', @order_id Output, @total output
print @order_id
print @total

select * from Orders
select * from Product
exec viewMyCart 'muhammad.ehab'
exec viewMyCart 'ahmed.ashraf'
exec addToCart 'muhammad.ehab',2012

exec postProduct 'eslam.mahmod','' ,'',​'','',​''
exec addToCart 'muhammad.ehab',2017
delete from Product



--done
GO 
CREATE PROC productsinorder 
@customername varchar(20),
@orderID int
AS
select *
from Product p
where @customername=p.customer_username AND @orderID=p.customer_order_id
EXEC productsinorder 'ahmed.ashraf',4


---------- done
GO
CREATE PROC cancelOrder 
@orderid int,
@out int output
AS
if(not exists (select * from Orders where order_no=@orderid))
begin set @out = '3' end 

else 
begin

--if the order's status is not processed or in process
if (exists (SELECT * 
FROM Orders o
where o.order_no = @orderid and o.order_status in ('NOT PROCESSED',' IN PROCESS')))

begin

declare @giftcardused varchar(10)
declare @cash decimal(10,2)
declare @credit decimal(10,2)
declare @total_amount decimal(10,2)
declare @points decimal(10,2)
declare @customer_username varchar(20)


select @giftcardused = Gift_Card_code_used,@cash=cash_amount,@credit=credit_amount,@total_amount=total_amount ,@customer_username = customer_name
from Orders where order_no = @orderid 


exec removeExpiredGiftCard @giftcardused

if(exists(select * from Admin_Customer_Giftcard where code=@giftcardused))
	begin
		if(@cash = 0)
			begin
			set @points = @total_amount - @credit
			end
		else
			begin
			set @points = @total_amount - @cash
			end
		
		update Customer set points = points + @points where username = @customer_username
		update Admin_Customer_Giftcard set  remaining_points= remaining_points + @points 
		where customer_name = @customer_username and code = @giftcardused

	end



--set avaiable = 1 in products
UPDATE Product 
SET available = 1 
where customer_order_id  = @orderid
--set customer username = null in products 
UPDATE Product
SET customer_username = null 
where customer_order_id  = @orderid
--set customer order id = null in products 
UPDATE Product
SET customer_order_id = null 
where customer_order_id  = @orderid
--delete the order from its table
delete 
from Orders
where Orders.order_no = @orderid
end

else
begin
declare @status varchar(20) 
select @status = order_status from Orders where order_no = @orderid 

if(@status = 'OUT FOR DELIVERY')
begin
set @out = '1'
end
else
begin
if(@status = 'DELIVERED')
begin
set @out = '2'
end
ELSE 
BEGIN
set @out = '3'
END

end
end 

end

drop proc cancelOrder

declare @out int 
exec cancelOrder 3030,@out output 
print @out

select * from Orders
exec addToCart 'ahmed.ashraf',11
exec SpecifyAmount 'ahmed.ashraf',27,null,100
update Orders set order_status = 'OUT FOR DELIVERY' where order_no = '3030'
select * from Product
select * from Customer
select * from Giftcard
select * from Admin_Customer_Giftcard
delete from Admin_Customer_Giftcard
select * from CustomerAddstoCartProduct
update Customer set points = 0 where username = 'ahmed.ashraf'
update Admin_Customer_Giftcard set remaining_points = 70 where code = 'G102'

update orders set cash_amount=null, credit_amount = null,Gift_Card_code_used = null,payment_type=null
update Customer set points = 70 where username = 'ahmed.ashraf'
update Admin_Customer_Giftcard set remaining_points = 0 where code = 'G101'
select * from Giftcard

----------not done 
GO
CREATE PROC returnProduct
@serialno int, 
@orderid int
AS
declare @final_price decimal(10,2)
select @final_price = final_price from Product where serial_no = @serialno

declare @points decimal(10,2)
declare @total_amount decimal(10,2)
declare @cash decimal(10,2)
declare @credit decimal(10,2)
declare @payment_type varchar(20)
declare @customer_name varchar(20)

declare @gift_card_used varchar(10)

select @total_amount = total_amount,@cash=cash_amount,@credit=credit_amount,@payment_type=payment_type ,
@gift_card_used=Gift_Card_code_used,@customer_name = customer_name
from Orders where order_no = @orderid

exec removeExpiredGiftCard @gift_card_used

print cast (cast(40 as float) / cast(100 as float) as float)

if(exists(select * from Giftcard where code = @gift_card_used))
	begin
		if(@payment_type = 'cash')
			set @points = @total_amount - @cash
		else
			set @points = @total_amount - @credit

		update Customer set points = points+@points where username = @customer_name
		update Admin_Customer_Giftcard set remaining_points = remaining_points+@points 
		where code=@gift_card_used and customer_name=@customer_name

	end


update Orders set total_amount = total_amount - @final_price where order_no = @orderid
update Product set available=1 where serial_no = @serialno
update Product set customer_order_id=null where serial_no = @serialno
update Product set customer_username=null where serial_no = @serialno

exec returnProduct 1,1024
select * from Orders
select * from Product
select * from Customer
select * from Admin_Customer_Giftcard

exec addToCart 'ahmed.ashraf',1
exec makeOrder 'ahmed.ashraf'
exec SpecifyAmount 'ahmed.ashraf',1024,40,null
exec createGiftCard 'G101', '2019/11/26' ,70, 'hana.aly'
exec giveGiftCardtoCustomer 'G101' ,'ahmed.ashraf' , 'hana.aly'


update Product set customer_username='ahmed.ashraf' where serial_no=1
update Product set customer_order_id=1024 where serial_no=1
update Product set available=0 where serial_no=1
update Orders set total_amount = 100 
update Orders set cash_amount=null 
update Orders set credit_amount=null 
update Orders set payment_type=null 
update Orders set Gift_Card_code_used=null 





--done
GO 
CREATE PROC ShowproductsIbought 
@customername varchar(20)
AS
SELECT p.serial_no,p.product_name,p.category,p.product_description,p.price,p.final_price,p.color
from Product p 
Inner join Orders o on p.customer_order_id = o.order_no
where o.customer_name = @customername
EXEC ShowproductsIbought 'ahmed.ashraf'


--done
GO 
CREATE PROC rate  
@serialno int, @rate int , @customername varchar(20)
AS 
UPDATE Product
SET rate = @rate
where @serialno = serial_no and customer_username = @customername
exec rate 1, 3, 'ahmed.ashraf'

------not done
GO
CREATE PROC SpecifyAmount 
@customername varchar(20), 
@orderID int,
@cash decimal(10,2), 
@credit decimal(10,2),
@out int output
AS
declare @cash_amount decimal(10,2)
select @cash_amount = cash_amount from Orders where order_no = @orderID 

if(@cash_amount is not null)
begin set @out ='1' end 

else 
begin



if(@cash is not null)
begin


declare @total_amount decimal(10,2)
select @total_amount = o.total_amount
from Orders o
where o.customer_name = @customername and o.order_no = @orderID

update orders
set cash_amount = @cash, payment_type = 'cash',credit_amount = 0
where customer_name = @customername and order_no = @orderID

declare @points decimal(10,2)
set @points = @total_amount - @cash

declare @giftcardused varchar(10)
declare @remaining_points decimal(10,2)



	if(@total_amount - @cash <> 0)
	begin 
	   select @giftcardused = a.code, @remaining_points = a.remaining_points
	   from Admin_Customer_Giftcard a
   	   where a.customer_name = @customername and a.remaining_points >= All (select remaining_points 
																		    from Admin_Customer_Giftcard a1
																		    where a1.customer_name = @customername)
		if(@remaining_points > @points)
		begin
		update Admin_Customer_Giftcard 
		set remaining_points = remaining_points - @points
		where code = @giftcardused
		update Customer
		set points = points - @points
		where username = @customername 
		update Orders
		set Gift_Card_code_used = @giftcardused
		where order_no = @orderID and customer_name = @customername
		end
		else
		begin
			if(@remaining_points > 0)
			begin
			update Admin_Customer_Giftcard 
			set remaining_points = 0
			where code = @giftcardused
			update Customer
			set points = points - @remaining_points
			where username = @customername 
			update Orders
			set Gift_Card_code_used = @giftcardused, cash_amount = cash_amount + (@points - @remaining_points)
			where order_no = @orderID and customer_name = @customername
			end 
			else
			begin
			update Orders
			set cash_amount = cash_amount + (@points)
			where order_no = @orderID and customer_name = @customername
			end
		end 
	end 

end
else

begin 
declare @total_amount1 decimal(10,2)
select @total_amount1 = o.total_amount
from Orders o
where o.customer_name = @customername and o.order_no = @orderID

update orders
set credit_amount = @credit, payment_type = 'credit',cash_amount = 0
where customer_name = @customername and order_no = @orderID

declare @points1 decimal(10,2)
set @points1 = @total_amount1 - @credit

declare @giftcardused1 varchar(10)
declare @remaining_points1 decimal(10,2)

	if(@total_amount1 - @credit <> 0)
	begin 
	   select @giftcardused1 = a.code, @remaining_points1 = a.remaining_points
	   from Admin_Customer_Giftcard a
   	   where a.customer_name = @customername and a.remaining_points >= All (select remaining_points 
																		    from Admin_Customer_Giftcard a1
																		    where a1.customer_name = @customername)
		if(@remaining_points1 > @points1)
		begin
		update Admin_Customer_Giftcard 
		set remaining_points = remaining_points - @points1
		where code = @giftcardused1
		update Customer
		set points = points - @points1
		where username = @customername 
		update Orders
		set Gift_Card_code_used = @giftcardused1
		where order_no = @orderID and customer_name = @customername
		end
		else
		begin
			if(@remaining_points1 > 0)
			begin
			update Admin_Customer_Giftcard 
			set remaining_points = 0
			where code = @giftcardused1
			update Customer
			set points = points - @remaining_points1
			where username = @customername 
			update Orders
			set Gift_Card_code_used = @giftcardused1, credit_amount = credit_amount + (@points1 - @remaining_points1)
			where order_no = @orderID and customer_name = @customername
			end 
			else
			begin
			update Orders
			set credit_amount = credit_amount + (@points1)
			where order_no = @orderID and customer_name = @customername
			end
		end 
	end 



end 
end

drop proc SpecifyAmount
exec SpecifyAmount 'muhammad.ehab',2026,null,'10'
select * from Orders
update orders set cash_amount = null,credit_amount=null , payment_type=null where order_no=2025


select * from Admin_Customer_Giftcard
select * from Customer

delete from Admin_Customer_Giftcard where code = 'G101'

update orders set cash_amount=null, credit_amount = null,Gift_Card_code_used = null,payment_type=null
update Customer set points = 80
update Admin_Customer_Giftcard set remaining_points = 80 where code = 'G102'

--done
GO 
CREATE PROC AddcreditCard
@number varchar(20), 
@expiry_date DATETIME, 
@cvv_code INT,
@out int output
AS 
if(exists (select * from Credit_Card where number = @number))
begin set @out ='1' end else begin

INSERT INTO Credit_Card VALUES(@number,@expiry_date,@cvv_code)

end 

drop proc AddcreditCard
EXEC AddcreditCard 123,'10/19/2019',123
SELECT * FROM Credit_Card


--done
GO 
CREATE PROC ChooseCreditCard 
@creditcard varchar(20), 
@orderid int,
@out int OUTPUT
AS
if(not exists(select * from Credit_Card where number = @creditcard))
begin set @out = '1' end 
else
begin 
if(not exists(select * from Orders where order_no = @orderid))
begin set @out = '2' end 
else 
begin 
set @out = '3'
UPDATE Orders
SET creditCard_number = @creditcard
where order_no = @orderid

end

end 

DROP PROC ChooseCreditCard
declare @int int  
exec ChooseCreditCard '1234','3030',@int output
print @int 


--done
GO 
CREATE PROC vewDeliveryTypes 
AS
SELECT d.type,d.time_duration,d.fees
FROM Delivery d
exec vewDeliveryTypes 

--done
GO 
CREATE PROC specifydeliverytype 
@orderID int, @deliveryID INT
AS
UPDATE Orders 
SET delivery_id = @deliveryID
where order_no = @orderID

declare @remainingdays INT 
SELECT @remainingdays = D.time_duration
FROM Delivery D
WHERE D.id = @deliveryID

UPDATE Orders
SET remaining_days = @remainingdays
where order_no = @orderID

declare @fees decimal(10,2)
select @fees = fees from Delivery where id = @deliveryID

UPDATE Orders 
SET total_amount = total_amount + @fees
where order_no = @orderID

drop proc specifydeliverytype
exec specifydeliverytype 31,3
select * from Orders

--done
GO 
CREATE PROC trackRemainingDays 
@orderid int, @customername varchar(20), @days int OUTPUT
AS
declare @duration int 
SELECT @duration = d.time_duration 
FROM Orders o inner join Delivery d ON o.delivery_id = d.id
where o.order_no = @orderid and o.customer_name = @customername

declare @order_date datetime 
SELECT @order_date = o.order_date 
FROM Orders o
where o.order_no = @orderid and o.customer_name = @customername

set @days = @duration - (Day(CURRENT_TIMESTAMP - @order_date)) +1 

if(@days < 0)
	SET @days = 0

update Orders 
set remaining_days = @days
where order_no = @orderid and customer_name = @customername


declare @days int 
exec trackRemainingDays 29,'ahmed.ashraf',@days output
print @days
select * from Orders




-------not done
GO 
CREATE PROC recommend 
@customername varchar(20)
AS
declare @table1 Table(product1 int)
declare @table2 Table(product2 int)
insert into @table1(product1)
select  top(3) p.serial_no
from Wishlist_Product w,product p
where w.serial_no=p.serial_no and (p.category=any(SELECT TOP (3) category
from CustomerAddstoCartProduct c,product p
where c.serial_no=p.serial_no and c.customer_name=@customername
group by p.category
order by count(*) desc ))
group by p.serial_no,p.product_name
order by count(*) desc

insert into @table2(product2)
select  top(3) p.serial_no
 from product p,Wishlist_Product w
 where p.serial_no = w.serial_no and w.username=any(
 select top(3) c1.customer_name
 from CustomerAddstoCartproduct c,CustomerAddsToCartproduct c1
 where c.serial_no=c1.serial_no and c.customer_name<>c1.customer_name and c.customer_name = @customername
 group by c1.customer_name
 order by count(*) desc
 )
 group by p.serial_no,p.product_name
 order by count(*) desc

 select p1.*
 from @table1 p,Product p1
 where p.product1 = p1.serial_no
 union
 select p1.*
 from @table2 p,Product p1
 where p.product2 = p1.serial_no

select * from Wishlist_Product
select * from CustomerAddstoCartProduct
select * from Product
update Product set category='Fashion' where serial_no = 1
SET IDENTITY_INSERT Product off



update Wishlist_Product set wish_name = 'fashion'

select * from Wishlist_Product
select * from CustomerAddstoCartProduct

exec recommend 'ahmed.ashraf'
drop proc recommend

insert into Product (serial_no,product_name,category,product_description,price,final_price,color,available,rate,vendor_username)
values(4,'pencil' ,'stationary','HB0.7', 10, 10, 'red', 1, 0 ,'eslam.mahmod')
----------------------------------------------------VENDOR--------------------------------------------------------------

--done
GO 
CREATE PROC postProduct
@vendorUsername varchar(20),
@product_name varchar(20) ,
@category varchar(20),
@product_description text , 
@price decimal(10,2), 
@color varchar(20)
as
insert into Product(vendor_username,product_name,category,product_description,final_price,color,price)
values(@vendorUsername,@product_name,@category,@product_description,@price,@color,@price)
exec postProduct 'eslam.mahmod','fifa' ,'sport',​'cc','100',​'red'
select * from Product

--done
GO
CREATE PROC  vendorviewProducts 
@vendorname varchar(20)
AS
SELECT p.*
FROM Product p 
WHERE p.vendor_username = @vendorname
exec vendorviewProducts 'eslam.mahmod'

select * from Product

--done
GO
CREATE PROC EditProduct 
@vendorname varchar(20),
@serialnumber int,
@product_name varchar(20),
@category varchar(20), 
@product_description text , 
@price decimal(10,2), 
@color varchar(20),
@out int output
AS
if(@serialnumber = '')
begin 
set @out = '1'
end 

else 
begin

if (@product_name not like 'no')
begin
UPDATE Product
set product_name = @product_name
WHERE serial_no = @serialnumber
end 

if (@category not like'no')
begin
UPDATE Product
set category = @category
WHERE serial_no = @serialnumber
end 

if @product_description not like 'no'
begin
UPDATE Product
set product_description = @product_description
WHERE serial_no = @serialnumber
end 

if (@price <> '0' ) 
begin
UPDATE Product
set price = @price
WHERE serial_no = @serialnumber
end 

if @color not like 'no'
begin
UPDATE Product
set color = @color
WHERE serial_no = @serialnumber
end 

end

drop proc EditProduct
declare @out int 
exec EditProduct 'eslam.mahmoud',3018,'','','','0','' , @out output print @out
select * from Product

--done
GO 
CREATE PROC deleteProduct 
@vendorname varchar(20), @serialnumber int 
AS
DELETE   
FROM Product 
where vendor_username = @vendorname AND serial_no = @serialnumber
exec deleteProduct 'eslam.mahmod', 10
SELECT * FROM Product

--done
GO
CREATE PROC viewQuestions
@vendorname varchar(20)
AS
SELECT c.*
FROM Customer_Question_Product c 
INNER JOIN Product p ON c.serial_no = p.serial_no
where p.vendor_username = @vendorname
exec viewQuestions 'hadeel.adel'

--done
GO
CREATE PROC answerQuestions 
@vendorname varchar(20), 
@serialno int, 
@customername varchar(20), 
@answer text
AS
UPDATE Customer_Question_Product
SET answer = @answer
where serial_no = @serialno and customer_name = @customername and exists (select * 
																		from Product
																		where vendor_username=@vendorname AND serial_no=@serialno)
--exec answerQuestions 'hadeel.adel',1,'ahmed.ashraf',​ '40' 
select * from Customer_Question_Product

--done
GO
CREATE PROC  addOﬀer 
 @oﬀeramount int, 
 @expiry_date datetime
 AS
 INSERT INTO offer(offer_amount,expiry_date)
 VALUES(@oﬀeramount,@expiry_date)


 drop proc addOﬀer
 exec addOﬀer 60,'01/01/2020'
 select * from Offer

--done
GO
CREATE PROC checkOﬀeronProduct
 @serial int,
 @activeoﬀer bit OUTPUT
 AS
if exists(select serial_no from offersOnProduct 
where serial_no=@serial)
set @activeoﬀer=1
else
set @activeoﬀer=0
declare @active bit
exec checkOﬀeronProduct 1,@active output
print @active

--done
GO
CREATE PROC checkandremoveExpiredoﬀer
@oﬀerid int,
@out int output
AS
if(not exists(select * from offer where offer_id = @oﬀerid))
begin set @out = '3' end 

else 
begin
if exists(select expiry_date 
			from offer 
			where CURRENT_TIMESTAMP>expiry_date and @oﬀerid=offer_id)
	begin
	set @out = '1' 
	declare @amount INT
	select @amount = offer_amount
	from offer
	where offer_id = @oﬀerid

	declare @percent decimal(10,2) 
	set @percent = cast(@amount as float) / cast(100 as float)


	UPDATE
		Table_A
	SET
		Table_A.final_price= Table_A.price
	FROM
		Product AS Table_A
		INNER JOIN offersOnProduct AS Table_B
			ON Table_A.serial_no = Table_B.serial_no
	where Table_B.offer_id = @oﬀerid

	delete 
	from offer 
	where offer_id=@oﬀerid

	end
else
begin
set @out='2'
end
end


drop proc checkandremoveExpiredoﬀer 
declare @out int
exec checkandremoveExpiredoﬀer 1009,@out output
print @out
select * from offer
select * from Product
select * from offersOnProduct
select * from Wishlist_Product

--done
GO 
CREATE PROC applyOﬀer
@vendorname varchar(20),
@oﬀerid int, 
@serial int ,
@out int output
AS
if(not exists (select * from Product where serial_no=@serial))
	begin set @out ='2' end 

else 
begin 
		if(not exists (select * from offer where offer_id=@oﬀerid))
			begin set @out ='3' end 
		else 
		begin 


		declare @Offer bit
		EXEC checkOﬀeronProduct @serial,@Offer OUTPUT

		declare @TodaysDeal bit
		exec checkTodaysDealOnProduct @serial,@TodaysDeal OUTPUT

		declare @amount decimal(10,2) 
		select @amount = offer_amount
		from offer 
		where offer_id = @oﬀerid

		declare @final_price decimal(10,2)
		select @final_price = final_price from Product where serial_no = @serial

		declare @percent decimal(10,2) 
		set @percent = cast(@amount as float) / cast(100 as float)

		declare @mul decimal(10,2) 
		set @mul = cast(@percent as float) * cast(@final_price as float)

		declare @res decimal(10,2)
		set @res = cast(@final_price as float) - cast(@mul as float)

		if(exists(select expiry_date 
							from offer 
							where CURRENT_TIMESTAMP<expiry_date and @oﬀerid=offer_id)
		and exists (select * from Product where vendor_username = @vendorname and serial_no=@serial))
			begin
				if(@Offer=0 and @TodaysDeal = 0)
					begin
						INSERT INTO offersOnProduct
						VALUES(@oﬀerid,@serial)

						UPDATE Product
						SET final_price = @res
						where serial_no = @serial
					end 
				else
					begin print 'The product has an active offer' set @out = '1' end 
			end

			else 
				begin set @out = '4' end
end
end

drop proc applyOﬀer
declare @out int 
exec applyOﬀer 'eslam.mahmod',1009,3036,@out output print @out
select * from offersOnProduct
delete from offersOnProduct
select * from Product
select * from offer
update offer set offer_amount = 50
delete from offersOnProduct
update Product set price = 100 where serial_no=1

go
CREATE PROC applyOffer1
@vendorname varchar(20),
@offerid int,
@serial int
AS
BEGIN
DECLARE @offerexdate datetime
DECLARE @offeramount INT
DECLARE @flag BIT



SELECT @offerexdate=expiry_date
FROM offer
WHERE offer_id=@offerid

SELECT @offeramount=offer_amount
FROM offer
WHERE offer_id=@offerid

IF @offerexdate >= CURRENT_TIMESTAMP
BEGIN
	UPDATE Product
	SET final_price=price-((price*@offeramount)/100)
	WHERE vendor_username=@vendorname AND serial_no=@serial

	INSERT INTO  offersOnProduct
	VALUES (@offerid,@serial)
END
ELSE
BEGIN
	print('The product has an active offer or the offer is expired')
END
END

drop proc applyOffer1
exec applyOffer1 'eslam.mahmod','1021','3039'

select * from offer
select * from Product
select * from offersOnProduct

--------------------------------------------------------ADMIN----------------------------------------------------------

--done
GO
CREATE PROC activateVendors
@admin_username varchar(20),
@vendor_username varchar(20),
@out int output
AS

if(exists(select * from Vendor where username = @vendor_username and activated = '1'))
begin set @out = '1' end 

else
begin 

if(not exists(select * from Vendor where username = @vendor_username ))
begin set @out = '2' end

else
begin 
UPDATE Vendor
SET Vendor.activated=1
WHERE username = @vendor_username

UPDATE Vendor
SET admin_username = @admin_username
WHERE username = @vendor_username
end 

end

drop proc activateVendors



exec activateVendors 'hana.aly' , 'aa'
select * from Vendor
select * from Admins
select * from Users

--done
GO
CREATE PROC inviteDeliveryPerson 
 @delivery_username varchar(20),
 @delivery_email varchar(50) 
 AS
 INSERT INTO USERS(username,email)
 VALUES (@delivery_username,@delivery_email)
 INSERT INTO Delivery_Person(username)
 VALUES(@delivery_username)
 exec inviteDeliveryPerson 'mohamed.tamer','moha@gmail.com'
 select * from Users
 select * from Delivery_Person

 --done 
 GO
 CREATE PROC  reviewOrders
 AS

UPDATE
    Table_A
SET
    Table_A.remaining_days = Table_B.time_duration - DAY(CURRENT_TIMESTAMP - Table_A.order_date) +1
FROM
    Orders AS Table_A
    INNER JOIN Delivery AS Table_B
        ON Table_A.delivery_id = Table_B.id

update Orders 
set remaining_days = 0
where remaining_days < 0

 SELECT * FROM Orders

 drop proc reviewOrders
 delete from Orders
 exec reviewOrders
 select * from Wishlist_Product

--done
 GO
 CREATE PROC  updateOrderStatusInProcess 
 @order_no int, @out int output
AS
if(not exists (select * from Orders where @order_no = order_no))
begin set @out = '1' end 
else begin
UPDATE Orders
SET order_status='IN PROCESS'
WHERE order_no=@order_no
end

drop proc updateOrderStatusInProcess
exec updateOrderStatusInProcess 202
select * from Orders

--done
GO
CREATE PROC  addDelivery 
@delivery_type varchar(20),
@time_duration int,
@fees decimal(5,3),
@admin_username varchar(20) 
AS
INSERT INTO Delivery(type,time_duration,fees,username)
VALUES(@delivery_type,@time_duration,@fees,@admin_username)
exec addDelivery 'speedy' , 1 ,50 , 'hana.aly'
select * from Delivery

--done
GO 
CREATE PROC  assignOrdertoDelivery 
@delivery_username varchar(20),
@order_no int,
@admin_username varchar(20) 
AS
INSERT INTO Admin_Delivery_Order(delivery_username,order_no,admin_username)
VALUES(@delivery_username,@order_no,@admin_username)

exec assignOrdertoDelivery 'mohamed.tamer',4,'hana.aly'
select * from Admin_Delivery_Order

--done
GO
CREATE PROC createTodaysDeal
 @deal_amount int,
 @admin_username varchar(20),
 @expiry_date datetime
 AS
 INSERT INTO Todays_Deals(deal_amount,admin_username,expiry_date)
 VALUES(@deal_amount,@admin_username,@expiry_date)
 exec createTodaysDeal 39 , 'hana.aly' , ''
 select * from Todays_Deals

--done 
 GO
 CREATE PROC  checkTodaysDealOnProduct 
 @serial_no INT, 
 @activeDeal BIT OUTPUT
 AS
 if exists(select serial_no from Todays_Deals_Product
where serial_no=@serial_no)
set @activeDeal=1
else
set @activeDeal=0
declare @active bit 
exec checkTodaysDealOnProduct 2014,@active output
print @active

--done
GO
CREATE PROC  addTodaysDealOnProduct 
@deal_id int,
@serial_no int,
@out int output
AS
if(not exists (select * from Product where serial_no=@serial_no))
begin set @out ='2' end 

else begin 
if(not exists (select * from Todays_Deals where deal_id=@deal_id))
begin set @out ='3' end 
else begin 


declare @Offer bit
EXEC checkOﬀeronProduct @serial_no,@Offer OUTPUT

declare @TodaysDeal bit
exec checkTodaysDealOnProduct @serial_no,@TodaysDeal OUTPUT



if(exists(select expiry_date 
					from Todays_Deals 
					where CURRENT_TIMESTAMP<expiry_date and @deal_id=deal_id))

	begin
		if(@Offer=0 and @TodaysDeal = 0)
			begin
				INSERT INTO Todays_Deals_Product 
				VALUES(@deal_id,@serial_no)

				declare @amount decimal(10,2) 
				select @amount = deal_amount
				from Todays_Deals 
				where @deal_id = deal_id
			
				declare @final_price decimal(10,2)
				select @final_price = final_price from Product where serial_no = @serial_no

				declare @percent decimal(10,2) 
				set @percent = cast(@amount as float) / cast(100 as float)

				declare @mul decimal(10,2) 
				set @mul = cast(@percent as float) * cast(@final_price as float)


				declare @res decimal(10,2)
				set @res = cast(@final_price as float) - cast(@mul as float)


				UPDATE Product
				SET final_price = @res
				where serial_no = @serial_no
			end 
		else
		begin
			print 'The product has an active offer'
			set @out = '1'
		end
	end
	else 
	begin set @out = '4'
	end 

end 

end

drop proc addTodaysDealOnProduct
exec addTodaysDealOnProduct 1009,2015
select * from Todays_Deals
update Todays_Deals set deal_amount = 37.5
select * from Todays_Deals_Product
delete from Todays_Deals_Product
select * from Product
update product set final_price = 12 where serial_no  =2


--done
GO
CREATE PROC removeExpiredDeal
@deal_iD int,
@out int output 
AS

if(exists(select * from Todays_Deals where @deal_iD = deal_id))
begin

		if exists(select expiry_date 
					from Todays_Deals 
					where CURRENT_TIMESTAMP>expiry_date and @deal_iD=deal_id)
		begin
		set @out = '1'
		declare @amount INT
		select @amount = Todays_Deals.deal_amount
		from Todays_Deals
		where deal_id = @deal_iD
		UPDATE
			Table_A
		SET
			Table_A.final_price=Table_A.price
		FROM
			Product AS Table_A
			INNER JOIN Todays_Deals_Product AS Table_B
				ON Table_A.serial_no = Table_B.serial_no
		where Table_B.deal_id = @deal_iD

		delete 
		from Todays_Deals_Product
		where deal_id=@deal_iD

		delete 
		from Todays_Deals 
		where deal_id=@deal_iD
		end
		else
		begin
		set @out = '2'
		end 
end 
else
begin
set @out='3'
end

drop proc removeExpiredDeal
exec removeExpiredDeal 1009
select * from Todays_Deals
select * from Product

--done
GO
CREATE PROC  createGiftCard 
@code varchar(10),
@expiry_date datetime,
@amount int,
@admin_username varchar(20) 
AS
INSERT INTO Giftcard VALUES(@code,@expiry_date,@amount,@admin_username)
exec createGiftCard 'G101', '2019/11/26' ,70, 'hana.aly'
select * from Giftcard

--done
GO
CREATE PROC giveGiftCardtoCustomer
@code varchar(10),
@customer_name varchar(20),
@admin_username varchar(20) 
AS
declare @amount int 
select @amount = g.amount
from Giftcard g
where g.code=@code

INSERT INTO Admin_Customer_Giftcard(code,customer_name,admin_username,remaining_points)
Values(@code,@customer_name,@admin_username,@amount)
UPDATE Customer
SET points = points+@amount
WHERE Customer.username=@customer_name

exec giveGiftCardtoCustomer 'G101' ,'ahmed.ashraf' , 'hana.aly'
select * from Users
select * from Admins
select * from Customer
select * from Giftcard
select * from Admin_Customer_Giftcard
delete from Admin_Customer_Giftcard
update Customer set points = 0 where username = 'ahmed.ashraf'
 

 --------------------------------------DELIVEY PERSONNEL---------------------------------


 INSERT INTO Admin_Customer_Giftcard(code,customer_name,admin_username,remaining_points)
Values('G101' ,'​ammar.yasser' , 'hana.aly',100)

--done
GO
CREATE PROC removeExpiredGiftCard
@code varchar(10)
AS
if exists(select expiry_date 
			from Giftcard 
			where CURRENT_TIMESTAMP>expiry_date and @code=code)
begin 

UPDATE
    Table_A
SET
    Table_A.points = Table_A.points - Table_B.remaining_points
FROM
    Customer AS Table_A
    INNER JOIN Admin_Customer_Giftcard AS Table_B
        ON Table_A.username = Table_B.customer_name
where Table_B.code = @code

update Orders
set Gift_Card_code_used = null
where Gift_Card_code_used = @code

delete from Admin_Customer_Giftcard where code= @code

delete from Giftcard where code= @code
end 

drop proc removeExpiredGiftCard
exec removeExpiredGiftCard 'G101'
select * from Admin_Customer_Giftcard
select * from Giftcard
select * from Customer


--done
GO 
CREATE PROC checkGiftCardOnCustomer
@username varchar(20),
@activeGiftCard BIT OUTPUT 
AS 
if(exists (select * 
			from Admin_Customer_Giftcard
			where @username = customer_name))
SET @activeGiftCard = 1
ELSE
SET @activeGiftCard = 0 

declare @active bit
EXEC checkGiftCardOnCustomer 'ahmed.ashraf', @active output
print @active


---------------------------------------------------Delivery Personnel-----------------------------------------------------
 
 --done
 GO
 CREATE PROC acceptAdminInvitation
 @delivery_username varchar(20)
 AS
 UPDATE	Delivery_Person
 SET is_activated=1
 WHERE @delivery_username=username

 exec acceptAdminInvitation 'mohamed.tamer'
 select * from Delivery_Person

 --done
 GO
 CREATE PROC  deliveryPersonUpdateInfo 
 @username  varchar(20),
 @ﬁrst_name varchar(20),
 @last_name varchar(20),
 @password varchar(20),
 @email varchar(50) 
 AS
 UPDATE Users
 SET first_name=@ﬁrst_name , last_name=@last_name , password=@password , email=@email
 where Users.username=@username

 exec deliveryPersonUpdateInfo 'mohamed.tamer','mohamed' ,'tamer','pass16','mohamed.tamer@guc.edu.eg' 
 select * from Users


 --done
 GO
 CREATE PROC viewAllOrdersAssinedTO
 @username varchar(20)
 AS
 SELECT o.* 
 from Orders o inner join Admin_Delivery_Order ado ON o.order_no = ado.order_no
 where ado.delivery_username = @username

 exec viewAllOrdersAssinedTO 'mohamed.tamer'


 --done
 GO
 CREATE PROC specifyDeliveryWindow
 @delivery_username varchar(20),
 @order_no int,
 @delivery_window varchar(50)
 AS
 UPDATE Admin_Delivery_Order
 SET delivery_window=@delivery_window
 WHERE delivery_username=@delivery_username AND order_no=@order_no

 exec specifyDeliveryWindow 'mohamed.tamer',4,'Today between 10 am and 3 pm'
 select * from Admin_Delivery_Order


 select * from CustomerAddstoCartProduct
 select * from Customer
 select * from Product
 insert into CustomerAddstoCartProduct values(3,'ahmed.ashraf')


 --done
 GO
 CREATE PROC  updateOrderStatusOutforDelivery 
 @order_no int
 AS
 UPDATE Orders
 SET order_status='OUT FOR DELIEVERY'
 WHERE order_no=@order_no

 exec updateOrderStatusOutforDelivery 4
 select * from Orders


 --done
  GO
 CREATE PROC  updateOrderStatusDelivered  
 @order_no int
 AS
 UPDATE Orders
 SET order_status='DELIEVERD'
 WHERE order_no=@order_no

 exec updateOrderStatusDelivered 4
 select * from Orders




