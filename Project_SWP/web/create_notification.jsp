<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html>
<head>
    <title>Tạo Thông Báo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet"/>
    <script src="https://cdn.ckeditor.com/ckeditor5/39.0.1/classic/ckeditor.js"></script>
    <style>
        /* General body styling */
        body {
            overflow-x: hidden;
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background-color: #f5f6fa;
            color: #333;
            line-height: 1.6;
        }

        /* Container optimization */
        .container-fluid {
            padding: 20px 24px;
            max-width: 1400px;
        }

        /* Navbar styling */
        .navbar {
            background: linear-gradient(90deg, #1a3c34, #2a5c54);
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .navbar-brand {
            font-weight: 700;
            font-size: 1.4rem;
        }

        .navbar .btn-outline-light {
            padding: 6px 14px;
            font-size: 13px;
            font-weight: 500;
            border-radius: 6px;
            transition: all 0.2s ease;
            border: 1px solid #fff;
        }

        .navbar .btn-outline-light:hover {
            background: #fff;
            color: #1a3c34;
            transform: translateY(-1px);
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .navbar .btn-outline-light i {
            font-size: 12px;
            margin-right: 4px;
        }

        /* Card styling */
        .card {
            border: none;
            border-radius: 8px;
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
            background: #fff;
            padding: 24px;
        }

        /* Form styling */
        .form-label {
            font-weight: 600;
            color: #1a3c34;
            font-size: 14px;
        }

        .form-control, .form-control-file {
            border-radius: 6px;
            border: 1px solid #ced4da;
            font-size: 14px;
            padding: 8px 12px;
            transition: border-color 0.2s ease, box-shadow 0.2s ease;
        }

        .form-control:focus {
            border-color: #17a2b8;
            box-shadow: 0 0 0 2px rgba(23, 162, 184, 0.2);
        }

        /* CKEditor styling */
        .ck-editor__editable {
            min-height: 200px;
            border-radius: 6px;
            border: 1px solid #ced4da;
        }

        .ck-editor__editable:focus {
            border-color: #17a2b8;
            box-shadow: 0 0 0 2px rgba(23, 162, 184, 0.2);
        }

        /* Button styling */
        .btn-primary, .btn-secondary {
            padding: 8px 16px;
            font-size: 14px;
            font-weight: 500;
            border-radius: 6px;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .btn-primary {
            background: #17a2b8;
            border: none;
        }

        .btn-primary:hover {
            background: #138496;
            transform: translateY(-1px);
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .btn-secondary {
            background: #6c757d;
            border: none;
        }

        .btn-secondary:hover {
            background: #5a6268;
            transform: translateY(-1px);
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .btn i {
            font-size: 12px;
            margin-right: 6px;
        }

        /* Alert styling */
        .alert {
            border-radius: 6px;
            font-size: 14px;
            padding: 12px;
        }

        /* Header styling */
        h2 {
            font-weight: 700;
            color: #1a3c34;
            font-size: 1.75rem;
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .container-fluid {
                padding: 12px;
            }

            .card {
                padding: 16px;
            }

            .form-control, .form-control-file {
                font-size: 13px;
                padding: 6px 10px;
            }

            .btn-primary, .btn-secondary {
                font-size: 13px;
                padding: 6px 12px;
                width: 100%;
                margin-bottom: 8px;
            }

            h2 {
                font-size: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container-fluid">
            
            <div class="d-flex">
                <a class="btn btn-outline-light btn-sm" href="login">
                    <i class="fas fa-sign-out-alt me-1"></i> Đăng xuất
                </a>
            </div>
        </div>
    </nav>

    <div class="container-fluid mt-4">
        <div class="row">
            <div class="col-md-3">
                <jsp:include page="Sidebar.jsp"/>
            </div>
            <div class="col-md-9">
                <div class="card">
                    <div class="card-body">
                        <h2 class="mb-4"><i class="bi bi-plus-circle me-2"></i> Tạo Thông Báo Mới</h2>

                        <c:if test="${not empty error}">
                            <div class="alert alert-danger">${error}</div>
                        </c:if>

                        <form method="post"
                              action="${pageContext.request.contextPath}/create-notification"
                              enctype="multipart/form-data"
                              id="notificationForm">

                            <div class="mb-4">
                                <label class="form-label">Tiêu đề</label>
                                <input type="text" name="title" class="form-control" required maxlength="255" placeholder="Nhập tiêu đề thông báo"/>
                            </div>

                            <div class="mb-4">
                                <label class="form-label">Nội dung</label>
                                <textarea name="content" id="hiddenContent" style="display:none;"></textarea>
                                <div id="editor"></div>
                            </div>

                            <div class="mb-4">
                                <label class="form-label">File đính kèm (ảnh, PDF, Word)</label>
                                <input type="file" name="file" class="form-control" accept=".jpg,.jpeg,.png,.pdf,.doc,.docx"/>
                            </div>

                            <div class="mb-4">
                                <label class="form-label">Thời gian dự kiến gửi</label>
                                <%
                                    LocalDateTime now = LocalDateTime.now();
                                    String minTime = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm"));
                                %>
                                <input type="datetime-local" name="scheduledTime" class="form-control" required min="<%= minTime %>" placeholder="Chọn thời gian"/>
                            </div>

                            <div class="d-flex gap-2">
                                <button type="submit" class="btn btn-primary"><i class="bi bi-save me-1"></i> Tạo Thông Báo</button>
                                <a href="${pageContext.request.contextPath}/notification_list" class="btn btn-secondary">
                                    <i class="bi bi-arrow-left me-1"></i> Quay lại
                                </a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        let editorInstance;

        window.addEventListener('DOMContentLoaded', () => {
            ClassicEditor
                .create(document.querySelector('#editor'), {
                    toolbar: ['heading', '|', 'bold', 'italic', 'link', 'bulletedList', 'numberedList', '|', 'undo', 'redo'],
                    placeholder: 'Nhập nội dung thông báo...'
                })
                .then(editor => {
                    editorInstance = editor;
                })
                .catch(error => {
                    console.error(error);
                });

            document.getElementById("notificationForm").addEventListener("submit", function () {
                if (editorInstance) {
                    document.getElementById("hiddenContent").value = editorInstance.getData();
                }
            });
        });
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>