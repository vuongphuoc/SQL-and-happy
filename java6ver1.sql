create database Java6ver1
use Java6ver1


CREATE TABLE Categories (
  id INT PRIMARY KEY Identity,
  Name VARCHAR(255)not null
);

-- Tạo bảng Products
CREATE TABLE Products (
  Id INT PRIMARY KEY Identity,
  Name VARCHAR(255) not null,
  Image VARCHAR(255) not null,
  Price DECIMAL(10, 2) not null,
  CreateDate DATE,
  Available int,
  CategoryId int ,
  FOREIGN KEY (CategoryId) REFERENCES Categories(Id)
);

-- Tạo bảng Orders
CREATE TABLE Orders (
  id INT PRIMARY KEY Identity,
  username VARCHAR(255) not null,
  createDate DATE,
  address VARCHAR(255) not null,
   FOREIGN KEY (username) REFERENCES Accounts(Username)

);
CREATE TABLE OrderDetails (
  id INT PRIMARY KEY Identity,
  orderId INT,
  productId INT,
  Price DECIMAL(10, 2),
  Quantity INT,
  FOREIGN KEY (orderId) REFERENCES Orders(id),
  FOREIGN KEY (productId) REFERENCES Products(Id)
);
-- Tạo bảng OrderDetails


-- Tạo bảng Accounts
CREATE TABLE Accounts (
  Username VARCHAR(255) PRIMARY KEY,
  Password VARCHAR(255) not null,
  Fullname VARCHAR(255) not null,
  Email VARCHAR(255) not null,
  Photo VARCHAR(255) not null
);

CREATE TABLE Authorities (
  Id int identity  PRIMARY KEY,
  Username VARCHAR(255)not null,
  RoleId varchar(10),
  FOREIGN KEY (Username) REFERENCES Accounts(Username),
  FOREIGN KEY (RoleId) REFERENCES Roles(Id)
);
CREATE TABLE Roles (
  Id VARCHAR(10) PRIMARY KEY,
  Name VARCHAR(255) not null,
);







INSERT INTO Categories (Name)
VALUES
('Electronics'),
('Books'),
('Clothing'),
('Home and Garden'),
('Sports');