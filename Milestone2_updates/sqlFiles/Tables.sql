CREATE TABLE Users(
username varchar(20),
password varchar(20),
first_name varchar(20), 
last_name varchar(20),  
email varchar(50) NOT NULL,
CONSTRAINT emailU Unique(email),
PRIMARY KEY(username)
);

CREATE TABLE User_mobile_numbers(
mobile_number INT, 
username varchar(20),
PRIMARY KEY(mobile_number,username),
FOREIGN KEY(username) references Users on delete cascade on update cascade
);
select * from User_mobile_numbers

CREATE TABLE User_Addresses(
address varchar(100), 
username varchar(20),
PRIMARY KEY(address,username),
FOREIGN KEY(username) references Users on delete cascade on update cascade
);

CREATE TABLE Customer(
username varchar(20), 
points DECIMAL(10,2) DEFAULT 0,
PRIMARY KEY(username),
FOREIGN KEY(username) references Users on delete cascade on update cascade
);

CREATE TABLE Admins(
username varchar(20),
PRIMARY KEY(username),
FOREIGN KEY(username) references Users on delete cascade on update cascade
);

CREATE TABLE Vendor(
username varchar(20), 
activated BIT DEFAULT 0, 
company_name varchar(20) NOT NULL, 
bank_acc_no INT NOT NULL, 
admin_username varchar(20),
PRIMARY KEY(username),
FOREIGN KEY(username) references Users,
FOREIGN KEY(admin_username) references Admins
);


CREATE TABLE Delivery_Person(
username varchar(20), 
is_activated BIT DEFAULT 0,
PRIMARY KEY(username),
FOREIGN KEY(username) references Users on delete cascade on update cascade
);

CREATE TABLE Credit_Card(
number varchar(20), 
expiry_date DATETIME NOT NULL, 
cvv_code INT NOT NULL,
PRIMARY KEY(number)
);
alter table Credit_Card
alter column expiry_date DATE not null
select * from Credit_Card


CREATE TABLE Delivery(
id INT IDENTITY,
type varchar(20) NOT NULL, 
time_duration INT NOT NULL,
fees DECIMAL(5,3) NOT NULL,
username varchar(20) NOT NULL,
PRIMARY KEY(id),
FOREIGN KEY(username) references Admins on delete cascade on update cascade
);
 
CREATE TABLE Orders(
order_no INT IDENTITY,
order_date DATETIME NOT NULL,
total_amount DECIMAL(10,2) NOT NULL,
cash_amount DECIMAL(10,2),
credit_amount DECIMAL(10,2),
payment_type varchar(20),
order_status varchar(20) DEFAULT 'NOT PROCESSED',
remaining_days INT,
time_limit TEXT,
customer_name varchar(20) NOT NULL,
delivery_id INT,
creditCard_number varchar(20),
PRIMARY KEY(order_no),
FOREIGN KEY(customer_name) references Customer,
FOREIGN KEY(delivery_id) references Delivery on delete cascade on update cascade,
FOREIGN KEY(creditCard_number) references Credit_Card on delete cascade on update cascade
);
select * from Customer

select * from orders
--no action
CREATE TABLE Product(
serial_no INT identity,
product_name varchar(20) NOT NULL,
category varchar(20) NOT NULL,
product_description varchar(1000) NOT NULL,
final_price DECIMAL(10,2) NOT NULL,
color varchar(20) NOT NULL,
available BIT DEFAULT 1 ,
rate DECIMAL(10,2),
vendor_username varchar(20) NOT NULL,
customer_username varchar(20),
customer_order_id INT,
PRIMARY KEY(serial_no),
FOREIGN KEY(vendor_username) references Vendor on delete cascade on update cascade ,
FOREIGN KEY(customer_username) references Customer ,
FOREIGN KEY(customer_order_id) references Orders on delete cascade on update cascade,
);
alter table Product 
alter column rate int 
select * from Product
--no action
CREATE TABLE CustomerAddstoCartProduct(
serial_no INT,
customer_name varchar(20),
PRIMARY KEY(serial_no,customer_name),
FOREIGN KEY(serial_no) references Product on delete no action on update no action,
FOREIGN KEY(customer_name) references Customer on delete cascade on update cascade,
); 

CREATE TABLE Todays_Deals(
deal_id INT IDENTITY,
deal_amount INT NOT NULL,
expiry_date DATETIME NOT NULL,
admin_username varchar(20) NOT NULL,
PRIMARY KEY(deal_id),
FOREIGN KEY(admin_username) references Admins on delete cascade on update cascade 
);



--no action
CREATE TABLE Todays_Deals_Product(
deal_id INT,
serial_no INT,
PRIMARY KEY(deal_id,serial_no),
FOREIGN KEY(deal_id) references Todays_Deals on delete no action on update no action,
FOREIGN KEY(serial_no) references Product on delete cascade on update cascade
); 

CREATE TABLE offer(
offer_id INT IDENTITY,
offer_amount DECIMAL(10,2) NOT NULL,
expiry_date DATETIME NOT NULL,
PRIMARY KEY(offer_id)
); 

CREATE TABLE offersOnProduct(
offer_id INT, 
serial_no INT,
PRIMARY KEY(offer_id,serial_no),
FOREIGN KEY(offer_id) references offer on delete cascade on update cascade,
FOREIGN KEY(serial_no) references Product on delete cascade on update cascade
);

--no action
CREATE TABLE Customer_Question_Product(
serial_no INT,
customer_name varchar(20) NOT NULL,
question varchar(50) NOT NULL, 
answer varchar(50),
PRIMARY KEY(serial_no,customer_name),
FOREIGN KEY(serial_no) references Product on delete no action on update no action,
FOREIGN KEY(customer_name) references Customer on delete cascade on update cascade
); 

CREATE TABLE Wishlist(
username varchar(20),
name varchar(20),
PRIMARY KEY(username, name),
FOREIGN KEY(username) references Customer on delete cascade on update cascade
);

CREATE TABLE Giftcard(
code varchar(10), 
expiry_date DATETIME NOT NULL,
amount INT NOT NULL,
username varchar(20) NOT NULL,
PRIMARY KEY(code),
FOREIGN KEY(username) references Admins on delete cascade on update cascade 
);

--no action
CREATE TABLE Wishlist_Product(
username varchar(20), 
wish_name varchar(20), 
serial_no INT,
PRIMARY KEY(username,wish_name,serial_no),
FOREIGN KEY(username,wish_name) references Wishlist on delete no action on update no action,
FOREIGN KEY(serial_no) references Product on delete cascade on update cascade
); 

--no action
--no action
CREATE TABLE Admin_Customer_Giftcard(
code varchar(10),
customer_name varchar(20),
admin_username varchar(20),
remaining_points int, 
PRIMARY KEY(code,customer_name,admin_username),
FOREIGN KEY(code) references Giftcard,
FOREIGN KEY(customer_name) references Customer,
FOREIGN KEY(admin_username) references Admins
);


--no action 
--no action
CREATE TABLE Admin_Delivery_Order(
delivery_username varchar(20), 
order_no INT,
admin_username varchar(20) NOT NULL,
delivery_window varchar(50),
PRIMARY KEY(delivery_username,order_no),
FOREIGN KEY(delivery_username) references Delivery_person on delete no action on update no action,
FOREIGN KEY(order_no) references Orders on delete no action on update no action,
FOREIGN KEY(admin_username) references Admins on delete cascade on update cascade
); 

CREATE TABLE Customer_CreditCard(
customer_name varchar(20),
cc_number varchar(20),
PRIMARY KEY(customer_name,cc_number),
FOREIGN KEY(customer_name) references Customer on delete cascade on update cascade,
FOREIGN KEY(cc_number) references Credit_Card on delete cascade on update cascade
);
