
-- ==========================
-- BẢNG NGƯỜI DÙNG
-- ==========================
CREATE TABLE [dbo].[Users](
	[user_id] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](50) NOT NULL,
	[password] [varchar](255) NOT NULL,
	[email] [varchar](100) NULL,
	[phone_number] [varchar](20) NULL,
	[role] [varchar](50) NULL,
	[created_at] [datetime] NULL,
	[status] [nvarchar](50) NULL,
	[note] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

-- ==========================
-- BẢNG STAFF (ĐỔI TÊN TỪ HOST)
-- ==========================


-- ==========================
-- BẢNG KHU VỰC
-- ==========================
CREATE TABLE Areas
(
    area_id INT PRIMARY KEY IDENTITY(1,1),
    name NVARCHAR(100) NOT NULL,
    location NVARCHAR(255), 
    manager_id INT NOT NULL,
    court INT,
    open_time TIME NOT NULL,
    close_time TIME NOT NULL,
    descriptions NVARCHAR(MAX),
   FOREIGN KEY (manager_id) REFERENCES Users(user_id),

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
    price DECIMAL(10,2),
    area_id INT NOT NULL,
    open_time TIME NULL,
    close_time TIME NULL,
    FOREIGN KEY (area_id) REFERENCES Areas(area_id),
    CONSTRAINT chk_court_time CHECK (open_time IS NULL OR close_time IS NULL OR open_time < close_time),
    CONSTRAINT uq_court_number UNIQUE (court_number, area_id)
);

-- ==========================
-- BẢNG GIÁ THUÊ SÂN
-- ==========================
CREATE TABLE Court_Pricing (
    pricing_id INT PRIMARY KEY IDENTITY(1,1),
    court_id INT NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (court_id) REFERENCES Courts(court_id),
    CONSTRAINT chk_pricing_time CHECK (start_time < end_time)
);



-- ==========================
-- BẢNG ĐẶT SÂN
-- ==========================
CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT NOT NULL,
    court_id INT NOT NULL,
    date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    status NVARCHAR(50),
    rating INT CHECK (rating BETWEEN 1 AND 5),
    total_price DECIMAL(10,2),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (court_id) REFERENCES Courts(court_id),
    CONSTRAINT chk_booking_time CHECK (start_time < end_time)
);

-- ==========================
-- BẢNG DỊCH VỤ
-- ==========================
CREATE TABLE BadmintonService
(
    service_id INT PRIMARY KEY IDENTITY(1,1),
    name NVARCHAR(100) NOT NULL UNIQUE,
    price DECIMAL(10, 2) NOT NULL CHECK (price >= 0),
    description NVARCHAR(MAX),
    image_url NVARCHAR(255),
    status NVARCHAR(50) DEFAULT 'Active',
	created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME,
    is_deleted BIT DEFAULT 0
);
CREATE TABLE Booking_Services (
    id INT PRIMARY KEY IDENTITY(1,1) ,
    booking_id INT,
    service_id INT,
    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id),
    FOREIGN KEY (service_id) REFERENCES BadmintonService(service_id)
);

CREATE TABLE Areas_Services
(
    AreaServices_id INT PRIMARY KEY IDENTITY(1,1),
    service_id INT NOT NULL,
    area_id INT,
    FOREIGN KEY (area_id) REFERENCES Areas(area_id),
    FOREIGN KEY (service_id) REFERENCES BadmintonService(service_id)
);

-- ==========================
-- BẢNG BÀI VIẾT
-- ==========================
CREATE TABLE Posts (
    post_id INT PRIMARY KEY IDENTITY(1,1),
    title NVARCHAR(255) NOT NULL,
    content NVARCHAR(MAX) NOT NULL,
    created_by INT NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
	image VARCHAR(255),
    type VARCHAR(20) CHECK (type IN ('news', 'partner', 'common')) NOT NULL,

    status VARCHAR(20) CHECK (status IN ('pending', 'approved', 'rejected')) DEFAULT 'pending',

    FOREIGN KEY (created_by) REFERENCES Users(user_id)
);

-- ==========================
-- BẢNG EMOTION
-- ==========================
CREATE TABLE PostReactions (
    id INT PRIMARY KEY IDENTITY(1,1),
    post_id INT NOT NULL,
    user_id INT NOT NULL,
    reaction_type VARCHAR(20) NOT NULL, -- ví dụ: 'like', 'love', 'haha', 'sad'
    reacted_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (post_id) REFERENCES Posts(post_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    CONSTRAINT UQ_UserPost UNIQUE (post_id, user_id)
);


-- ==========================
-- BẢNG BÌNH LUẬN
-- ==========================
CREATE TABLE Comments (
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

	CREATE TABLE [dbo].[Notification](
	[notification_id] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](255) NOT NULL,
	[content] [nvarchar](max) NOT NULL,
	[image_url] [nvarchar](255) NULL,
	[created_by] [int] NOT NULL,
	[scheduled_time] [datetime] NULL,
	[sent_time] [datetime] NULL,
	[status] [varchar](20) NOT NULL,
	[created_at] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[notification_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Notification_Receiver]    Script Date: 6/14/2025 11:42:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notification_Receiver](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[notification_id] [int] NOT NULL,
	[user_id] [int] NOT NULL,
	[is_read] [bit] NOT NULL,
	[read_at] [datetime] NULL,
	[opened_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO



-- ==========================
-- BẢNG THẺ TAG CHO FAQ
-- ==========================
CREATE TABLE faq_tag (
    tag_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL UNIQUE
);

-- ==========================
-- BẢNG CÂU HỎI FAQ
-- ==========================
CREATE TABLE faq_question (
    question_id INT IDENTITY(1,1) PRIMARY KEY,
    title NVARCHAR(255) NOT NULL,
    tag_id INT NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME,
    FOREIGN KEY (tag_id) REFERENCES faq_tag(tag_id)
);

-- ==========================
-- BẢNG TRẢ LỜI FAQ
-- ==========================
CREATE TABLE faq_answer (
    answer_id INT IDENTITY(1,1) PRIMARY KEY,
    question_id INT NOT NULL,
    content NVARCHAR(MAX) NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME,
    FOREIGN KEY (question_id) REFERENCES faq_question(question_id)
);

