/****** Object:  Table [dbo].[appUser] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[appUser](
	[userId] [int] IDENTITY(1,1) NOT NULL,
	[firstName] [nvarchar](255) NULL,
	[lastName] [nvarchar](255) NULL,
	[email] [nvarchar](255) NOT NULL,
	[password] [nvarchar](255) NOT NULL,
	[role] [nvarchar](7) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[userId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object: Table [dbo].[product] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product](
    [productId] [int] IDENTITY(1,1) NOT NULL,
	[categoryId] [int] NULL,
	[productName] [nvarchar](255) NOT NULL,
	[productDescription] [nvarchar](255) NULL,
	[productStock] [int] NOT NULL,
	[productPrice] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[productId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object: Table [dbo].[category] ******/

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[category](
	[categoryId] [int] IDENTITY(1,1) NOT NULL,
	[categoryName] [nvarchar](255) NOT NULL,
	[categoryDescription] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[categoryId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET IDENTITY_INSERT [dbo].[appUser] ON 
GO
INSERT [dbo].[appUser] ([userId], [firstName], [lastName], [email], [password], [role]) VALUES (1, N'Mark', N'Bolster', N'mark@web.com', N'password', N'admin')
GO
INSERT [dbo].[appUser] ([userId], [firstName], [lastName], [email], [password], [role]) VALUES (2, N'John', N'Manager', N'john@web.com', N'password', N'manager')
GO
INSERT [dbo].[appUser] ([userId], [firstName], [lastName], [email], [password], [role]) VALUES (3, N'Jain', N'User', N'jain@web.com', N'password', N'user')
GO
SET IDENTITY_INSERT [dbo].[appUser] OFF
GO


SET IDENTITY_INSERT [dbo].[category] ON
GO
INSERT [dbo].[category] ([categoryId], [categoryName], [categoryDescription]) VALUES (1, N'White goods', N'Fridges, Freezers, Washing Machines, Dryers, Dish Washers, Microwaves, Vaccum Cleaners, Kitchen Appliences')
GO
INSERT [dbo].[category] ([categoryId], [categoryName], [categoryDescription]) VALUES (2, N'Entertainment', N'TVs, Audio, AV Accessories, TV Stands & Wall Mounts')
GO
INSERT [dbo].[category] ([categoryId], [categoryName], [categoryDescription]) VALUES (3, N'Compters', N'Desktops, Laptops, Tables, Phones, Monitors, Drones, Computer Accessories, Cameras, Printers & Accessories, Networking')
GO
SET IDENTITY_INSERT [dbo].[category] OFF
GO

SET IDENTITY_INSERT [dbo].[product] ON 
GO
INSERT [dbo].[product] ([productId], [categoryId], [productName], [productDescription], [productStock], [productPrice]) VALUES (1, 2, N'TV', N'43" LG UHD 4K Smart Tv', 30, CAST(429.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[product] ([productId], [categoryId], [productName], [productDescription], [productStock], [productPrice]) VALUES (2, 1, N'Fridge', N'Samsung non plumbed Aerican style fridge, Black, Frost free, Freezer drawer', 5, CAST(999.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[product] ([productId], [categoryId], [productName], [productDescription], [productStock], [productPrice]) VALUES (3, 3, N'Laptop', N'HP Specture x360, i5, 8GB RAM, 255 SSD Storage, 15 hour battey life, Windows 10, Full HD display', 10, CAST(1299.00 AS Decimal(10, 2)))
GO
SET IDENTITY_INSERT [dbo].[Product] OFF
GO
ALTER TABLE [dbo].[product] ADD  DEFAULT ((0)) FOR [productStock]
GO
ALTER TABLE [dbo].[product] ADD  DEFAULT ((0.00)) FOR [productPrice]
GO
ALTER TABLE [dbo].[product]  WITH CHECK ADD FOREIGN KEY([categoryId])
REFERENCES [dbo].[category] ([categoryId])
GO

SELECT * FROM [dbo].[category];
SELECT * FROM [dbo].[appUser];
SELECT * FROM [dbo].[product];

CREATE USER adminUser WITH PASSWORD = '$32913895B';

GRANT SELECT, INSERT , UPDATE, DELETE ON OBJECT::dbo.category to adminUser;
GRANT SELECT, INSERT , UPDATE, DELETE ON OBJECT::dbo.product to adminUser;
GRANT SELECT, INSERT , UPDATE, DELETE ON OBJECT::dbo.appUser to adminUser;