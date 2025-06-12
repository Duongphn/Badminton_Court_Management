

-- ==========================
-- BẢNG NGƯỜI DÙNG
-- ==========================
CREATE TABLE Users
(
    user_id INT PRIMARY KEY IDENTITY(1,1),
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100),
    phone_number VARCHAR(20),
    role VARCHAR(50),
    created_at DATETIME DEFAULT GETDATE()
);

-- ==========================
-- BẢNG STAFF (ĐỔI TÊN TỪ HOST)
-- ==========================
CREATE TABLE Staff (
    staff_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT NOT NULL UNIQUE,
    full_name NVARCHAR(100) NOT NULL,
    gender NVARCHAR(10),
    date_of_birth DATE,
    address NVARCHAR(255),
    phone_number VARCHAR(20),
    id_card_number VARCHAR(20),
    education_level NVARCHAR(100),
    personal_notes NVARCHAR(MAX),
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- ==========================
-- BẢNG KHU VỰC
-- ==========================
CREATE TABLE Areas
(
    area_id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(100) NOT NULL,
    location VARCHAR(255),
    manager_id INT NOT NULL,
    EmptyCourt INT,
    open_time TIME NOT NULL,
    close_time TIME NOT NULL,
    descriptions NVARCHAR(MAX),
    FOREIGN KEY (manager_id) REFERENCES Staff(user_id),  -- Tham chiếu đến Staff thay vì Host
    CONSTRAINT chk_area_time CHECK (open_time < close_time)
);

CREATE TABLE Area_Image
(
    imageID INT PRIMARY KEY IDENTITY(1,1),
    area_id INT,
    imageURL TEXT,
    FOREIGN KEY (area_id) REFERENCES Areas(area_id)
);

-- ==========================
-- BẢNG GIÁ THUÊ SÂN
-- ==========================
CREATE TABLE Court_Pricing
(
    pricing_id INT PRIMARY KEY IDENTITY(1,1),
    area_id INT NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (area_id) REFERENCES Areas(area_id),
    CONSTRAINT chk_pricing_time CHECK (start_time < end_time)
);

-- ==========================
-- BẢNG SÂN
-- ==========================
CREATE TABLE Courts
(
    court_id INT PRIMARY KEY IDENTITY(1,1),
    court_number VARCHAR(50) NOT NULL,
    type NVARCHAR(50),
    floor_material NVARCHAR(50),
    lighting NVARCHAR(50),
    description NVARCHAR(255),
    image_url NVARCHAR(255),
    [status] NVARCHAR(50),
    area_id INT NOT NULL,
    open_time TIME NULL,
    close_time TIME NULL,
    FOREIGN KEY (area_id) REFERENCES Areas(area_id),
    CONSTRAINT chk_court_time CHECK (open_time IS NULL OR close_time IS NULL OR open_time < close_time),
    CONSTRAINT uq_court_number UNIQUE (court_number, area_id)
);

-- ==========================
-- BẢNG ĐẶT SÂN
-- ==========================
CREATE TABLE Bookings
(
    booking_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT NOT NULL,
    court_id INT NOT NULL,
    date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    [status] NVARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (court_id) REFERENCES Courts(court_id),
    CONSTRAINT chk_booking_time CHECK (start_time < end_time)
);

-- ==========================
-- BẢNG THIẾT BỊ
-- ==========================
CREATE TABLE Services
(
    services_id INT PRIMARY KEY IDENTITY(1,1),
    name NVARCHAR(100) NOT NULL UNIQUE,
    price DECIMAL(10, 2) NOT NULL CHECK (price >= 0),
    description NVARCHAR(MAX),
    image_url VARCHAR(255),
    status NVARCHAR(50) DEFAULT 'Active',
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME,
    is_deleted BIT DEFAULT 0
);

CREATE TABLE Areas_Services
(
    AreaServices_id INT PRIMARY KEY IDENTITY(1,1),
    services_id INT NOT NULL,
    area_id INT,
    FOREIGN KEY (area_id) REFERENCES Areas(area_id),
    FOREIGN KEY (services_id) REFERENCES Services(services_id)
);

-- ==========================
-- BẢNG BÀI VIẾT
-- ==========================
CREATE TABLE Posts
(
    post_id INT PRIMARY KEY IDENTITY(1,1),
    title VARCHAR(255) NOT NULL,
    content VARCHAR(MAX) NOT NULL,
    created_by INT NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    type VARCHAR(20),
    FOREIGN KEY (created_by) REFERENCES Users(user_id)
);

-- ==========================
-- BẢNG BÌNH LUẬN
-- ==========================
CREATE TABLE Comments
(
    comment_id INT PRIMARY KEY IDENTITY(1,1),
    post_id INT NOT NULL,
    user_id INT NOT NULL,
    content VARCHAR(MAX) NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (post_id) REFERENCES Posts(post_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- ==========================
-- BẢNG ĐÁNH GIÁ
-- ==========================
CREATE TABLE Reviews
(
    review_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT NOT NULL,
    area_id INT NOT NULL,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment VARCHAR(MAX),
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (area_id) REFERENCES Areas(area_id)
);

-- ==========================
-- BẢNG MÃ RESET MẬT KHẨU
-- ==========================
CREATE TABLE [dbo].[password_reset_tokens]
(
    [id] INT IDENTITY(1,1) NOT NULL,
    [user_id] INT NOT NULL,
    [token] VARCHAR(255) NOT NULL,
    [created_at] DATETIME NULL,
    [is_used] BIT NULL,
    PRIMARY KEY CLUSTERED ([id] ASC),
    UNIQUE NONCLUSTERED ([token] ASC)
);

ALTER TABLE [dbo].[password_reset_tokens] ADD  DEFAULT (getdate()) FOR [created_at];
ALTER TABLE [dbo].[password_reset_tokens] ADD  DEFAULT ((0)) FOR [is_used];
ALTER TABLE [dbo].[password_reset_tokens] 
    ADD CONSTRAINT FK_password_reset_user 
    FOREIGN KEY([user_id]) REFERENCES [dbo].[Users] ([user_id]) ON DELETE CASCADE;
