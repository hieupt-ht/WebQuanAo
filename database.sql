-- ============================================
-- DATABASE: Web Shop Quần Áo
-- SQL Server Version
-- ============================================

-- Tạo database
USE master;
GO

IF EXISTS (SELECT name FROM sys.databases WHERE name = N'shopquanao')
BEGIN
    ALTER DATABASE shopquanao SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE shopquanao;
END
GO

CREATE DATABASE shopquanao;
GO

USE shopquanao;
GO

-- ============================================
-- 1. USERS
-- ============================================
CREATE TABLE users (
    id INT IDENTITY(1,1) PRIMARY KEY,
    username NVARCHAR(50) NOT NULL UNIQUE,
    password NVARCHAR(255) NOT NULL,
    fullname NVARCHAR(100) NOT NULL,
    email NVARCHAR(100) NOT NULL UNIQUE,
    phone NVARCHAR(20),
    address NVARCHAR(255),
    role NVARCHAR(10) NOT NULL DEFAULT 'USER' CHECK (role IN ('USER', 'ADMIN')),
    created_at DATETIME DEFAULT GETDATE()
);
GO

-- ============================================
-- 1.1 USER_ADDRESSES
-- ============================================
CREATE TABLE user_addresses (
    id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    receiver_name NVARCHAR(100) NOT NULL,
    phone NVARCHAR(20) NOT NULL,
    address_detail NVARCHAR(500) NOT NULL,
    is_default BIT NOT NULL DEFAULT 0,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
GO

-- ============================================
-- 2. CATEGORIES
-- ============================================
CREATE TABLE categories (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL UNIQUE,
    description NVARCHAR(MAX)
);
GO

-- ============================================
-- 3. PRODUCTS
-- ============================================
CREATE TABLE products (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(200) NOT NULL,
    description NVARCHAR(MAX),
    price DECIMAL(12,2) NOT NULL CHECK (price >= 0),
    image NVARCHAR(MAX),
    size NVARCHAR(50),
    color NVARCHAR(50),
    stock INT NOT NULL DEFAULT 0 CHECK (stock >= 0),
    category_id INT NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE NO ACTION ON UPDATE CASCADE
);
GO

-- ============================================
-- 4. ORDERS
-- ============================================
CREATE TABLE orders (
    id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    fullname NVARCHAR(100) NOT NULL,
    phone NVARCHAR(20) NOT NULL,
    address NVARCHAR(255) NOT NULL,
    total_amount DECIMAL(12,2) NOT NULL CHECK (total_amount >= 0),
    status NVARCHAR(20) NOT NULL DEFAULT 'PENDING' CHECK (status IN ('PENDING', 'SHIPPING', 'COMPLETED', 'CANCELLED')),
    payment_method NVARCHAR(10) NOT NULL DEFAULT 'COD' CHECK (payment_method IN ('COD', 'ONLINE')),
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE NO ACTION ON UPDATE CASCADE
);
GO

-- ============================================
-- 5. ORDER_DETAILS
-- ============================================
CREATE TABLE order_details (
    id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    price DECIMAL(12,2) NOT NULL CHECK (price >= 0),
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE NO ACTION ON UPDATE NO ACTION
);
GO

-- ============================================
-- 6. CART
-- ============================================
CREATE TABLE cart (
    id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL UNIQUE,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
GO

-- ============================================
-- 7. CART_ITEMS
-- ============================================
CREATE TABLE cart_items (
    id INT IDENTITY(1,1) PRIMARY KEY,
    cart_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL DEFAULT 1 CHECK (quantity > 0),
    CONSTRAINT uk_cart_product UNIQUE (cart_id, product_id),
    FOREIGN KEY (cart_id) REFERENCES cart(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);
GO

-- ============================================
-- 8. PAYMENTS
-- ============================================
CREATE TABLE payments (
    id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT NOT NULL,
    method NVARCHAR(10) NOT NULL DEFAULT 'COD' CHECK (method IN ('COD', 'ONLINE')),
    amount DECIMAL(12,2) NOT NULL CHECK (amount >= 0),
    status NVARCHAR(20) NOT NULL DEFAULT 'PENDING' CHECK (status IN ('PENDING', 'COMPLETED', 'FAILED')),
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE ON UPDATE CASCADE
);
GO

-- ============================================
-- SAMPLE DATA
-- ============================================

-- Admin user (password: admin123 - SHA-256 hashed)
INSERT INTO users (username, password, fullname, email, phone, address, role) VALUES
('admin', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', N'Administrator', 'admin@shop.com', '0123456789', N'Hà Nội', 'ADMIN');
INSERT INTO users (username, password, fullname, email, phone, address, role) VALUES
('user1', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', N'Nguyễn Văn A', 'user1@shop.com', '0987654321', N'TP.HCM', 'USER');
GO

-- Categories
INSERT INTO categories (name, description) VALUES (N'Áo Nam', N'Các loại áo dành cho nam giới');
INSERT INTO categories (name, description) VALUES (N'Áo Nữ', N'Các loại áo dành cho nữ giới');
INSERT INTO categories (name, description) VALUES (N'Quần Nam', N'Các loại quần dành cho nam giới');
INSERT INTO categories (name, description) VALUES (N'Quần Nữ', N'Các loại quần dành cho nữ giới');
GO

-- Products - Áo Nam (category_id = 1)
INSERT INTO products (name, description, price, image, size, color, stock, category_id) VALUES
(N'Áo Thun Nam Basic Form Rộng', N'Áo thun cotton 100% cao cấp, form ống rộng oversize thoải mái, thấm hút mồ hôi tốt. Phù hợp mặc đi chơi, đi dạo.', 150000, 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80', 'M,L,XL', N'Trắng,Đen,Xanh', 100, 1);
INSERT INTO products (name, description, price, image, size, color, stock, category_id) VALUES
(N'Áo Sơ Mi Nam Công Sở Tay Dài', N'Áo sơ mi vải chống nhăn cao cấp, đường may tỉ mỉ. Form chuẩn ôm vừa vặn, lịch sự khi đi làm.', 350000, 'https://images.unsplash.com/photo-1598033129183-c4f50c736f10?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80', 'S,M,L,XL', N'Trắng,Xanh nhạt', 80, 1);
INSERT INTO products (name, description, price, image, size, color, stock, category_id) VALUES
(N'Áo Hoodie Nam Streetwear Phối Màu', N'Áo hoodie nỉ bông ấm áp, thiết kế streetwear trẻ trung năng động. Mũ rộng, có túi trước bụng lớn.', 450000, 'https://images.unsplash.com/photo-1556821840-3a63f95609a7?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80', 'M,L,XL,XXL', N'Xám,Đen,Cam', 60, 1);
INSERT INTO products (name, description, price, image, size, color, stock, category_id) VALUES
(N'Áo Khoác Nam Bomber Thời Trang', N'Áo khoác bomber lót dù mỏng nhẹ, giữ ấm vừa phải, phong cách bụi bặm, cạp chun bo gấu.', 490000, 'https://images.unsplash.com/photo-1591047139829-d91aecb6caea?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80', 'M,L,XL', N'Đen,Xanh Rêu,Navy', 40, 1);
INSERT INTO products (name, description, price, image, size, color, stock, category_id) VALUES
(N'Áo Polo Nam Cotton Kháng Khuẩn', N'Áo polo có cổ vải thun cá sấu cao cấp, tính năng kháng khuẩn khử mùi, mặc hè cực kỳ mát và lịch sự.', 280000, 'https://images.unsplash.com/photo-1581655353564-df123a1eb820?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80', 'M,L,XL', N'Trắng,Navy,Đỏ', 120, 1);

-- Products - Áo Nữ (category_id = 2)
INSERT INTO products (name, description, price, image, size, color, stock, category_id) VALUES
(N'Áo Kiểu Nữ Cổ V Tay Phồng', N'Áo lụa mỏng nhẹ, kiểu dáng tay bồng Vintage, cổ V quyến rũ tôn dáng.', 220000, 'https://images.unsplash.com/photo-1551794025-783262fbac56?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80', 'S,M,L', N'Trắng,Hồng nhạt', 90, 2);
INSERT INTO products (name, description, price, image, size, color, stock, category_id) VALUES
(N'Áo Thun Nữ Croptop Năng Động', N'Áo croptop chất thun ôm sát eo, phong cách trẻ trung phù hợp quần cạp cao.', 120000, 'https://images.unsplash.com/photo-1503342217505-b0a15ec3261c?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80', 'S,M', N'Đen,Trắng,Vàng', 150, 2);
INSERT INTO products (name, description, price, image, size, color, stock, category_id) VALUES
(N'Áo Sơ Mi Lụa Nữ Thanh Lịch', N'Sơ mi nữ đi làm chất liệu lụa Hàn quốc mát rượi, không nhăn, tạo nét đẹp công sở hiện đại.', 320000, 'https://images.unsplash.com/photo-1598522325826-5bfb4af1ea38?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80', 'S,M,L,XL', N'Kem,Trắng', 75, 2);
INSERT INTO products (name, description, price, image, size, color, stock, category_id) VALUES
(N'Áo Hai Dây Lụa Sexy Xẻ Ngực', N'Áo hai dây phối ren tinh tế, chất lụa tơ tằm nguyên chất đi tiệc sang chảnh.', 290000, 'https://images.unsplash.com/photo-1434389678369-18342cb315c1?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80', 'S,M', N'Đen,Đỏ mận', 55, 2);
INSERT INTO products (name, description, price, image, size, color, stock, category_id) VALUES
(N'Áo Len Cardigan Thu Đông', N'Áo len tăm cực mềm tay dài, dáng crop, màu sắc pastel ấm áp cho ngày se lạnh.', 380000, 'https://images.unsplash.com/photo-1620799140408-edc6dcb6d633?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80', 'Free Size', N'Be,Nâu,Trắng', 110, 2);

-- Products - Quần Nam (category_id = 3)
INSERT INTO products (name, description, price, image, size, color, stock, category_id) VALUES
(N'Quần Jeans Nam Slim Fit Co Dãn', N'Quần jeans ôm nhẹ, chất bò co dãn 4 chiều thoải mái vận động, vải không phai màu.', 420000, 'https://images.unsplash.com/photo-1542272604-787c3835535d?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80', '29,30,31,32', N'Xanh biển,Xanh đen', 85, 3);
INSERT INTO products (name, description, price, image, size, color, stock, category_id) VALUES
(N'Quần Tây Nam Âu Phục Hàn Quốc', N'Quần âu sáu ly giữ form ống suông chuẩn tổng tài, vải tuyết mưa bền đẹp.', 460000, 'https://images.unsplash.com/photo-1594938298598-70d04ae05d68?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80', '29,30,31,32,33', N'Đen,Ghi,Nâu sẫm', 95, 3);
INSERT INTO products (name, description, price, image, size, color, stock, category_id) VALUES
(N'Quần Short Kaki Nam Dạo Phố', N'Quần lửng ngang gối vải kaki thô đẹp, ống rộng rãi thoáng mát hợp thời trang đường phố mùa hè.', 250000, 'https://images.unsplash.com/photo-1591195853828-11db59a44f6b?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80', 'M,L,XL', N'Kem,Đen,Xanh Rêu', 130, 3);
INSERT INTO products (name, description, price, image, size, color, stock, category_id) VALUES
(N'Quần Jogger Thể Thao Năng Động', N'Quần thun thể thao jogger bo chun gót, thích hợp để tập gym, chạy bộ hoặc mix đồ casual.', 310000, 'https://images.unsplash.com/photo-1552902865-b72c031ac5ea?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80', 'M,L,XL,XXL', N'Xám,Đen', 105, 3);
INSERT INTO products (name, description, price, image, size, color, stock, category_id) VALUES
(N'Quần Túi Hộp Cargo Pants', N'Quần túi xéo lớn hầm hố, phong cách techwear cool ngầu phối đồ siêu cháy.', 480000, 'https://images.unsplash.com/photo-1550246140-5119ae4790b8?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80', 'L,XL,XXL', N'Đen,Be nhạt', 50, 3);

-- Products - Quần Nữ (category_id = 4)
INSERT INTO products (name, description, price, image, size, color, stock, category_id) VALUES
(N'Quần Ống Rộng Culottes Nữ', N'Quần ống rộng hack dáng siêu hot, kéo dài chân, chất tuyết mưa đứng form tôn vòng 3.', 280000, 'https://images.unsplash.com/photo-1594633312681-425c7b97ccd1?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80', 'S,M,L', N'Be,Đen,Trắng', 160, 4);
INSERT INTO products (name, description, price, image, size, color, stock, category_id) VALUES
(N'Quần Jeans Nữ Baggy Rách Gối', N'Quần jean baggy bụi bặm cut out rách chân tinh tế phong cách Hàn Quốc.', 350000, 'https://images.unsplash.com/photo-1541099649105-f69ad21f3246?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80', '26,27,28,29', N'Xanh nhạt', 110, 4);
INSERT INTO products (name, description, price, image, size, color, stock, category_id) VALUES
(N'Quần Short Jean Nữ Cá Tính', N'Quần short jean siêu ngắn, tua rua cực xịn tôn vòng 3 cho các nàng thích phong cách quyến rũ.', 190000, 'https://images.unsplash.com/photo-1582552462947-f273be8cc6e0?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80', 'S,M,L', N'Xanh đậm,Xanh nhạt,Đen', 200, 4);
INSERT INTO products (name, description, price, image, size, color, stock, category_id) VALUES
(N'Quần Legging Tập Gym Thể Thao', N'Quần trơn thể thao, độ nén cao co giãn đa chiều siêu đỉnh hỗ trợ tập luyện tối ưu.', 220000, 'https://images.unsplash.com/photo-1506629082955-511b1aa562c8?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80', 'S,M,L', N'Đen,Xám,Hồng', 140, 4);
INSERT INTO products (name, description, price, image, size, color, stock, category_id) VALUES
(N'Quần Tây Nữ Công Sở Lưng Cao', N'Quần tây nữ đai bọc vải đẹp cao cấp, may li ống suông trẻ trung chuyên đi làm văn phòng.', 330000, 'https://images.unsplash.com/photo-1553805847-fde0fbae47bb?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80', 'S,M,L,XL', N'Đen,Kem sáng', 80, 4);
GO
