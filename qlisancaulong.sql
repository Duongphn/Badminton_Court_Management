USE [master]
GO
/****** Object:  Database [SWP]    Script Date: 7/8/2025 7:13:37 AM ******/
CREATE DATABASE [SWP]
USE [SWP]
GO

/****** Object:  Table [dbo].[Users]    Script Date: 7/8/2025 7:13:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
	[gender] [nvarchar](10) NULL,
	[firstname] [nvarchar](100) NULL,
	[lastname] [nvarchar](100) NULL,
	[fullname]  AS (concat([lastname],' ',[firstname])) PERSISTED NOT NULL,
	[date_of_birth] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
	
/****** Object:  Table [dbo].[Area_Image]    Script Date: 7/8/2025 7:13:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Area_Image](
	[imageID] [int] IDENTITY(1,1) NOT NULL,
	[area_id] [int] NULL,
	[imageURL] [text] NULL,
PRIMARY KEY CLUSTERED 
(
	[imageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Areas]    Script Date: 7/8/2025 7:13:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Areas](
	[area_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[location] [nvarchar](255) NULL,
	[manager_id] [int] NOT NULL,
	[court] [int] NULL,
	[open_time] [time](7) NOT NULL,
	[close_time] [time](7) NOT NULL,
	[descriptions] [nvarchar](max) NULL,
	[phone_area] [varchar](20) NULL,
	[nameStaff] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[area_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Areas_Services]    Script Date: 7/8/2025 7:13:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Areas_Services](
	[AreaServices_id] [int] IDENTITY(1,1) NOT NULL,
	[service_id] [int] NOT NULL,
	[area_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[AreaServices_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BadmintonService]    Script Date: 7/8/2025 7:13:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BadmintonService](
	[service_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[price] [decimal](10, 2) NOT NULL,
	[description] [nvarchar](max) NULL,
	[image_url] [nvarchar](255) NULL,
	[status] [nvarchar](50) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
	[is_deleted] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[service_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Banners]    Script Date: 7/8/2025 7:13:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Banners](
	[banner_id] [int] IDENTITY(1,1) NOT NULL,
	[image_url] [nvarchar](255) NOT NULL,
	[title] [nvarchar](255) NOT NULL,
	[caption] [nvarchar](500) NULL,
	[status] [bit] NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[banner_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Booking_Services]    Script Date: 7/8/2025 7:13:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Booking_Services](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[booking_id] [int] NULL,
	[service_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Bookings]    Script Date: 7/8/2025 7:13:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bookings](
	[booking_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[court_id] [int] NOT NULL,
	[date] [date] NOT NULL,
	[start_time] [time](7) NOT NULL,
	[end_time] [time](7) NOT NULL,
	[status] [nvarchar](50) NULL,
	[rating] [int] NULL,
	[total_price] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[booking_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChatbotMessages]    Script Date: 7/8/2025 7:13:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChatbotMessages](
	[message_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NULL,
	[message_content] [nvarchar](max) NOT NULL,
	[created_at] [datetime] NULL,
	[sender_type] [varchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[message_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChatbotResponses]    Script Date: 7/8/2025 7:13:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChatbotResponses](
	[response_id] [int] IDENTITY(1,1) NOT NULL,
	[intent] [nvarchar](255) NOT NULL,
	[response_text] [nvarchar](max) NOT NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[response_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChatbotSessions]    Script Date: 7/8/2025 7:13:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChatbotSessions](
	[session_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NULL,
	[started_at] [datetime] NULL,
	[ended_at] [datetime] NULL,
	[session_status] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[session_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


/****** Object:  Table [dbo].[Courts]    Script Date: 7/8/2025 7:13:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Courts](
	[court_id] [int] IDENTITY(1,1) NOT NULL,
	[court_number] [varchar](50) NOT NULL,
	[type] [nvarchar](50) NULL,
	[floor_material] [nvarchar](50) NULL,
	[lighting] [nvarchar](50) NULL,
	[description] [nvarchar](255) NULL,
	[image_url] [nvarchar](255) NULL,
	[status] [nvarchar](50) NULL,
	[area_id] [int] NOT NULL,
	[price] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[court_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [uq_court_number] UNIQUE NONCLUSTERED 
(
	[court_number] ASC,
	[area_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EventParticipants]    Script Date: 7/8/2025 7:13:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventParticipants](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[event_id] [int] NOT NULL,
	[user_id] [int] NOT NULL,
	[registered_at] [datetime] NOT NULL,
 CONSTRAINT [PK_EventParticipants] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_Event_User] UNIQUE NONCLUSTERED 
(
	[event_id] ASC,
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Events]    Script Date: 7/8/2025 7:13:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Events](
	[event_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[image_url] [nvarchar](255) NULL,
	[title] [nvarchar](255) NOT NULL,
	[created_by] [int] NOT NULL,
	[start_date] [datetime] NOT NULL,
	[end_date] [datetime] NOT NULL,
	[created_at] [datetime] NOT NULL,
	[status] [bit] NOT NULL,
	[area_id] [int] NULL,
 CONSTRAINT [PK_Events] PRIMARY KEY CLUSTERED 
(
	[event_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[faq_answer]    Script Date: 7/8/2025 7:13:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[faq_answer](
	[answer_id] [int] IDENTITY(1,1) NOT NULL,
	[question_id] [int] NOT NULL,
	[content] [nvarchar](max) NOT NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[answer_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[faq_question]    Script Date: 7/8/2025 7:13:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[faq_question](
	[question_id] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](255) NOT NULL,
	[tag_id] [int] NOT NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[question_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[faq_tag]    Script Date: 7/8/2025 7:13:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[faq_tag](
	[tag_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[tag_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Notification]    Script Date: 7/8/2025 7:13:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
/****** Object:  Table [dbo].[Notification_Receiver]    Script Date: 7/8/2025 7:13:38 AM ******/
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
/****** Object:  Table [dbo].[password_reset_tokens]    Script Date: 7/8/2025 7:13:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[password_reset_tokens](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[token] [varchar](255) NOT NULL,
	[created_at] [datetime] NULL,
	[is_used] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[token] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Posts]    Script Date: 7/8/2025 7:13:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Posts](
    [post_id] INT IDENTITY(1,1) NOT NULL,
    [title] NVARCHAR(255) NOT NULL,
    [content] NVARCHAR(MAX) NOT NULL,
    [created_by] INT NOT NULL,
    [created_at] DATETIME DEFAULT GETDATE(),
    [image] VARCHAR(255) NULL,
    [type] VARCHAR(20) NOT NULL CHECK ([type] IN ('common', 'partner', 'news')),
    [status] VARCHAR(20) NULL DEFAULT 'pending' CHECK ([status] IN ('rejected', 'approved', 'pending')),
    PRIMARY KEY CLUSTERED ([post_id]),
    FOREIGN KEY ([created_by]) REFERENCES [dbo].[Users]([user_id])
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];

/****** Object:  Table [dbo].[Comments]    Script Date: 7/8/2025 7:13:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comments](
    [comment_id] INT IDENTITY(1,1) NOT NULL,
    [post_id] INT NOT NULL,
    [user_id] INT NOT NULL,
    [content] VARCHAR(MAX) NOT NULL,
    [created_at] DATETIME DEFAULT GETDATE(),
    [parent_comment_id] INT NULL,
    PRIMARY KEY CLUSTERED ([comment_id]),
    FOREIGN KEY ([post_id]) REFERENCES [dbo].[Posts](post_id),
    FOREIGN KEY ([user_id]) REFERENCES [dbo].[Users](user_id),
    FOREIGN KEY ([parent_comment_id]) REFERENCES [dbo].[Comments](comment_id)
);

/****** Object:  Table [dbo].[PostReactions]    Script Date: 7/8/2025 7:13:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PostReactions](
    [id] INT IDENTITY(1,1) NOT NULL,
    [post_id] INT NOT NULL,
    [user_id] INT NOT NULL,
    [reaction_type] VARCHAR(20) NOT NULL,
    [reacted_at] DATETIME DEFAULT GETDATE(),
    PRIMARY KEY CLUSTERED ([id]),
    CONSTRAINT [UQ_UserPost] UNIQUE ([post_id], [user_id]),
    FOREIGN KEY ([post_id]) REFERENCES [dbo].[Posts](post_id) ON DELETE NO ACTION,
    FOREIGN KEY ([user_id]) REFERENCES [dbo].[Users](user_id)
);

/****** Object:  Table [dbo].[PartnerPostDetails]    Script Date: 7/8/2025 7:13:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PartnerPostDetails] (
    partner_post_id INT PRIMARY KEY,
    preferred_level NVARCHAR(100),
    preferred_gender NVARCHAR(10),
    preferred_time NVARCHAR(100),
    preferred_area NVARCHAR(100),
    note NVARCHAR(MAX),
    FOREIGN KEY (partner_post_id) REFERENCES [dbo].[Posts](post_id)
);

/****** Object:  Table [dbo].[CommentReports]    Script Date: 7/8/2025 7:13:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CommentReports] (
    report_id INT IDENTITY(1,1) PRIMARY KEY,
    comment_id INT NOT NULL,
    reported_by INT NOT NULL,
    reason NVARCHAR(255),
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (comment_id) REFERENCES [dbo].[Comments](comment_id) ON DELETE CASCADE,
    FOREIGN KEY (reported_by) REFERENCES [dbo].[Users](user_id)
);
/****** Object:  Table [dbo].[Promotion_Area]    Script Date: 7/8/2025 7:13:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Promotion_Area](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[promotion_id] [int] NOT NULL,
	[area_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Promotion_Service]    Script Date: 7/8/2025 7:13:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Promotion_Service](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[promotion_id] [int] NOT NULL,
	[service_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Promotions]    Script Date: 7/8/2025 7:13:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Promotions](
	[promotion_id] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](255) NOT NULL,
	[description] [nvarchar](max) NULL,
	[discount_percent] [decimal](5, 2) NULL,
	[discount_amount] [decimal](10, 2) NULL,
	[start_date] [datetime] NOT NULL,
	[end_date] [datetime] NOT NULL,
	[status] [varchar](20) NOT NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[promotion_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reviews]    Script Date: 7/8/2025 7:13:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reviews](
	[review_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[area_id] [int] NOT NULL,
	[rating] [int] NULL,
	[comment] [varchar](max) NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[review_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Shift]    Script Date: 7/8/2025 7:13:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Shift](
	[shift_id] [int] IDENTITY(1,1) NOT NULL,
	[area_id] [int] NOT NULL,
	[shift_name] [varchar](255) NOT NULL,
	[start_time] [time](7) NOT NULL,
	[end_time] [time](7) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[shift_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE TABLE [dbo].[Coaches](
    [coach_id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [area_id] INT NOT NULL,
    [fullname] NVARCHAR(100) NOT NULL,
    [email] NVARCHAR(100) NOT NULL,
    [phone] NVARCHAR(20) NOT NULL,
    [specialty] NVARCHAR(255) NULL,
    [description] NVARCHAR(MAX) NULL,
    [image_url] NVARCHAR(255) NULL,
    [status] NVARCHAR(50) DEFAULT 'active',
    CONSTRAINT FK_Coaches_Area FOREIGN KEY (area_id) REFERENCES [dbo].[Areas](area_id)
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BadmintonService] ADD  DEFAULT ('Active') FOR [status]
GO
ALTER TABLE [dbo].[BadmintonService] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[BadmintonService] ADD  DEFAULT ((0)) FOR [is_deleted]
GO
ALTER TABLE [dbo].[Banners] ADD  DEFAULT ((1)) FOR [status]
GO
ALTER TABLE [dbo].[Banners] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[ChatbotMessages] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[ChatbotResponses] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[ChatbotSessions] ADD  DEFAULT (getdate()) FOR [started_at]
GO
ALTER TABLE [dbo].[ChatbotSessions] ADD  DEFAULT ('active') FOR [session_status]
GO
ALTER TABLE [dbo].[EventParticipants] ADD  DEFAULT (getdate()) FOR [registered_at]
GO
ALTER TABLE [dbo].[Events] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Events] ADD  DEFAULT ((1)) FOR [status]
GO
ALTER TABLE [dbo].[faq_answer] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[faq_question] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[password_reset_tokens] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[password_reset_tokens] ADD  DEFAULT ((0)) FOR [is_used]
GO
ALTER TABLE [dbo].[Promotions] ADD  DEFAULT ('active') FOR [status]
GO
ALTER TABLE [dbo].[Promotions] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Reviews] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Area_Image]  WITH CHECK ADD FOREIGN KEY([area_id])
REFERENCES [dbo].[Areas] ([area_id])
GO
ALTER TABLE [dbo].[Areas]  WITH CHECK ADD FOREIGN KEY([manager_id])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[Areas_Services]  WITH CHECK ADD FOREIGN KEY([area_id])
REFERENCES [dbo].[Areas] ([area_id])
GO
ALTER TABLE [dbo].[Areas_Services]  WITH CHECK ADD FOREIGN KEY([service_id])
REFERENCES [dbo].[BadmintonService] ([service_id])
GO
ALTER TABLE [dbo].[Booking_Services]  WITH CHECK ADD FOREIGN KEY([booking_id])
REFERENCES [dbo].[Bookings] ([booking_id])
GO
ALTER TABLE [dbo].[Booking_Services]  WITH CHECK ADD FOREIGN KEY([service_id])
REFERENCES [dbo].[BadmintonService] ([service_id])
GO
ALTER TABLE [dbo].[Bookings]  WITH CHECK ADD FOREIGN KEY([court_id])
REFERENCES [dbo].[Courts] ([court_id])
GO
ALTER TABLE [dbo].[Bookings]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[ChatbotMessages]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[ChatbotSessions]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD FOREIGN KEY([post_id])
REFERENCES [dbo].[Posts] ([post_id])
GO
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[Courts]  WITH CHECK ADD FOREIGN KEY([area_id])
REFERENCES [dbo].[Areas] ([area_id])
GO
ALTER TABLE [dbo].[EventParticipants]  WITH CHECK ADD  CONSTRAINT [FK_EventParticipants_Events] FOREIGN KEY([event_id])
REFERENCES [dbo].[Events] ([event_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EventParticipants] CHECK CONSTRAINT [FK_EventParticipants_Events]
GO
ALTER TABLE [dbo].[EventParticipants]  WITH CHECK ADD  CONSTRAINT [FK_EventParticipants_Users] FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EventParticipants] CHECK CONSTRAINT [FK_EventParticipants_Users]
GO
ALTER TABLE [dbo].[Events]  WITH CHECK ADD  CONSTRAINT [FK_Events_Areas] FOREIGN KEY([area_id])
REFERENCES [dbo].[Areas] ([area_id])
GO
ALTER TABLE [dbo].[Events] CHECK CONSTRAINT [FK_Events_Areas]
GO
ALTER TABLE [dbo].[Events]  WITH CHECK ADD  CONSTRAINT [FK_Events_Users] FOREIGN KEY([created_by])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[Events] CHECK CONSTRAINT [FK_Events_Users]
GO
ALTER TABLE [dbo].[faq_answer]  WITH CHECK ADD FOREIGN KEY([question_id])
REFERENCES [dbo].[faq_question] ([question_id])
GO
ALTER TABLE [dbo].[faq_question]  WITH CHECK ADD FOREIGN KEY([tag_id])
REFERENCES [dbo].[faq_tag] ([tag_id])
GO
ALTER TABLE [dbo].[password_reset_tokens]  WITH CHECK ADD  CONSTRAINT [FK_password_reset_user] FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[password_reset_tokens] CHECK CONSTRAINT [FK_password_reset_user]
GO
ALTER TABLE [dbo].[PostReactions]  WITH CHECK ADD FOREIGN KEY([post_id])
REFERENCES [dbo].[Posts] ([post_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PostReactions]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[Posts]  WITH CHECK ADD FOREIGN KEY([created_by])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[Promotion_Area]  WITH CHECK ADD FOREIGN KEY([area_id])
REFERENCES [dbo].[Areas] ([area_id])
GO
ALTER TABLE [dbo].[Promotion_Area]  WITH CHECK ADD FOREIGN KEY([promotion_id])
REFERENCES [dbo].[Promotions] ([promotion_id])
GO
ALTER TABLE [dbo].[Promotion_Service]  WITH CHECK ADD FOREIGN KEY([promotion_id])
REFERENCES [dbo].[Promotions] ([promotion_id])
GO
ALTER TABLE [dbo].[Promotion_Service]  WITH CHECK ADD FOREIGN KEY([service_id])
REFERENCES [dbo].[BadmintonService] ([service_id])
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD FOREIGN KEY([area_id])
REFERENCES [dbo].[Areas] ([area_id])
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[Shift]  WITH CHECK ADD FOREIGN KEY([area_id])
REFERENCES [dbo].[Areas] ([area_id])
GO
ALTER TABLE [dbo].[Areas]  WITH CHECK ADD  CONSTRAINT [chk_area_time] CHECK  (([open_time]<[close_time]))
GO
ALTER TABLE [dbo].[Areas] CHECK CONSTRAINT [chk_area_time]
GO
ALTER TABLE [dbo].[BadmintonService]  WITH CHECK ADD CHECK  (([price]>=(0)))
GO
ALTER TABLE [dbo].[Bookings]  WITH CHECK ADD  CONSTRAINT [chk_booking_time] CHECK  (([start_time]<[end_time]))
GO
ALTER TABLE [dbo].[Bookings] CHECK CONSTRAINT [chk_booking_time]
GO
ALTER TABLE [dbo].[Bookings]  WITH CHECK ADD CHECK  (([rating]>=(1) AND [rating]<=(5)))
GO
ALTER TABLE [dbo].[ChatbotMessages]  WITH CHECK ADD CHECK  (([sender_type]='bot' OR [sender_type]='user'))
GO
ALTER TABLE [dbo].[Courts]  WITH CHECK ADD CHECK  (([price]>=(0)))
GO
ALTER TABLE [dbo].[Events]  WITH CHECK ADD  CONSTRAINT [CHK_Events_Date] CHECK  (([start_date]<[end_date]))
GO
ALTER TABLE [dbo].[Events] CHECK CONSTRAINT [CHK_Events_Date]
GO
ALTER TABLE [dbo].[Posts]  WITH CHECK ADD CHECK  (([status]='rejected' OR [status]='approved' OR [status]='pending'))
GO
ALTER TABLE [dbo].[Posts]  WITH CHECK ADD CHECK  (([type]='common' OR [type]='partner' OR [type]='news'))
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD CHECK  (([rating]>=(1) AND [rating]<=(5)))
GO
USE [master]
GO
ALTER DATABASE [SWP] SET  READ_WRITE 
GO
