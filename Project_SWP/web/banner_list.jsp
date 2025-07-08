<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
    <head>
        <title>Danh sách Banner</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f5f5f5;
                padding: 0 280px 0 0;
            }

            /* Main content container */
            .main-content {
                max-width: 1700px;
                margin: 0 auto;
                width: 100%;
            }

            /* Adjust for sidebar when present */
            .with-sidebar {
                margin-left: 280px;
                padding: 20px;
            }

            .header {
                background: #fff;
                padding: 20px 30px;
                border-radius: 10px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                margin-bottom: 30px;
                display: flex;
                align-items: center;
                justify-content: space-between;
                flex-wrap: wrap;
            }

            .header h2 {
                color: #333;
                font-size: 24px;
                font-weight: 600;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .header h2::before {
                content: "🖼️";
                font-size: 28px;
            }

            .user-info {
                display: flex;
                align-items: center;
                gap: 10px;
                color: #666;
            }

            .user-info::before {
                content: "👤";
            }

            .logout-button {
                background: #dc3545;
                color: white;
                padding: 8px 16px;
                border-radius: 6px;
                text-decoration: none;
                font-weight: 600;
                transition: all 0.3s ease;
            }

            .logout-button:hover {
                background: #c82333;
                transform: translateY(-2px);
            }

            .alert {
                padding: 15px 20px;
                margin-bottom: 20px;
                border-radius: 8px;
                background: #d4edda;
                border: 1px solid #c3e6cb;
                color: #155724;
                font-weight: 500;
            }

            .toolbar {
                background: #fff;
                padding: 20px 30px;
                border-radius: 10px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                margin-bottom: 20px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                flex-wrap: wrap;
                gap: 15px;
            }

            .add-btn {
                background: #28a745;
                color: white;
                padding: 12px 24px;
                border: none;
                border-radius: 8px;
                text-decoration: none;
                font-weight: 600;
                font-size: 14px;
                display: flex;
                align-items: center;
                gap: 8px;
                transition: all 0.3s ease;
                white-space: nowrap;
            }

            .add-btn:hover {
                background: #218838;
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(40, 167, 69, 0.3);
            }

            .add-btn::before {
                content: "➕";
                font-size: 16px;
            }

            .search-box {
                display: flex;
                align-items: center;
                gap: 10px;
                flex-wrap: wrap;
            }

            .search-input {
                padding: 10px 15px;
                border: 2px solid #e0e0e0;
                border-radius: 8px;
                font-size: 14px;
                width: 300px;
                max-width: 100%;
                transition: border-color 0.3s ease;
            }

            .search-input:focus {
                outline: none;
                border-color: #007bff;
            }

            .search-btn {
                background: #007bff;
                color: white;
                padding: 10px 20px;
                border: none;
                border-radius: 8px;
                cursor: pointer;
                font-weight: 600;
                transition: background 0.3s ease;
                white-space: nowrap;
            }

            .search-btn:hover {
                background: #0056b3;
            }

            .table-container {
                background: #fff;
                border-radius: 10px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                overflow: hidden;
                overflow-x: auto;
            }

            .table-header {
                background: #f8f9fa;
                padding: 20px 30px;
                border-bottom: 2px solid #e9ecef;
            }

            .table-title {
                font-size: 18px;
                font-weight: 600;
                color: #333;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                background: white;
                min-width: 800px;
            }

            th {
                background: #f8f9fa;
                padding: 15px 20px;
                text-align: left;
                font-weight: 600;
                color: #555;
                font-size: 14px;
                border-bottom: 2px solid #e9ecef;
                white-space: nowrap;
            }

            td {
                padding: 20px;
                border-bottom: 1px solid #e9ecef;
                vertical-align: middle;
            }

            tr:hover {
                background: #f8f9fa;
                transition: background 0.3s ease;
            }

            .banner-image {
                width: 120px;
                height: 80px;
                object-fit: cover;
                border-radius: 8px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
                transition: transform 0.3s ease;
            }

            .banner-image:hover {
                transform: scale(1.05);
            }

            .banner-title {
                font-weight: 600;
                color: #333;
                margin-bottom: 5px;
                word-wrap: break-word;
            }

            .banner-caption {
                color: #666;
                font-size: 13px;
                line-height: 1.4;
                word-wrap: break-word;
            }

            .status-badge {
                padding: 6px 12px;
                border-radius: 20px;
                font-size: 12px;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                white-space: nowrap;
            }

            .status-active {
                background: #d4edda;
                color: #155724;
            }

            .status-inactive {
                background: #f8d7da;
                color: #721c24;
            }

            .action-buttons {
                display: flex;
                gap: 8px;
                align-items: center;
                flex-wrap: wrap;
            }

            .btn {
                padding: 8px 16px;
                border-radius: 6px;
                text-decoration: none;
                font-size: 12px;
                font-weight: 600;
                transition: all 0.3s ease;
                border: none;
                cursor: pointer;
                white-space: nowrap;
            }

            .btn-edit {
                background: #ffc107;
                color: #212529;
            }

            .btn-edit:hover {
                background: #e0a800;
                transform: translateY(-2px);
            }

            .btn-delete {
                background: #dc3545;
                color: white;
            }

            .btn-delete:hover {
                background: #c82333;
                transform: translateY(-2px);
            }

            .delete-form {
                display: inline;
            }

            .pagination {
                display: flex;
                justify-content: center;
                align-items: center;
                padding: 20px;
                gap: 10px;
                flex-wrap: wrap;
            }

            .pagination a {
                padding: 8px 12px;
                background: #007bff;
                color: white;
                text-decoration: none;
                border-radius: 6px;
                font-weight: 600;
                transition: background 0.3s ease;
            }

            .pagination a:hover {
                background: #0056b3;
            }

            .pagination .active {
                background: #0056b3;
            }

            .no-data {
                text-align: center;
                padding: 60px 20px;
                color: #666;
            }

            .no-data::before {
                content: "📋";
                font-size: 48px;
                display: block;
                margin-bottom: 20px;
            }

            /* MODAL STYLES - Redesigned to match the image */
            .modal-bg {
                position: fixed;
                top: 0;
                left: 0;
                width: 100vw;
                height: 100vh;
                background: rgba(0,0,0,0.5);
                display: flex;
                align-items: center;
                justify-content: center;
                z-index: 1000;
                backdrop-filter: blur(2px);
            }

            .modal-content {
                background: #fff;
                border-radius: 12px;
                width: 450px;
                max-width: 90vw;
                max-height: 90vh;
                overflow-y: auto;
                box-shadow: 0 20px 40px rgba(0,0,0,0.3);
                animation: modalSlideIn 0.3s ease-out;
            }

            .modal-header {
                background: #007bff;
                color: white;
                padding: 16px 24px;
                border-radius: 12px 12px 0 0;
                display: flex;
                justify-content: space-between;
                align-items: center;
                position: relative;
            }

            .modal-title {
                font-size: 18px;
                font-weight: 600;
                margin: 0;
            }

            .modal-close {
                background: none;
                border: none;
                color: white;
                font-size: 24px;
                cursor: pointer;
                padding: 0;
                width: 30px;
                height: 30px;
                display: flex;
                align-items: center;
                justify-content: center;
                border-radius: 50%;
                transition: background 0.3s ease;
            }

            .modal-close:hover {
                background: rgba(255,255,255,0.2);
            }

            .modal-body {
                padding: 24px;
            }

            .form-group {
                margin-bottom: 20px;
            }

            .form-group label {
                display: block;
                margin-bottom: 6px;
                font-weight: 600;
                color: #333;
                font-size: 14px;
            }

            .form-group input[type="text"],
            .form-group input[type="file"],
            .form-group select {
                width: 100%;
                padding: 10px 12px;
                border: 2px solid #e1e5e9;
                border-radius: 6px;
                font-size: 14px;
                transition: border-color 0.3s ease;
                background: #fff;
            }

            .form-group input[type="text"]:focus,
            .form-group input[type="file"]:focus,
            .form-group select:focus {
                outline: none;
                border-color: #007bff;
                box-shadow: 0 0 0 3px rgba(0,123,255,0.1);
            }

            .form-group input[type="file"] {
                padding: 8px 12px;
                background: #f8f9fa;
            }

            .checkbox-group {
                display: flex;
                align-items: center;
                gap: 8px;
                margin-top: 16px;
            }

            .checkbox-group input[type="checkbox"] {
                width: 18px;
                height: 18px;
                cursor: pointer;
            }

            .checkbox-group label {
                margin: 0;
                font-weight: 500;
                cursor: pointer;
            }

            .image-preview {
                margin-top: 10px;
                border-radius: 6px;
                max-width: 120px;
                height: auto;
                border: 2px solid #e1e5e9;
            }

            .modal-footer {
                padding: 16px 24px;
                border-top: 1px solid #e9ecef;
                display: flex;
                justify-content: flex-end;
                gap: 12px;
                background: #f8f9fa;
                border-radius: 0 0 12px 12px;
            }

            .modal-btn {
                padding: 10px 20px;
                border: none;
                border-radius: 6px;
                font-size: 14px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                min-width: 80px;
            }

            .modal-btn-primary {
                background: #007bff;
                color: white;
            }

            .modal-btn-primary:hover {
                background: #0056b3;
                transform: translateY(-1px);
            }

            .modal-btn-secondary {
                background: #6c757d;
                color: white;
            }

            .modal-btn-secondary:hover {
                background: #545b62;
                transform: translateY(-1px);
            }

            .modal-btn-success {
                background: #28a745;
                color: white;
            }

            .modal-btn-success:hover {
                background: #218838;
                transform: translateY(-1px);
            }

            @keyframes modalSlideIn {
                from {
                    opacity: 0;
                    transform: translateY(-20px) scale(0.95);
                }
                to {
                    opacity: 1;
                    transform: translateY(0) scale(1);
                }
            }

            /* Responsive Design */
            @media (max-width: 1024px) {
                .with-sidebar {
                    margin-left: 0;
                    padding: 15px;
                }

                .search-input {
                    width: 250px;
                }
            }

            @media (max-width: 768px) {
                body {
                    padding: 10px;
                }

                .header {
                    flex-direction: column;
                    gap: 15px;
                    text-align: center;
                    padding: 15px 20px;
                }

                .toolbar {
                    flex-direction: column;
                    gap: 15px;
                    padding: 15px 20px;
                }

                .search-box {
                    width: 100%;
                    justify-content: center;
                }

                .search-input {
                    width: 100%;
                    max-width: 300px;
                }

                .table-header {
                    padding: 15px 20px;
                }

                table {
                    font-size: 12px;
                    min-width: 700px;
                }

                th, td {
                    padding: 12px 10px;
                }

                .banner-image {
                    width: 80px;
                    height: 60px;
                }

                .action-buttons {
                    flex-direction: column;
                    gap: 5px;
                    align-items: stretch;
                }

                .btn {
                    text-align: center;
                }

                .modal-content {
                    width: 95vw;
                    margin: 20px;
                }

                .modal-body {
                    padding: 20px;
                }
            }

            @media (max-width: 480px) {
                .header h2 {
                    font-size: 20px;
                }

                .toolbar {
                    padding: 10px 15px;
                }

                .add-btn {
                    padding: 10px 20px;
                    font-size: 13px;
                }

                .search-input {
                    padding: 8px 12px;
                    font-size: 13px;
                }

                .search-btn {
                    padding: 8px 16px;
                    font-size: 13px;
                }

                th, td {
                    padding: 10px 8px;
                }

                .banner-image {
                    width: 60px;
                    height: 45px;
                }

                .modal-body {
                    padding: 16px;
                }

                .modal-footer {
                    padding: 12px 16px;
                }
            }
        </style>
    </head>
    <body>
        <jsp:include page="Sidebar.jsp"/>
        <div class="main-content with-sidebar">
            <div class="header">
                <h2>Quản Lý Banner</h2>
                <div class="user-info">
                    <a href="login" class="logout-button">Đăng xuất</a>
                </div>
            </div>
            <c:if test="${not empty msg}">
                <div class="alert">${msg}</div>
            </c:if>
            <div class="toolbar">
                <a href="#" id="showAddBannerModal" class="add-btn">Thêm Banner</a>
                <div class="search-box">
                    <input type="text" class="search-input" placeholder="Tìm kiếm theo tiêu đề...">
                    <button class="search-btn">🔍 Tìm</button>
                </div>
            </div>
            <div class="table-container">
                <div class="table-header">
                    <div class="table-title">Danh sách Banner</div>
                </div>
                <c:choose>
                    <c:when test="${empty bannerList}">
                        <div class="no-data">
                            <h3>Chưa có banner nào</h3>
                            <p>Hãy thêm banner đầu tiên cho website của bạn!</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <table>
                            <thead>
                                <tr>
                                    <th>Ảnh</th>
                                    <th>Tiêu đề</th>
                                    <th>Chú thích</th>
                                    <th>Trạng thái</th>
                                    <th>Hành động</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="banner" items="${bannerList}">
                                    <tr
                                        data-id="${banner.id}"
                                        data-title="${banner.title}"
                                        data-caption="${banner.caption}"
                                        data-img="${pageContext.request.contextPath}/${banner.imageUrl}"
                                        data-status="${banner.status}">
                                        <td>
                                            <img src="${pageContext.request.contextPath}/${banner.imageUrl}"
                                                 class="banner-image"
                                                 alt="${banner.title}"/>
                                        </td>
                                        <td><div class="banner-title">${banner.title}</div></td>
                                        <td><div class="banner-caption">${banner.caption}</div></td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${banner.status}">
                                                    <span class="status-badge status-active">Hiện</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="status-badge status-inactive">Ẩn</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <div class="action-buttons">
                                                <a href="#" class="btn btn-edit editBannerBtn">✏️ Sửa</a>
                                                <form action="banner-delete" method="post" class="delete-form">
                                                    <input type="hidden" name="id" value="${banner.id}"/>
                                                    <button type="submit" class="btn btn-delete"
                                                            onclick="return confirm('Bạn có chắc chắn muốn xóa banner này?')">
                                                        🗑️ Xóa
                                                    </button>
                                                </form>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- MODAL: Thêm Banner -->
        <div id="addBannerModal" class="modal-bg" style="display:none;">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 class="modal-title">Thêm Banner</h3>
                    <button class="modal-close" id="closeAddBannerModal">&times;</button>
                </div>
                <form action="banner-add" method="post" enctype="multipart/form-data">
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="addBannerImage">Ảnh banner</label>
                            <input type="file" name="image" id="addBannerImage" accept="image/*" required/>
                        </div>
                        
                        <div class="form-group">
                            <label for="addBannerTitle">Tiêu đề</label>
                            <input type="text" name="title" id="addBannerTitle" placeholder="Nhập tiêu đề banner" required/>
                        </div>
                        
                        <div class="form-group">
                            <label for="addBannerCaption">Chú thích</label>
                            <input type="text" name="caption" id="addBannerCaption" placeholder="Nhập chú thích (không bắt buộc)"/>
                        </div>
                        
                        <div class="checkbox-group">
                            <input type="checkbox" name="status" id="addBannerStatus" value="1" checked/>
                            <label for="addBannerStatus">Hiển thị banner</label>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="modal-btn modal-btn-secondary" id="cancelAddBanner">Hủy</button>
                        <button type="submit" class="modal-btn modal-btn-success">Thêm</button>
                    </div>
                </form>
            </div>
        </div>

        <!-- MODAL: Sửa Banner -->
        <div id="editBannerModal" class="modal-bg" style="display:none;">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 class="modal-title">Sửa Banner</h3>
                    <button class="modal-close" id="closeEditBannerModal">&times;</button>
                </div>
                <form id="editBannerForm" action="banner-edit" method="post" enctype="multipart/form-data">
                    <div class="modal-body">
                        <input type="hidden" name="id" id="editBannerId"/>
                        
                        <div class="form-group">
                            <label for="editBannerImage">Ảnh mới (tùy chọn)</label>
                            <input type="file" name="image" id="editBannerImage" accept="image/*"/>
                            <img src="" id="editBannerImgPreview" class="image-preview" style="display:none;"/>
                        </div>
                        
                        <div class="form-group">
                            <label for="editBannerTitle">Tiêu đề</label>
                            <input type="text" name="title" id="editBannerTitle" placeholder="Nhập tiêu đề banner" required/>
                        </div>
                        
                        <div class="form-group">
                            <label for="editBannerCaption">Chú thích</label>
                            <input type="text" name="caption" id="editBannerCaption" placeholder="Nhập chú thích (không bắt buộc)"/>
                        </div>
                        
                        <div class="checkbox-group">
                            <input type="checkbox" name="status" id="editBannerStatus" value="1"/>
                            <label for="editBannerStatus">Hiển thị banner</label>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="modal-btn modal-btn-secondary" id="cancelEditBanner">Hủy</button>
                        <button type="submit" class="modal-btn modal-btn-primary">Cập nhật</button>
                    </div>
                </form>
            </div>
        </div>

        <script>
            // Modal Thêm Banner
            document.getElementById('showAddBannerModal').onclick = function (e) {
                e.preventDefault();
                document.getElementById('addBannerModal').style.display = 'flex';
            };
            
            document.getElementById('closeAddBannerModal').onclick = function () {
                document.getElementById('addBannerModal').style.display = 'none';
            };
            
            document.getElementById('cancelAddBanner').onclick = function () {
                document.getElementById('addBannerModal').style.display = 'none';
            };

            // Modal Sửa Banner
            var editBtns = document.querySelectorAll('.editBannerBtn');
            editBtns.forEach(function (btn) {
                btn.onclick = function (e) {
                    e.preventDefault();
                    var tr = btn.closest('tr');
                    // Fill dữ liệu vào modal
                    document.getElementById('editBannerId').value = tr.getAttribute('data-id');
                    document.getElementById('editBannerTitle').value = tr.getAttribute('data-title');
                    document.getElementById('editBannerCaption').value = tr.getAttribute('data-caption');
                    
                    var imgPreview = document.getElementById('editBannerImgPreview');
                    imgPreview.src = tr.getAttribute('data-img');
                    imgPreview.style.display = 'block';
                    
                    document.getElementById('editBannerStatus').checked = (tr.getAttribute('data-status') === 'true');
                    document.getElementById('editBannerModal').style.display = 'flex';
                }
            });
            
            document.getElementById('closeEditBannerModal').onclick = function () {
                document.getElementById('editBannerModal').style.display = 'none';
            };
            
            document.getElementById('cancelEditBanner').onclick = function () {
                document.getElementById('editBannerModal').style.display = 'none';
            };

            // Click outside modal to close
            document.addEventListener('click', function(e) {
                if (e.target.classList.contains('modal-bg')) {
                    e.target.style.display = 'none';
                }
            });

            // Preview image when selecting new file
            document.getElementById('editBannerImage').addEventListener('change', function(e) {
                var file = e.target.files[0];
                if (file) {
                    var reader = new FileReader();
                    reader.onload = function(e) {
                        var imgPreview = document.getElementById('editBannerImgPreview');
                        imgPreview.src = e.target.result;
                        imgPreview.style.display = 'block';
                    };
                    reader.readAsDataURL(file);
                }
            });
        </script>
    </body>
</html>